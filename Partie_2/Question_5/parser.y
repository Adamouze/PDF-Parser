%{
#include "myparser.h"
extern int yylex();
extern FILE *yyin;
int table_entry_count = 0;
void yyerror(const char *msg);
int n_entries = 0;
%}

%code requires {
#include "myparser.h"
}

%union {
    int address;
    char* str;
    Header header;
    Entry entry;
}

%token<str> XREF
%token <header> TABLE_HEADER
%token <entry> TABLE_ENTRY
%token<str> TRAILER DICT_START DICT_END STARTXREF  TOKEN_EOF
%token <address> ADDRESS



%start document

%%

document:
    xref_section { if (table_entry_count == n_entries) {printf("Table de référence correcte\n");} else {printf("Table de référence incorrecte\n");}} trailer_section {printf("Trailer correct\n");}
;

xref_section:
    XREF {printf("XREF détecté : %s\n",$1);} table

;


table:
    TABLE_HEADER {printf("header détecté: i = %d, n = %d\n", $1.i, $1.n); n_entries=$1.n;} entry_list
;

entry_list:
    | entry_list TABLE_ENTRY {
        if ($2.status == 'n') {
            add_entry($2);
        }
        table_entry_count++;
    }
;

trailer_section:
    TRAILER DICT_START DICT_END STARTXREF ADDRESS TOKEN_EOF {
        printf("Trailer détecté : %s\n", $1);
        printf("Début de dictionnaire détecté : %s\n", $2);
        printf("Fin de dictionnaire détecté : %s\n", $3);
        printf("Startxref détecté : %s\n", $4);
        printf("Addresse détecté : %d\n", $5);
        printf("EOF détecté : %s\n", $6);
    }
;

%%

void yyerror(const char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <input_file> <start_address>\n", argv[0]);
        return 1;
    }
    FILE *file = fopen(argv[1], "r");
    if (file == NULL) {
        printf("Error opening file.\n");
        return 1;
    }
    int start_address = atoi(argv[2]);
    fseek(file, start_address, SEEK_SET);
    yyin = file;
    yyparse();
    printf("Table de référence récupérée (en conservant uniquement les objets de types n) triée par adresses croissantes :\n");
    print_entries();
    free_entries();
    fclose(file);
    return 0;
}
