(*l'argument ArgumentInvalide *)
exception ArgumentInvalide

(* renvoie une liste de n fois l'élément e .         *)
(* l_taille : int -> 'a -> 'a list                   *)
(* entrée : n la taille de la liste                  *)
(*          e l'élément à mettre dans la liste       *)
(* sortie : une liste de n fois l'élément e .        *)
(* précondition : n >= 0                             *)
(* postcondition : la liste est de taille n          *)
(*                 le seul élément de la liste est e *)
let rec l_taille n e = 
  if n = 0 then []
  else e::l_taille (n-1) e

(* Tests : A COMPLETER *)
let%test _ = l_taille 0 3 = []
let%test _ = l_taille 1 2 = [2]
let%test _ = l_taille 6 5 = [5;5;5;5;5;5]

(* get : int -> 'a list -> 'a *)
(* Renvoie le i-ième élément d'une liste *)
(* La tête de la liste est à la position 0 *)
(* Erreur : l'exception ArgumentInvalide est levée si i est négatif *)
(* ou plus grand que la taille de la liste *)
let rec get i l = 
  match l with
  | [] -> raise ArgumentInvalide
  | t::q -> if i < 0 then raise ArgumentInvalide
            else if i = 0 then t
            else get (i-1) q


let%test _ = get 0 [ 5; 7; 3; 2 ] = 5
let%test _ = get 1 [ 5; 7; 3; 2 ] = 7
let%test _ = get 2 [ 5; 7; 3; 2 ] = 3
let%test _ = get 3 [ 5; 7; 3; 2 ] = 2
let%test _ = get 0 [ true; false; true ] = true
let%test _ = get 1 [ true; false; true ] = false
let%test _ = get 2 [ true; false; true ] = true

let%test _ =
  try
    let _ = get (-10) [] in
    false
  with ArgumentInvalide -> true

let%test _ =
  try
    let _ = get (-10) [ 1; 2; 3 ] in
    false
  with ArgumentInvalide -> true

let%test _ =
  try
    let _ = get (-10) [ 'a'; 'b'; 'c' ] in
    false
  with ArgumentInvalide -> true

let%test _ =
  try
    let _ = get 10 [] in
    false
  with ArgumentInvalide -> true

let%test _ =
  try
    let _ = get 10 [ 1; 2; 3 ] in
    false
  with ArgumentInvalide -> true

let%test _ =
  try
    let _ = get 10 [ 'a'; 'b'; 'c' ] in
    false
  with ArgumentInvalide -> true



(* set : int -> 'a list -> 'a -> 'a list *)
(* "Modifie" le i-ième élément d'une liste *)
(* La tête de la liste est à la position 0 *)
(* Pas de modification sur la liste s'il n'y a pas de i-ième élément*)
let rec set i l v = 
  match l with 
  | [] -> []
  | t::q -> if i < 0 then l
            else if i = 0 then v::q
            else t::(set (i-1) q v)



let%test _ = set 0 [ 5; 7; 3; 2 ] 10 = [ 10; 7; 3; 2 ]
let%test _ = set 1 [ 5; 7; 3; 2 ] 10 = [ 5; 10; 3; 2 ]
let%test _ = set 2 [ 5; 7; 3; 2 ] 10 = [ 5; 7; 10; 2 ]
let%test _ = set 3 [ 5; 7; 3; 2 ] 10 = [ 5; 7; 3; 10 ]
let%test _ = set 7 [ 5; 7; 3; 2 ] 10 = [ 5; 7; 3; 2 ]
let%test _ = set (-3) [ 5; 7; 3; 2 ] 10 = [ 5; 7; 3; 2 ]
let%test _ = set 0 [ true; false; true ] false = [ false; false; true ]
let%test _ = set 1 [ true; false; true ] false = [ true; false; true ]
let%test _ = set 2 [ true; false; true ] false = [ true; false; false ]
let%test _ = set 10 [ true; false; true ] false = [ true; false; true ]
let%test _ = set (-10) [ true; false; true ] false = [ true; false; true ]

