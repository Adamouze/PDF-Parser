%{
#include <stdio.h>
#include <stdbool.h>
extern int yylex();
void yyerror(const char *s);
int isValidList = 1;
int isValidDict = 1;
%}

%union {
    int pdf_num;
    bool pdf_bool;
    double pdf_real;
    char* pdf_str;
}

%code requires {
    #include <stdbool.h>
}

%token<pdf_num> PDF_INTEGER
%token<pdf_bool> PDF_BOOL
%token<pdf_real> PDF_REAL
%token<pdf_str> PDF_NULL PDF_CLASSIC PDF_HEX PDF_NAME PDF_REF OTHER
%token LBRACKET RBRACKET
%token DICT_START DICT_END

%start objects

%%
objects: /* vide */
       | objects object
       ;

object: PDF_NULL { printf("Valid PDF object: null\n"); }
      | PDF_BOOL { printf("Valid PDF object: boolean (%s)\n", $1 ? "true" : "false"); }
      | PDF_INTEGER { printf("Valid PDF object: signed integer (%d)\n", $1); }
      | PDF_REAL { printf("Valid PDF object: signed real (%f)\n", $1); }
      | PDF_CLASSIC { printf("Valid PDF object: classic string %s\n", $1); }
      | PDF_HEX { printf("Valid PDF object: hexadecimal string (%s)\n", $1); }
      | PDF_NAME { printf("Valid PDF object: name (%s)\n", $1); }
      | PDF_REF { printf("Valid PDF object: reference (%s)\n", $1); }
      | LBRACKET { isValidList = 1; } pdf_list RBRACKET {
            if (isValidList) {
              printf("Valid PDF object: list\n"); 
          } else {
              printf("Invalid PDF object list\n");
          } }
      | DICT_START { isValidDict = 1; } dict_content DICT_END {
            if (isValidDict) {
                printf("Valid PDF object: dictionary\n");
            } else {
                printf("Invalid PDF object dictionary\n");
            }
        }
       | OTHER { yyerror("Invalid PDF object\n"); isValidList = 0; isValidDict = 0; yyerrok; }
      ;

pdf_list: /* vide */
        | pdf_list object
        ;

dict_content: /* vide */
            | dict_content PDF_NAME object
            | error { yyerror("Invalid PDF object\n"); isValidDict = 0;} dict_recover 
            ;

dict_recover: DICT_END
            | OTHER { }
            ;


%%

int main() {
    yyparse();
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}