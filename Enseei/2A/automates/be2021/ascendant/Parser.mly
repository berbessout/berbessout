%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token UL_MODEL
%token UL_SYSTEM
%token UL_ACCOUV UL_ACCFER
%token UL_PAROUV UL_PARFER UL_CROFER UL_CROOUV
%token UL_BLOC
%token UL_PV
%token UL_VIRG
%token UL_IN
%token UL_OUT
%token UL_DP
%token INT FLOAT BOOL
%token UL_FLOW
%token UL_FROM
%token UL_POINT
%token UL_TO

/* Defini le type des donnees associees a l'unite lexicale */

%token <string> UL_IDENT
%token <string> UL_ID(* UL ajouté pour representer ident*)
%token <string> UL_ENTIER (* UL ajouté pour representer entier*)

/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> modele

/* Le non terminal document est l'axiome */
%start modele

%% /* Regles de productions */

modele : UL_MODEL UL_IDENT UL_ACCOUV element  UL_FIN { (print_endline "modele : UL_MODEL IDENT { ... } UL_FIN ") }

element : bloc element {(print_endline "element") }
        |systeme element {(print_endline "element") }
        |flot element {(print_endline "element") }
        | UL_ACCFER {(print_endline "element") } 

bloc  : UL_BLOC UL_IDENT parametres UL_PV {(print_endline "bloc :")} (*OK*)


parametres : UL_PAROUV parametre {(print_endline "parametres :")} (*OK*)

parametre : port UL_VIRG parametre {(print_endline "parametre")}
        |port UL_PARFER {(print_endline "parametre" )}

port : UL_ID UL_DP UL_IN types {(print_endline "port :")} (*OK*)
        |UL_ID UL_DP UL_OUT types {(print_endline "port :")}

types : INT UL_CROOUV UL_ENTIER  tabentier {(print_endline "port :")} (*OK*)
        |FLOAT UL_CROOUV UL_ENTIER tabentier {(print_endline "port :")}
        |BOOL UL_CROOUV UL_ENTIER tabentier {(print_endline "port :")} 
        |INT {(print_endline "port")}
        |FLOAT{(print_endline "port")}
        |BOOL{(print_endline "port")}

tabentier : UL_VIRG UL_ENTIER tabentier {(print_endline "tentier")}
        |UL_CROFER {(print_endline "tentier" )}

systeme : UL_SYSTEM UL_IDENT parametres UL_ACCOUV element{(print_endline "systeme :")} (*OK*)



flot :  |UL_FLOW UL_ID UL_FROM UL_IDENT UL_POINT UL_ID UL_TO{(print_endline "flot : on est la")}
        |UL_FLOW UL_ID UL_FROM UL_ID UL_TO{(print_endline "flot : on est la")}
        |UL_FLOW UL_ID UL_FROM UL_IDENT UL_POINT UL_ID UL_TO UL_PV{(print_endline "flot : on est la")}
        |UL_FLOW UL_ID UL_FROM UL_ID UL_TO UL_PV{(print_endline "flot : on est la")}
        |UL_FLOW UL_ID UL_FROM UL_IDENT UL_POINT UL_ID UL_TO UL_IDENT UL_POINT UL_ID idSuivant {(print_endline "flot : on est la")} 
        |UL_FLOW UL_ID UL_FROM UL_ID UL_TO UL_IDENT UL_POINT UL_ID idSuivant {(print_endline "flot : on est la")} (*probleme non recursif*)
        |UL_FLOW UL_ID UL_FROM UL_IDENT UL_POINT UL_ID UL_TO UL_ID UL_PV{(print_endline "flot : on est la")}
        |UL_FLOW UL_ID UL_FROM UL_ID UL_TO UL_ID UL_PV{(print_endline "flot : on est la")}

        


idSuivant : UL_VIRG UL_IDENT UL_POINT UL_ID idSuivant {(print_endline "idS")}
        |UL_PV {(print_endline "idS" )}
%%
