type t = (* MinCamlの型を表現するデータ型 (caml2html: type_t) *)
  | Unit
  | Bool
  | Int
  | Float
  | Fun of t list * t (* arguments are uncurried *)
  | Tuple of t list
  | Array of t
  | Var of t option ref

let gentyp () = Var(ref None) (* 新しい型変数を作る *)

open Format
(*型をプリント 改行しない*)
let rec print_type_t type_t =
    match type_t with
    | Unit          -> print_string "Unit"
    | Bool          -> print_string "Bool"
    | Int           -> print_string "Int"
    | Float         -> print_string "Float"
    | Fun(tlst, x)  -> print_string "Fun(";print_type_t_list tlst;
                    print_string " -> ";print_type_t x;print_char ')'
    | Tuple(tlst)   -> print_string "Tuple";print_string "(";
                    print_type_t_list tlst;print_string ")"
    | Array(x)      -> print_string "Array(";print_type_t x;print_char ')'
    | Var(x)        -> print_string "Var(";print_type_t_option_ref x;print_char ')'
and print_type_t_list type_t_lst =
    match type_t_lst with
    | []    -> print_string "" (*This shoud never happen*)
    | l::[] -> print_type_t l;
    | l::ls -> print_type_t l;print_string " * ";print_type_t_list ls
and print_type_t_option_ref type_t_option_ref =
    match !type_t_option_ref with
    | None          -> print_string "Null"
    | Some(type_t)  -> print_type_t type_t

