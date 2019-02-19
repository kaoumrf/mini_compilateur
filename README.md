# mini_compilateur
Le but de ce projet est de réaliser un mini-compilateur d’un langage appelé « AlgoSI», en effectuant les différentes phases de la compilation : lexicale, syntaxique, sémantique et générations de code intermédiaire.
# I.	Description du Langage AlgoSI 
	PartieDeclarationBibliotheque
	TYPE FUNCTION  NomFonction ( ListeParametre)
	{
	         PartieDeclarationDeVariable
	        PartieInstruction ;
	}
	// le programme peut contenir plusieurs fonctiosn
	Main ()
	{
	        PartieDeclarationDeVariable
	        PartieInstruction ;
	}

## 1-La partie de déclaration de bibliothèques: 
	Nom	usage
	#include <InOut>	Pour les instructions Inpute et Output
	#include<Arithme>	Pour les affectations et les expression arithmétiques
## 2-La partie déclarations de fonctions 
Le langage peut contenir plusieurs fonctions, qu’on doit déclarer avant la fonction main().
## 3-La Partie déclaration de variables 2
Nous pouvons déclarer dans ce langage des variables (simples ou tableaux) et des constantes.
*	Variable simple : Type : nom variables;
*	Tableau         : Type : NomVariables [taille] ;
*	Constante : Type : CONST NomVariables ;
## 4-La Partie instruction 
Affectation	
Boucle	While 
output	output(“chaine”);
input	input(listeVariable);
Nomfonction 	NomFonction(listeVariable);
return	
-	Les expressions arithmétiques sont  composées des opérateurs : +, *,- ,/
-	Opérateurs de comparaison sont : =, < , >, <=, >=, !=
## 5-Les commentaires 
Un commentaire peut être écrit sur une ou sur plusieurs lignes en mettant le texte entre « /* » et « */ »

# II.	Travail à réaliser :  
Ci-dessous les différentes phases à effectuer afin de réaliser le compilateur demandé. 
-	Analyse lexicale avec l’outil FLEX.
-	Analyse  syntaxique avec l'outil Bison 
-	Analyse sémantique pour les erreurs suivantes :
*	Idf non déclaré
*	Idf double déclarée
*	Non compatibilité de type
*	Dépassement de la taille d’un tableau
*	Absence d’une bibliothèque nécessaire
*	Modification d’une valeur d’une constante
*	Vérification de fonctions : appelle d’une fonction déclarée, le respecte de la signature de la fonction lors de l’appel, le respect de type de return, ect.

-	Gestion de la table de symboles La table doit avoir au minimum les champs suivants : 
-	Nom : l’identificateur qui indique le nom de la variable (ou constante), Tab, etc. 
-	Type : le type de la variable ou la constante 
-	Taille : la taille du tableau (la taille est égale à 1 pour les variables simples) 

-	Traitement des erreurs : 
Il est demandé d’afficher les messages d’erreurs adéquats à chaque étape du processus de compilation, en précisant le numéro de ligne et la colonne de l’erreur.
