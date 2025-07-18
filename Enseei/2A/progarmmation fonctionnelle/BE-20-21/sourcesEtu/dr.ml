(*  Module qui permet la décomposition et la recomposition de données **)
(*  Passage du type t1 vers une liste d'éléments de type t2 (décompose) **)
(*  et inversement (recopose).**)
module type DecomposeRecompose =
sig
  (*  Type de la donnée **)
  type mot
  (*  Type des symboles de l'alphabet de t1 **)
  type symbole

  val decompose : mot -> symbole list
  val recompose : symbole list -> mot
end

module DRString : DecomposeRecompose with type mot = string and type symbole = char =
struct
    type mot = string
    type symbole = char

    (******************************************************************************)
    (*                                                                            *)
    (*      fonction de décomposition pour les chaînes de caractères              *)
    (*                                                                            *)
    (*   signature : decompose_chaine : string -> char list = <fun>               *)
    (*                                                                            *)
    (*   paramètre(s) : une chaîne de caractères                                  *)
    (*   résultat     : la liste des caractères composant la chaîne paramètre     *)
    (*                                                                            *)
    (******************************************************************************)
  let decompose s =
    let rec decompose i accu =
      if i < 0 then accu
      else decompose (i-1) (s.[i]::accu)
    in decompose (String.length s - 1) []

  let%test _ = decompose "" = []
  let%test _ = decompose "a" = ['a']
  let%test _ = decompose "aa" = ['a';'a']
  let%test _ = decompose "ab" = ['a';'b']
  let%test _ = decompose "abcdef" = ['a'; 'b'; 'c'; 'd'; 'e'; 'f']

    (******************************************************************************)
    (*                                                                            *)
    (*      fonction de recomposition pour les chaînes de caractères              *)
    (*                                                                            *)
    (*   signature : recompose_chaine : char list -> string = <fun>               *)
    (*                                                                            *)
    (*   paramètre(s) : une liste de caractères                                   *)
    (*   résultat     : la chaîne des caractères composant la liste paramètre     *)
    (*                                                                            *)
    (******************************************************************************)
  let recompose lc =
    List.fold_right (fun t q -> String.make 1 t ^ q) lc ""

  let%test _ = recompose [] = ""
  let%test _ = recompose ['a'] = "a"
  let%test _ = recompose ['a';'a'] = "aa"
  let%test _ = recompose ['a';'b'] = "ab"
  let%test _ = recompose ['a'; 'b'; 'c'; 'd'; 'e'; 'f'] = "abcdef"

    (******************************************************************************)
    (*                                                                            *)
    (*      fonction de lecture d'une chaîne                                      *)
    (*                                                                            *)
    (*   signature : lit_chaine : unit -> string = <fun>                          *)
    (*                                                                            *)
    (*   paramètre(s) : aucun                                                     *)
    (*   résultat     : une chaîne                                                *)
    (*                                                                            *)
    (******************************************************************************)
  let lit_chaine = read_line

    (******************************************************************************)
    (*                                                                            *)
    (*      procédure d'affichage d'une chaîne                                    *)
    (*                                                                            *)
    (*   signature : affiche_chaine : string -> unit = <fun>                      *)
    (*                                                                            *)
    (*   paramètre(s) : une chaîne                                                *)
    (*   résultat     : aucun                                                     *)
    (*                                                                            *)
    (******************************************************************************)
  let affiche_chaine s = let () = print_string s in print_newline ()

end

module DRNat : DecomposeRecompose with type mot = int and type symbole = int =
struct
    type mot = int
    type symbole = int

    (******************************************************************************)
    (*                                                                            *)
    (*                 procédure de décomposition d'un entier                     *)
    (*                                                                            *)
    (*   signature : decomposer_chaine : Int -> unitInt list = <fun>              *)
    (*                                                                            *)
    (*   paramètre(s) : un entier                                                 *)
    (*   résultat     : la liste des chiffres qui composent l'entier              *)
    (*                                                                            *)
    (******************************************************************************)
    let decompose nbr = 
      let rec aux n l = 
        if n = 0 then 
          match l with
          | [] -> [0]
          | _ -> l
        else
          aux (n/10) ((n mod 10)::l)
        in aux nbr []
        
    let%test _ = decompose 0 = [0]
    let%test _ = decompose 13 = [1;3]
    let%test _ = decompose 248 = [2;4;8]

    (******************************************************************************)
    (*                                                                            *)
    (*      fonction de recomposition d'une liste de chiffre                      *)
    (*                                                                            *)
    (*   signature : lit_chaine : int list -> int = <fun>                         *)
    (*                                                                            *)
    (*   paramètre(s) : la liste des chiffres qui composent un entier             *)
    (*   résultat     : l'entier correspondant                                    *)
    (*                                                                            *)
    (******************************************************************************)   
    let recompose l =
      let rec aux nbr l =
        match l with 
        | [a] -> a + nbr * 10
        | t::q -> aux (nbr*10 + t) q
      in aux 0 l

    let%test _ = recompose [0] = 0
    let%test _ = recompose [1; 0] = 10
    let%test _ = recompose [2;4;8] = 248
    let%test _ = recompose (decompose 1383) = 1383
end