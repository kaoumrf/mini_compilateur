%{
#include "synt.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
int nbl=1;
int i;
int nbcolonne;
extern YYSTYPE yylval;




typedef struct 
{ 
char NomEntite[20]; 
char CodeEntite[20];
char TypeEntite[20];
char Constant[20]; 
} TypeTS;

TypeTS ts[100];

int CpTabSym=0;


int recherche(char entite[]) { 
  	int i=0; 
  	while(i<CpTabSym) 
  	{ if (strcmp(entite,ts[i].NomEntite)==0) 
  	    return i; 
  	    i++; 
  	}
	return -1; 
}


int linecount(char comment[])
{
   int lines=1;
   int i;
   for (i = 0; comment[i] != '\0' ; ++i)
   {
     if (comment[i] == '\n')
     {
       lines++;
     }
   }
   return lines-1;
}

void inserer(char entite[],char code[],char type[], char Constant[]) {
	if ( recherche(entite)==-1) 
	{ 
		strcpy(ts[CpTabSym].NomEntite,entite); 
		strcpy(ts[CpTabSym].CodeEntite,code);
		strcpy(ts[CpTabSym].TypeEntite,type);
        strcpy(ts[CpTabSym].Constant,Constant);
        CpTabSym++; 
    }
}


int verifConst(char entite[])
{ int i=0; 
  	while(i<CpTabSym) 
  	{ 
  		if (strcmp(entite,ts[i].NomEntite) == 0 && strcmp("oui",ts[i].Constant) == 0)
  		return 1; 
  	    i++; }
  	return 0;
}

const char *typeIDF (char entite[])
{
	int i=0; 
  	while(i<CpTabSym) 
  	{ if (strcmp(entite,ts[i].NomEntite)==0) 
  	    return ts[i].TypeEntite; 
  	    i++; 
  	}
  	return "";
}


void afficher () { 
	printf("\n/***************Table des symboles ******************/\n"); 
	printf("______________________________________________________________________________\n"); printf("\t|   NomEntite |   CodeEntite |   TypeEntite   | Constant \n"); 
	printf("______________________________________________________________________________\n"); 
	int i=0; 
	while(i<CpTabSym) 
	{ 
		printf("\t|%12s |%12s  |%12s    |%12s\n",ts[i].NomEntite,ts[i].CodeEntite,ts[i].TypeEntite,ts[i].Constant); 
		i++; 
	} 
}

%}
opr [-+*/]
vint ([1-9][0-9]*|0)
vfloat ([1-9][0-9]*|0)\.[0-9]*[1-9]
stri \"[a-zA-Z0-9]*\"
inout "#include<InOut>"
arithme "#include<Arithme>"
idf [a-zA-Z][a-zA-Z0-9]*
const_int "CONST int"
const_float "CONST float"
braO "["
braF "]" 
retu "return"|"Return"
inp "input"
out "output"
aff ":="
oprRel >|<|=|==|>=|<=|!=
m_main "main"
comment "/*"(.|\n)*"*/"
%%
{const_float} return const_float;
{const_int} return const_int;
{m_main} {nbcolonne+=yyleng;return m_main;}
{opr} {nbcolonne+=yyleng;return opr;}
{oprRel} {nbcolonne+=yyleng;return oprRel;}
{inout}  {nbcolonne+=yyleng; return bib_inout;}
{arithme} {nbcolonne+=yyleng; return bib_arithme;}
while {nbcolonne+=yyleng;return mc_while;}
Faire {nbcolonne+=yyleng;return mc_faire;}
Fait {nbcolonne+=yyleng;return mc_fait;}
int {nbcolonne+=yyleng;return mc_int;}
float {nbcolonne+=yyleng;return mc_float;}
string {nbcolonne+=yyleng;return mc_str;}
FUNCTION {nbcolonne+=yyleng; return mc_fct;}
{braO} {nbcolonne+=yyleng;return braO;}
{braF} {nbcolonne+=yyleng;return braF;}
{retu} {nbcolonne+=yyleng;return mc_retu;}
{inp} {nbcolonne+=yyleng;return mc_input;}
{out} {nbcolonne+=yyleng;return out;}
{idf}           {if (yyleng <= 12 ){yylval.str=strdup(yytext);nbcolonne+=yyleng;return(idf);} else{printf("Erreur le idf est trop long ( max 12 caracteres)\n");}}
{vint} {yylval.entier=atoi(yytext);nbcolonne+=yyleng;return vint;}
{vfloat} {yylval.reel=atoi(yytext);nbcolonne+=yyleng;return vfloat;}
{stri} {yylval.str=strdup(yytext);nbcolonne+=yyleng;return stri;}

\( {nbcolonne+=yyleng;return parO;}
\) {nbcolonne+=yyleng;return parF;}
\{ {nbcolonne+=yyleng;return accO;}
\} {nbcolonne+=yyleng;return accF;}
{aff} {nbcolonne+=yyleng;return aff;}
\; {nbcolonne+=yyleng;return pvg;}
, {nbcolonne+=yyleng;return vg;}

[ \t]
\n {nbcolonne=0;nbl++;}
{comment} {for(i=0;i<yyleng;i++) 
								if (yytext[i]=='\n') nbl++;	
		}
. printf("erreur lexicale a la ligne %d colonne %d \n",nbl,nbcolonne);
