%{

#include <stdio.h>
#include <string.h>

extern nbl;
extern nbcolonne;
int yylex();
char suavType [20];
float test;
char value [100] ;
int yyerror(char *s);

%}
%union {
int entier; 
float reel; 
char* str; 
char oper; 
char* type;
char* idf;
char symbol;
}
%token bib_inout  bib_arithme parO parF braO braF accO accF const_float const_int <symbol>pvg <symbol>vg <idf>idf <type>mc_int <type>mc_float <type>mc_str <oper>opr <symbol>aff <entier>vint <reel>vfloat <string>stri  out mc_input mc_retu mc_fct mc_while mc_faire mc_fait oprRel m_main 
%%
S: BIB FONCTIONS  MAIN {printf("syntaxe juste  \n");}
;

BIB: bib_inout BIB
    | bib_arithme BIB
	| 
;
FONCTIONS: SIG_FCT accO BLOC accF FONCTIONS
		|
;
BLOC: DEC_VAR  INSTRUCTIONS 
;
INSTRUCTIONS: mc_retu idf pvg INSTRUCTIONS
	|mc_input parO ARGUM parF pvg INSTRUCTIONS
	|idf parO ARGUM parF INSTRUCTIONS
	|out parO stri parF pvg INSTRUCTIONS
	|WHILE INSTRUCTIONS
	|IDFF aff  EXPRESSION pvg INSTRUCTIONS
	|
;
EXPRESSION:VAL opr  EXPRESSION
			|IDFF opr EXPRESSION
			|IDFF 
			|VAL
			|stri
;
VAL: vint
	|vfloat 
;
WHILE:mc_while parO COND parF mc_faire INSTRUCTIONS mc_fait
;
COND:idf oprRel idf
	|idf oprRel VAL
;
ARGUM:idf SUITE_ARG
	|
;
SUITE_ARG:vg idf  SUITE_ARG
	|
;
DEC_VAR: TYPE IDFF  SUITE_VAR
	| IDFConst idf SUITE_VAR
	|
;
IDFConst: const_int  
|const_float  
;

SUITE_VAR: vg IDFF SUITE_VAR
		|pvg DEC_VAR
;
IDFF: idf
	|idf braO  vint braF
;
SIG_FCT: TYPE mc_fct idf parO LISTE_DEC parF
;

LISTE_DEC: TYPE idf SUITE_DEC
		   |
;
SUITE_DEC: vg TYPE idf SUITE_DEC
           |
    ;
TYPE: mc_int  {strcpy(suavType,$1)} 
     |mc_float  {strcpy(suavType,$1)} 
     |mc_str  {strcpy(suavType,$1)} 
;
MAIN: m_main parO parF accO BLOC accF	 
%%
int yyerror(char *msg){
	printf("erreur syntaxique dans la ligne %d  colonne %d",nbl,nbcolonne);
}
main()
{ 
yyparse();
afficher();}
yywrap()
{}
