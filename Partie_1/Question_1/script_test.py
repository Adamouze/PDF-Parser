import subprocess

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

def run_test(input_pdf, expected_output_file):
    print(f"Running test with input file: {input_pdf}...")
    
    result = subprocess.run(["./parser.bin", input_pdf], capture_output=True, text=True)

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
    
    test_cases = [
        ("../../projet-suj.pdf", "expected_output.txt"),
    ]

    for input_pdf, expected_output_file in test_cases:
        if not run_test(input_pdf, expected_output_file):
            print("Test failed.")
            break
    else:
        print("All tests passed.")

if __name__ == "__main__":
    main()