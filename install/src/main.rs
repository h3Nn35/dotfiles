use std::fs;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::os::unix::fs::symlink;
use dialoguer::{MultiSelect, theme::ColorfulTheme};
use std::process::Command;

// Funktion zur Erkennung des Paketmanagers
fn detect_package_manager() -> Option<&'static str> {
    if Command::new("apt").output().is_ok() {
        Some("apt")
    } else if Command::new("yum").output().is_ok() {
        Some("yum")
    } else if Command::new("pacman").output().is_ok() {
        Some("pacman")
    } else if Command::new("dnf").output().is_ok() {
        Some("dnf")
    } else if Command::new("zypper").output().is_ok() {
        Some("zypper")
    } else {
        None
    }
}

// Funktion zur Installation eines Pakets
fn install_package(package_manager: &str, package: &str) -> io::Result<()> {
    let status = match package_manager {
        "apt" => Command::new("sudo").arg("apt").arg("install").arg("-y").arg(package).status(),
        "yum" => Command::new("sudo").arg("yum").arg("install").arg("-y").arg(package).status(),
        "pacman" => Command::new("sudo").arg("pacman").arg("-Sy").arg("--noconfirm").arg(package).status(),
        "dnf" => Command::new("sudo").arg("dnf").arg("install").arg("-y").arg(package).status(),
        "zypper" => Command::new("sudo").arg("zypper").arg("install").arg("-y").arg(package).status(),
        _ => return Err(io::Error::new(io::ErrorKind::Other, "Unsupported package manager")),
    }?;
    if status.success() {
        Ok(())
    } else {
        Err(io::Error::new(io::ErrorKind::Other, "Package installation failed"))
    }
}

fn main() -> io::Result<()> {
    let lookup_path = "../lookup.txt";

    // Überprüfen, ob die Lookup-Datei existiert
    if !Path::new(lookup_path).exists() {
        eprintln!("Lookup file not found: {}", lookup_path);
        std::process::exit(1);
    }

    // Datei öffnen und Zeilen lesen
    let file = File::open(lookup_path)?;
    let reader = io::BufReader::new(file);

    // Programme und ihre Konfigurationsdateien sammeln
    let mut programs = Vec::new();
    let mut lookup_data = Vec::new();

    for line in reader.lines() {
        let line = line?;
        let parts: Vec<&str> = line.split_whitespace().collect();

        if parts.len() != 2 {
            eprintln!("Invalid line format: {}", line);
            continue;
        }

        let source = parts[0].to_string();
        let destination = parts[1].to_string();

        let program = source.split('/').nth(1).unwrap_or_default().to_string();
        if !programs.contains(&program) {
            programs.push(program.clone());
        }

        lookup_data.push((program, source, destination));
    }

    // Auswahl der Programme
    let selections = MultiSelect::with_theme(&ColorfulTheme::default())
        .with_prompt("Select programs to install")
        .items(&programs)
        .interact()?;

    let selected_programs: Vec<String> = selections.into_iter().map(|i| programs[i].clone()).collect();

    // Paketmanager erkennen
    let package_manager = detect_package_manager().unwrap_or_else(|| {
        eprintln!("Unsupported package manager");
        std::process::exit(1);
    });
    println!("Detected package manager: {}", package_manager);

    // Installation und Symlink-Erstellung
    for program in selected_programs {
        // Programm installieren
        println!("Installing {}...", program);
        if let Err(e) = install_package(package_manager, &program) {
            eprintln!("Failed to install {}: {}", program, e);
            continue;
        }

        // Symlinks erstellen
        for (prog, source, destination) in &lookup_data {
            if prog == &program {
                let source_path = Path::new(source);
                let destination_path = Path::new(destination);

                // Verzeichnis für das Ziel erstellen, falls es nicht existiert
                if let Some(parent) = destination_path.parent() {
                    fs::create_dir_all(parent)?;
                }

                // Wenn die Zieldatei existiert, benenne sie um
                if destination_path.exists() {
                    let backup_destination = destination_path.with_extension("bak");
                    fs::rename(destination_path, &backup_destination)?;
                    println!("Existing file renamed: {:?} -> {:?}", destination_path, backup_destination);
                }

                // Symlink erstellen
                symlink(source_path, destination_path)?;
                println!("Symlink created: {:?} -> {:?}", destination_path, source_path);
            }
        }
    }

    Ok(())
}
