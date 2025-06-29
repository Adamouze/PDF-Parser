%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
%}
%option noyywrap
%%
^%PDF-[0-9]+.[0-9]+  {
    yylval.str = strdup(yytext);
    return VERSION;
} 
startxref\r?\n[0-9]+ {
    yylval.num = atoi(yytext + 10);
    return STARTXREF;
}  
.|\n  { /* Ignorez le reste */ }
%%

