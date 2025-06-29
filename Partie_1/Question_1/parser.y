%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern FILE *yyin;
void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
}

%token<str> VERSION
%token<num> STARTXREF

%%
S: VERSION STARTXREF { printf("Version: %s\n", $1); printf("Startxref: %d\n", $2); exit(0); }
 ;
%%
int main(int argc, char *argv[]) {
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
    yyparse();
    fclose(file);
    return 0;
}
void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}