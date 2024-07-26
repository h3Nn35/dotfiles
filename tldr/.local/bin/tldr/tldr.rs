use std::env;
use std::process::Command;

fn fetch_cheat_sheet(query: &str, full_output: bool) {
    let output = Command::new("curl")
        .arg(format!("cheat.sh/{}", query))
        .output()
        .expect("Failed to execute curl");

    let response = String::from_utf8_lossy(&output.stdout);

    if full_output {
        println!("{}", response);
    } else {
        if let Some(tldr_start) = response.find("tldr:") {
            println!("{}", &response[tldr_start..]);
        } else {
            println!("{}", response);
        }
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        eprintln!("Usage: cargo run -- [-f] <query>");
        std::process::exit(1);
    }

    let mut full_output = false;
    let query: &str;

    if args[1] == "-f" {
        full_output = true;
        query = &args[2];
    } else if args.len() > 2 && args[2] == "-f" {
        full_output = true;
        query = &args[1];
    } else {
        query = &args[1];
    }

    fetch_cheat_sheet(query, full_output);
}

