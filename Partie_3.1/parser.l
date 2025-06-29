%{
#include <stdio.h>
#include "parser.tab.h"
%}

%option noyywrap

digit [0-9]
digits {digit}+
positive_integer {digits}
signed_integer -?{digits}
real {signed_integer}"."{digits}
classic_string "\("([^()]|\\[()])*"\)"
hex_string "<"[0-9A-Fa-f \t\n]*">"
name "/"[^ \t\n\r(){}%/<>\[\]]*
ref {positive_integer}" "{positive_integer}" "R

%%
"null" { yylval.pdf_str = strdup(yytext); return PDF_NULL; }
"true" { yylval.pdf_bool = true; return PDF_BOOL; }
"false" { yylval.pdf_bool = false; return PDF_BOOL; }
{signed_integer} { yylval.pdf_num = atoi(yytext); return PDF_INTEGER; }
{real} { yylval.pdf_real = atof(yytext); return PDF_REAL; }
{classic_string} { yylval.pdf_str = strdup(yytext); return PDF_CLASSIC; }
{hex_string} { yylval.pdf_str = strdup(yytext); return PDF_HEX; }
{name} { yylval.pdf_str = strdup(yytext); return PDF_NAME; }
{ref} { yylval.pdf_str = strdup(yytext); return PDF_REF; }
"[" { return LBRACKET; }
"]" { return RBRACKET; }
"<<" { return DICT_START; }
">>" { return DICT_END; }
[ \t\n\r]+ { /* ignorer les espaces blancs */ }
. { yylval.pdf_str = strdup(yytext); return OTHER; }
%%