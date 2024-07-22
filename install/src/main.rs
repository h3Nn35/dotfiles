use std::fs;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;
use std::os::unix::fs::symlink;

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

    for line in reader.lines() {
        let line = line?;
        let parts: Vec<&str> = line.split_whitespace().collect();

        if parts.len() != 2 {
            eprintln!("Invalid line format: {}", line);
            continue;
        }

        let source = Path::new(parts[0]);
        let destination = Path::new(parts[1]);

        // Überprüfen, ob die Quelldatei existiert
        if !source.exists() {
            eprintln!("Source file not found: {:?}", source);
            continue;
        }

        // Verzeichnis für das Ziel erstellen, falls es nicht existiert
        if let Some(parent) = destination.parent() {
            fs::create_dir_all(parent)?;
        }

        // Wenn die Zieldatei existiert, benenne sie um
        if destination.exists() {
            let backup_destination = destination.with_extension("bak");
            fs::rename(destination, &backup_destination)?;
            println!("Existing file renamed: {:?} -> {:?}", destination, backup_destination);
        }

        // Symlink erstellen
        symlink(source, destination)?;
        println!("Symlink created: {:?} -> {:?}", destination, source);
    }

    Ok(())
}
