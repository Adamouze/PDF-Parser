import subprocess
import sys

def run_make():
    print("Running make to build the project...")
    result = subprocess.run(["make"], capture_output=True, text=True)
    if result.returncode != 0:
        print("Error during make:")
        print(result.stdout)
        print(result.stderr)
        return False
    print(result.stdout)
    return True

def run_test(input_pdf, expected_output_file, start_address):
    print(f"Running test with input file: {input_pdf} and start address: {start_address}...")
    
    result = subprocess.run(["./parser.bin", input_pdf, start_address], capture_output=True, text=True)

    if result.returncode != 0:
        print("Error during execution:")
        print(result.stdout)
        print(result.stderr)
        return False

    actual_output = result.stdout
    print("Actual output:")
    print(actual_output)

    print("Comparing output with expected output...")
    try:
        with open(expected_output_file, 'r') as f:
            expected = f.read()
    except FileNotFoundError:
        print(f"Expected output file '{expected_output_file}' not found.")
        return False
    
    if actual_output.strip() == expected.strip():
        print("Test passed!")
        return True
    else:
        print("Test failed!")
        print("Expected output:")
        print(expected)
        print("Actual output:")
        print(actual_output)
        return False

def main():
    if not run_make():
        return

    if len(sys.argv) < 2:
        print("Usage: python3 script_test.py <start_address>")
        return

    start_address = sys.argv[1]
    
    test_cases = [
        ("../../projet-suj.pdf", "expected_output.txt", start_address),
    ]

    for input_pdf, expected_output_file, start_address in test_cases:
        if not run_test(input_pdf, expected_output_file, start_address):
            print("Test failed.")
            break
    else:
        print("All tests passed.")

if __name__ == "__main__":
    main()