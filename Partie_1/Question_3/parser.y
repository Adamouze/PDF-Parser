%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern FILE *yyin;
extern int yyparse(char **version, int *startxref);
extern void yyerror(char** pdf_version, int* startxref_adress, const char *msg);
%}

%union {
    int num;
    char *str;
}

%token<str> VERSION
%token<num> STARTXREF

%parse-param {char **version}
%parse-param {int *startxref}

%%
S: VERSION STARTXREF {
        *version = $1;
        *startxref = $2;
    }
 ;
%%
int main(int argc, char *argv[]) {
    char* pdf_version = NULL;
    int startxref_address = 0;
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1;
    }
    yyin = file;
    yyparse(&pdf_version, &startxref_address);
    fclose(file);

    if (pdf_version != NULL) {
        printf("Version: %s\n", pdf_version);
        printf("Startxref: %d\n", startxref_address);
    } else {
        printf("PDF format not found.\n");
    }
    return 0;
}


void yyerror(char** pdf_version, int* startxref_adress, const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}