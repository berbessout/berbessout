(* Exercice 1*)

(* max : int list -> int  *)
(* Paramètre : liste dont on cherche le maximum *)
(* Précondition : la liste n'est pas vide *)
(* Résultat :  l'élément le plus grand de la liste *)
let max l = 
  let rec aux m l = 
    match l with
    | [] -> m
    | t::q -> if t > m then aux t q
              else aux m q
  in if l=[] then failwith"liste vide"
  else let t::q = l in aux t q   

(* TO DO : copier / coller les tests depuis conwayTests.txt *)
let%test _ = max [ 1 ] = 1
let%test _ = max [ 1; 2 ] = 2
let%test _ = max [ 2; 1 ] = 2
let%test _ = max [ 1; 2; 3; 4; 3; 2; 1 ] = 4

(* max_max : int list list -> int  *)
(* Paramètre : la liste de listes dont on cherche le maximum *)
(* Précondition : il y a au moins un élement dans une des listes *)
(* Résultat :  l'élément le plus grand de la liste *)
let max_max l= 
  let rec aux m1 l = 
    match l with 
    | [] -> m1
    | t::q -> let m2 = max t
              in if m2 > m1 then aux m2 q
              else aux m1 q
  in if l=[] then failwith"liste vide"
  else let t::q = l in aux (max t) q  

(* TO DO : copier / coller les tests depuis conwayTests.txt *)
let%test _ = max_max [ [ 1 ] ] = 1
let%test _ = max_max [ [ 1 ]; [ 2 ] ] = 2
let%test _ = max_max [ [ 2 ]; [ 2 ]; [ 1; 1; 2; 1; 2 ] ] = 2
let%test _ = max_max [ [ 2 ]; [ 1 ] ] = 2
let%test _ = max_max [ [ 1; 1; 2; 1 ]; [ 1; 2; 2 ] ] = 2

(* Exercice 2*)

(* suivant : int list -> int list *)
(* Calcule le terme suivant dans une suite de Conway *)
(* Paramètre : le terme dont on cherche le suivant *)
(* Précondition : paramètre différent de la liste vide *)
(* Retour : le terme suivant *)

let suivant conway = 
  let rec compte c e conway =
    match conway with 
    |[] -> ([c;e],[])
    |t::q -> if t = e then compte (c+1) e q
            else ([c;e],conway)
  in let rec aux conway = 
      match conway with 
      |[] -> []
      |t::q -> let (couple, suivant) = (compte 1 t q) in couple@aux suivant
  in if conway=[] then failwith"liste vide"
     else aux conway 

(* TO DO : copier / coller les tests depuis conwayTests.txt *)
let%test _ = suivant [ 1 ] = [ 1; 1 ]
let%test _ = suivant [ 2 ] = [ 1; 2 ]
let%test _ = suivant [ 3 ] = [ 1; 3 ]
let%test _ = suivant [ 1; 1 ] = [ 2; 1 ]
let%test _ = suivant [ 1; 2 ] = [ 1; 1; 1; 2 ]
let%test _ = suivant [ 1; 1; 1; 1; 3; 3; 4 ] = [ 4; 1; 2; 3; 1; 4 ]
let%test _ = suivant [ 1; 1; 1; 3; 3; 4 ] = [ 3; 1; 2; 3; 1; 4 ]
let%test _ = suivant [ 1; 3; 3; 4 ] = [ 1; 1; 2; 3; 1; 4 ]
let%test _ = suivant [3;3] = [2;3]

(* suite : int -> int list -> int list list *)
(* Calcule la suite de Conway *)
(* Paramètre taille : le nombre de termes de la suite que l'on veut calculer *)
(* Paramètre depart : le terme de départ de la suite de Conway *)
(* Résultat : la suite de Conway *)
let suite n0 conway = 
     let rec aux n l = 
      if n = 1 then l
      else aux (n-1) ((suivant (List.hd l))::l)
    in List.rev(aux n0 [conway])

(* TO DO : copier / coller les tests depuis conwayTests.txt *)
let%test _ = suite 1 [ 1 ] = [ [ 1 ] ]
let%test _ = suite 2 [ 1 ] = [ [ 1 ]; [ 1; 1 ] ]
let%test _ = suite 3 [ 1 ] = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ] ]
let%test _ = suite 4 [ 1 ] = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ]; [ 1; 2; 1; 1 ] ]

(* Tests de la conjecture *)
(* "Aucun terme de la suite, démarant à 1, ne comporte un chiffre supérieur à 3" *)

let%test _ = max_max (suite 50 [ 1 ]) = 3;;

(* Remarque : TO DO *)
"Cette méthode n'est ni correcte ni éfficace car elle ne montre la conjecture jusqu'à un rang donné (ici 40)"