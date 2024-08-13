#include <stdio.h>
#include <string.h>

#define MAX_QUADRUPLES 100

struct Quadruple
{
    char op;
    char arg1[10];
    char arg2[10];
    char result[10];
};

struct Quadruple quadruples[MAX_QUADRUPLES];
int quadCount = 0;

// Function to check if two quadruples are identical
int areQuadruplesEqual(struct Quadruple q1, struct Quadruple q2)
{
    return strcmp(q1.arg1, q2.arg1) == 0 &&
           strcmp(q1.arg2, q2.arg2) == 0 &&
           q1.op == q2.op;
}

// Function to perform common subexpression elimination
void performCSE()
{
    for (int i = 0; i < quadCount; i++)
    {
        for (int j = i + 1; j < quadCount; j++)
        {
            if (areQuadruplesEqual(quadruples[i], quadruples[j]))
            {
                printf("Common subexpression found between quadruples %d and %d\n", i + 1, j + 1);
                strcpy(quadruples[j].arg1, quadruples[i].result);
            }
        }
    }
}

// Function to display quadruples
void displayQuadruples()
{
    printf("Quadruples:\n");
    printf("--------------------------------------\n");
    printf("%-10s %-2s %-10s %-2s %-10s %-2s %-10s\n", "Operand1", "Op", "Operand2", "", "Result", "", "Sub Expression");
    for (int i = 0; i < quadCount; i++)
    {
        printf("%-10s %-2c %-10s %-2c %-10s %-2c ", quadruples[i].arg1, quadruples[i].op, quadruples[i].arg2, '=', quadruples[i].result, ' ');
        if (i == 0 || strcmp(quadruples[i].arg1, quadruples[i - 1].arg1) != 0 || strcmp(quadruples[i].arg2, quadruples[i - 1].arg2) != 0)
            printf("%s + %s", quadruples[i].arg1, quadruples[i].arg2);
        printf("\n");
    }
}

int main()
{
    // Sample quadruples
    strcpy(quadruples[0].arg1, "a");
    strcpy(quadruples[0].arg2, "b");
    quadruples[0].op = '+';
    strcpy(quadruples[0].result, "c");

    strcpy(quadruples[1].arg1, "n");
    strcpy(quadruples[1].arg2, "f");
    quadruples[1].op = '-';
    strcpy(quadruples[1].result, "s");

    strcpy(quadruples[2].arg1, "d");
    strcpy(quadruples[2].arg2, "b");
    quadruples[2].op = '*';
    strcpy(quadruples[2].result, "u");

    strcpy(quadruples[3].arg1, "a");
    strcpy(quadruples[3].arg2, "b");
    quadruples[3].op = '+';
    strcpy(quadruples[3].result, "j");

    strcpy(quadruples[4].arg1, "n");
    strcpy(quadruples[4].arg2, "m");
    quadruples[4].op = '%';
    strcpy(quadruples[4].result, "p");

    strcpy(quadruples[5].arg1, "7");
    strcpy(quadruples[5].arg2, "2");
    quadruples[5].op = '/';
    strcpy(quadruples[5].result, "b");

    strcpy(quadruples[6].arg1, "a");
    strcpy(quadruples[6].arg2, "b");
    quadruples[6].op = '+';
    strcpy(quadruples[6].result, "o");

    quadCount = 7;

    printf("Before Common Subexpression Elimination:\n");
    printf("--------------------------------\n");
    displayQuadruples();

    performCSE();

    printf("\nAfter Common Subexpression Elimination:\n");
    printf("--------------------------------\n");

    displayQuadruples();

    return 0;
}
