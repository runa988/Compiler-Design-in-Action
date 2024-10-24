Compiler Design in Action


This repository contains a collection of practical programs developed for the Compiler Design Lab,focusing on key aspects of compiler construction such as lexical analysis, parsing, and code generation using Flex, Bison, and GCC. Each module provides hands-on experience with essential compiler design concepts.

Table of Contents

1.	Code Generator
Contains code for generating assembly-level instructions from intermediate representations.
2.	ICG (Intermediate Code Generation)
Implements intermediate code generation techniques for optimizing and translating high-level code.
3.	Optimization
Includes code optimization techniques to improve efficiency and reduce redundancy.
4.	Shift-Reduce Parser
Implements a shift-reduce parser for syntax analysis of input source code.
5.	Simple Calculator
A basic calculator program demonstrating lexical analysis, parsing, and evaluation using Flex and Bison.
6.	Simple Expression Evaluation
Evaluates mathematical expressions using syntax-directed translation.
7.	Symbol Table
A symbol table implementation for tracking variables, functions, and their attributes.
8.	Tokenization of Given C Code
Implements lexical analysis using Flex to tokenize C code into keywords, operators, and identifiers.
9.	Valid Variable
A program that checks the validity of variable names according to the C language's naming conventions.

Software Requirements

To execute the programs in this repository, the following software is required:
•	Flex (for lexical analysis)
•	Bison (for parser generation)
•	GCC (GNU Compiler Collection for compiling the C programs)


How to Run

1.	Clone the repository: git clone https://github.com/yourusername/compiler-design-in-action.git
2.	Navigate to the desired folder: cd compiler-design-in-action/<folder-name>
3.	Compile and run the program using Flex, Bison, and GCC:

flex filename.l
bison -d filename.y
gcc lex.yy.c filename.tab.c -o output
./output

4.	Follow specific instructions within each folder for running the individual programs.

Contributor

Arunkumar R

Role: Developer & Maintainer

Position: Assistant Professor

