#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAX 100

// Operator precedence relations
char precedence[MAX][MAX];  // Precedence table
char stack[MAX];            // Stack for parsing
int top = -1;               // Stack pointer

void push(char c) {
    if (top >= MAX - 1) {
        printf("Stack Overflow\n");
        return;
    }
    stack[++top] = c;
}

char pop() {
    if (top == -1) {
        printf("Stack Underflow\n");
        return '\0';
    }
    return stack[top--];
}

char peek() {
    if (top == -1) {
        return '\0';
    }
    return stack[top];
}

// Function to check if the character is an operator
int is_operator(char c) {
    return c == '+' || c == '-' || c == '*' || c == '/' || c == '$' || c == '(' || c == ')';
}

// Define the precedence relations in the table
void fill_precedence_table() {
    int i, j;
    char operators[] = {'+', '-', '*', '/', '(', ')', '$'};
    int num_operators = sizeof(operators) / sizeof(operators[0]);

    // Initialize precedence table with blanks
    for (i = 0; i < num_operators; i++) {
        for (j = 0; j < num_operators; j++) {
            precedence[i][j] = ' ';
        }
    }

    // Fill precedence table based on operator precedence relations
    precedence[0][0] = precedence[0][1] = precedence[0][2] = precedence[0][3] = precedence[0][4] = precedence[0][6] = '>'; // '+' and other operators
    precedence[0][5] = '<';  // '+' and ')'
    precedence[1][0] = precedence[1][1] = precedence[1][2] = precedence[1][3] = precedence[1][4] = precedence[1][6] = '>'; // '-' and other operators
    precedence[1][5] = '<';  // '-' and ')'
    precedence[2][0] = precedence[2][1] = precedence[2][2] = precedence[2][3] = precedence[2][4] = precedence[2][6] = '>'; // '*' and other operators
    precedence[2][5] = '<';  // '*' and ')'
    precedence[3][0] = precedence[3][1] = precedence[3][2] = precedence[3][3] = precedence[3][4] = precedence[3][6] = '>'; // '/' and other operators
    precedence[3][5] = '<';  // '/' and ')'
    precedence[4][0] = precedence[4][1] = precedence[4][2] = precedence[4][3] = precedence[4][4] = precedence[4][6] = '<'; // '(' and other operators
    precedence[4][5] = '=';  // '(' and ')'
    precedence[5][0] = precedence[5][1] = precedence[5][2] = precedence[5][3] = precedence[5][5] = precedence[5][6] = '>'; // ')' and other operators
    precedence[6][0] = precedence[6][1] = precedence[6][2] = precedence[6][3] = precedence[6][5] = precedence[6][6] = '<'; // '$' and other operators
}

// Function to get the precedence between two operators
char get_precedence(char op1, char op2) {
    char operators[] = {'+', '-', '*', '/', '(', ')', '$'};
    int i, j;

    for (i = 0; i < 7; i++) {
        if (operators[i] == op1) break;
    }

    for (j = 0; j < 7; j++) {
        if (operators[j] == op2) break;
    }

    return precedence[i][j];
}

// Function to parse the input string
void operator_precedence_parsing(char *input) {
    int i = 0;
    char current;

    push('$'); // End marker

    printf("\nStack\t\tInput\t\tAction\n");
    printf("-------------------------------------------\n");

    while (input[i] != '\0') {
        current = input[i];

        // Print the stack and remaining input
        printf("%s\t\t%s\t\t", stack, &input[i]);

        if (!is_operator(current)) {
            // If it's an operand, shift
            printf("Shift\n");
            i++;
        } else {
            char top_operator = peek();

            if (get_precedence(top_operator, current) == '<') {
                // Shift
                printf("Shift\n");
                push(current);
                i++;
            } else if (get_precedence(top_operator, current) == '>') {
                // Reduce
                printf("Reduce\n");
                pop();
            } else if (get_precedence(top_operator, current) == '=') {
                // Match parentheses or end symbol
                printf("Match\n");
                pop();
                i++;
            } else {
                printf("Error: Unrecognized relation\n");
                return;
            }
        }
    }

    // After reading all input, reduce the stack to the end marker
    while (peek() != '$') {
        printf("%s\t\t \t\tReduce\n", stack);
        pop();
    }

    printf("%s\t\t \t\tAccept\n", stack);
}

int main() {
    char input[MAX];

    fill_precedence_table();  // Fill the precedence table

    printf("Enter the input expression: ");
    scanf("%s", input);

    strcat(input, "$");  // Append end marker

    operator_precedence_parsing(input);

    return 0;
}
