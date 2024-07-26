import sys
import subprocess

def fetch_cheat_sheet(query, full_output=False):
    try:
        # Construct the curl command
        command = f"curl -s cheat.sh/{query}"
        
        # Execute the curl command
        result = subprocess.run(command, shell=True, capture_output=True, text=True)
        
        # Check if the command was successful
        if result.returncode == 0:
            response = result.stdout
            if full_output:
                print(response)
            else:
                if "tldr:" in response:
                    print(response.split("tldr:")[1].strip())
                else:
                    print(response)
        else:
            print(f"Error: {result.stderr}")
    except Exception as e:
        print(f"An error occurred: {e}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python script.py [-f] <query>")
        sys.exit(1)

    full_output = False
    if sys.argv[1] == "-f":
        full_output = True
        query = sys.argv[2]
    elif len(sys.argv) > 2 and sys.argv[2] == "-f":
        full_output = True
        query = sys.argv[1]
    else:
        query = sys.argv[1]

    fetch_cheat_sheet(query, full_output)

