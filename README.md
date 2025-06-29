# PDF Parser Project

This project is a set of tools and parsers for analyzing and extracting information from PDF files, developed as part of a compilation course project. The project is organized into several parts, each focusing on a specific aspect of PDF parsing, from basic header extraction to more advanced object and cross-reference table parsing.

## Project Structure

```
Adam Ouzegdouh - Rapport du Projet Compilation.pdf
projet-suj.pdf
Partie_1/
  Question_1/
    expected_output.txt
    Makefile
    parser.l
    parser.y
    script_test.py
  Question_3/
    Makefile
    parser.l
    parser.y
Partie_2/
  Question_4/
    expected_output.txt
    Makefile
    parser.l
    parser.y
    script_test.py
  Question_5/
    Makefile
    myparser.c
    myparser.h
    parser.l
    parser.y
  Question_6/
    Makefile
    myparser.c
    myparser.h
    parser.l
    parser.y
Partie_3.1/
  expected_output.txt
  Makefile
  parser.l
  parser.y
  script_test.py
  test.txt
```

### Main Directories and Their Purpose

- **Partie_1/**: Introduction to PDF parsing.
  - **Question_1/**: Extracts the PDF version and the `startxref` address from a PDF file. Includes a lexer (`parser.l`), parser (`parser.y`), test script, and expected output.
  - **Question_3/**: More advanced header and `startxref` extraction.

- **Partie_2/**: Parsing the cross-reference table and trailer.
  - **Question_4/**: Parses the cross-reference table and trailer, printing all valid entries. Includes a test script and expected output.
  - **Question_5/**: Introduces data structures (`myparser.c`, `myparser.h`) to store and print cross-reference entries.
  - **Question_6/**: Integrates all previous steps, automatically finds the `startxref` using the parser from Partie_1/Question_3, and prints sorted entries.

- **Partie_3.1/**: Parsing and validating PDF objects.
  - Parses various PDF objects (null, booleans, numbers, strings, names, references, lists, dictionaries) and validates their structure. Includes comprehensive tests.

- **Adam Ouzegdouh - Rapport du Projet Compilation.pdf**: Project report (in French).
- **projet-suj.pdf**: Project subject/statement.

## How to Build and Test

Each subdirectory contains its own `Makefile` and, where relevant, a `script_test.py` for automated testing.

### General Steps

1. **Build**:  
   Run `make` in the desired subdirectory (e.g., `Partie_2/Question_4/`) to compile the parser.

2. **Test**:  
   Run the provided Python test script (e.g., `python3 script_test.py`) to execute the parser and compare its output to the expected output.

### Example

```sh
cd Partie_2/Question_4/
make
python3 script_test.py
```

## File Descriptions

- **parser.l**: Flex lexer specification for tokenizing PDF content.
- **parser.y**: Bison parser specification for syntactic analysis.
- **myparser.c/h**: C source and header files for managing data structures (cross-reference entries).
- **Makefile**: Build instructions for compiling the parser.
- **script_test.py**: Python script to automate building and testing.
- **expected_output.txt**: Reference output for validation.
- **test.txt**: Input file for object parsing tests (Partie_3.1).

## Notes

- The project is modular: each part can be built and tested independently.
- The code is written in C, using Flex and Bison for lexical and syntactic analysis.
- The project demonstrates parsing of real-world PDF structures, including error handling and validation.

## Author

Adam Ouzegdouh

---

For more details, see the project report (`Adam Ouzegdouh - Rapport du