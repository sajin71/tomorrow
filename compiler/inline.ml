open KNormal

(* インライン展開する関数の最大サイズ (caml2html: inline_threshold) *)
let threshold = ref 20 (* Mainで-inlineオプションによりセットされる *)

let recursive_limit = 6

let recursive_map = ref M.empty (* show if the function is recursive or not *)

let rec get_app_count f = function (* currently not using it *)
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) 
        -> max (get_app_count f e1) (get_app_count f e2)
    | Let(xt, e1, e2) -> (get_app_count f e1) + (get_app_count f e2) 
    | App(x, ys) when x = f -> 1
    | LetRec({ name = (x, t); args = yts; body = e1 }, e2) when x = f ->
            get_app_count f e1 * get_app_count x e2
    | LetRec({ name = (x, t); args = _; body = e1 }, e2) ->
            get_app_count f e1 * get_app_count x e2 + get_app_count f e2
    | _ -> 0

let rec is_applied f = function
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) 
        -> (is_applied f e1) or (is_applied f e2)
    | Let(xt, e1, e2) -> (is_applied f e1) or (is_applied f e2) 
    | App(x, ys) when x = f -> true
    | LetRec({ name = (x, t); args = yts; body = e1 }, e2) when x = f ->
            (is_applied f e1) && (is_applied x e2)
    | LetRec({ name = (x, t); args = _; body = e1 }, e2) ->
            (is_applied f e1 && is_applied x e2) or is_applied f e2
    | _ -> false


let rec g env limit = function (* インライン展開ルーチン本体 (caml2html: inline_g) *)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env limit e1, g env limit e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env limit e1, g env limit e2)
  | Let(xt, e1, e2) -> Let(xt, g env limit e1, g env limit e2)
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) -> (* 関数定義の場合 (caml2html: inline_letrec) *)
      recursive_map := M.add x (is_applied x e1) !recursive_map; 
      let env = if size e1 > !threshold then env else M.add x (yts, e1) env in
      LetRec({ name = (x, t); args = yts; body = g env limit e1}, g env limit e2)
  | App(x, ys) 
    when M.mem x env && ((not (M.mem x !recursive_map)) or (not (M.find x !recursive_map)))
    -> (* 関数適用の場合 (caml2html: inline_app) *)
      let (zs, e) = M.find x env in
      Format.eprintf "inlining %s@." x;
      let env' =
	List.fold_left2
	  (fun env' (z, t) y -> M.add z y env')
	  M.empty
	  zs
	  ys in
      Alpha.g env' e
  | App(x, ys) when M.mem x env -> (* limit inline expansion of recursive functions *)
    if limit mod recursive_limit = 0 then 
      let (zs, e) = M.find x env in
      Format.eprintf "inlining %s@." x;
      let env' =
	List.fold_left2
	  (fun env' (z, t) y -> M.add z y env')
	  M.empty
	  zs
	  ys in
      Alpha.g env' e
    else (Format.eprintf "limiting inline expansion of recursive function %s@." x;
        App(x, ys))
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g env limit e)
  | e -> e

let f limit e = g M.empty limit e
