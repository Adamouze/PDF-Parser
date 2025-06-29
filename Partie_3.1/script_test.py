import subprocess
import os
import re

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

def clean_output(output):
    return re.sub(r'\s+', '', output)

def run_test(input_file, expected_output):
    print(f"Running test with input file: {input_file}...")
    with open(input_file, 'r') as f:
        input_data = f.read()
    
    result = subprocess.run(["./parser.bin"], input=input_data, capture_output=True, text=True)
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
        with open(expected_output, 'r') as f:
            expected = f.read()
    except FileNotFoundError:
        print(f"Expected output file '{expected_output}' not found.")
        return False
    
    if clean_output(actual_output) == clean_output(expected):
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
        ("test.txt", "expected_output.txt"),
    ]

    for input_file, expected_output in test_cases:
        if not run_test(input_file, expected_output):
            print("Test failed.")
            break
    else:
        print("All tests passed.")

if __name__ == "__main__":
    main()
