%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
void yyerror(const char *s);
%}
%option noyywrap

%x DICTIONARY

%%

xref[ \t]*\n  { yylval.str = strdup(yytext); yylval.str[strlen(yylval.str)-1] = '\0'; return XREF; }

[0-9]+[ \t]+[0-9]+[ \t]*\n   {
    int i, n;
    sscanf(yytext, "%d %d", &i, &n);
    yylval.header.i = i;
    yylval.header.n = n;
    return TABLE_HEADER;
}

[0-9]{10}[ \t]+[0-9]{5}[ \t]+[nf][ \t]*[\n\r]   {
    char addr[11], gen[6], status;
    sscanf(yytext, "%10s %5s %c", addr, gen, &status);
    yylval.entry.addr = strdup(addr);
    yylval.entry.gen = atoi(gen);
    yylval.entry.status = status;
    return TABLE_ENTRY;
}

trailer[ \t\n\r]*    { yylval.str = strdup(yytext); return TRAILER; }
"<<"                    { yylval.str = strdup(yytext); BEGIN(DICTIONARY); return DICT_START; }
<DICTIONARY>{
    ">>\n"               { yylval.str = strdup(yytext); BEGIN(INITIAL); return DICT_END; }
    .|\n               { /* Ignorer le contenu du dictionnaire */ }
}
startxref[ \t\n\r]*   { yylval.str = strdup(yytext); return STARTXREF; }
[0-9]+[ \t\n\r]*     { yylval.address = atoi(yytext); return ADDRESS; }
"%%EOF"[ \t\n\r]*     { yylval.str = strdup(yytext); return TOKEN_EOF; }


.|\n { yyerror("Invalid character -> table de référence et trailer invalides à cette position"); exit(1);}
%%

