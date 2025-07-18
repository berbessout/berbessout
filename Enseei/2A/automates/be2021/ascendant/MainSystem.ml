open Parser

(* Fonction d'affichage des unités lexicales et des données qu'elles contiennent *)
let printToken t =
  (print_endline
     (match t with
       | UL_ACCOUV -> "{"
       | UL_ACCFER -> "}"
       | UL_PAROUV -> "("
       | UL_PARFER -> ")"
       | UL_MODEL -> "model"
       | UL_BLOC -> "block" 
       | UL_IDENT n -> n
       | UL_ID n -> n (* UL ajouté pour representer ident*)
       | UL_ENTIER n -> n (* UL ajouté pour representer entier*)
       | UL_FIN -> "EOF"
       | UL_VIRG -> ","
       | UL_PV -> ";"
       | UL_IN -> "in"
       | UL_OUT -> "out"
       | UL_DP -> ":"
       | INT -> "int"
       | FLOAT -> "float"
       | BOOL -> "bool"
       | UL_CROOUV -> "["
       | UL_CROFER -> "]"
       | UL_SYSTEM -> "system" 
       | UL_FLOW -> "flow" 
       | UL_FROM -> "from"
       | UL_POINT -> "."
       | UL_TO -> "to"
));;

(* Analyse lexicale du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  let token = ref (Lexer.lexer lexbuf) in
  while ((!token) != UL_FIN) do
    (printToken (!token));
    (token := (Lexer.lexer lexbuf))
  done
else
  (print_endline "MainJSON fichier");;

(* Analyse lexicale, syntaxique et sémantique du fichier passé en paramètre de la ligne de commande *)
if (Array.length Sys.argv > 1)
then
  let lexbuf = (Lexing.from_channel (open_in Sys.argv.(1))) in
  (Parser.modele Lexer.lexer lexbuf)
else
  (print_endline "MainJSON fichier");;
