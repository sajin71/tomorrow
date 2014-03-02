open KNormal

(* インライン展開する関数の最大サイズ (caml2html: inline_threshold) *)
let threshold = ref 0 (* Mainで-inlineオプションによりセットされる *)

let recursive_limit = 6

let one_app_weight = 5 

let recursive_map = ref M.empty (* show if the function is recursive or not *)

let max_nest_map = ref M.empty (* show the max recusive nest the function is called *)

let app_counts = ref M.empty (* shows how many times each functions were applied *)

let rec setup_app_count = function
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) -> 
            setup_app_count e1; setup_app_count e2
    | LetRec({ name = _; args = _; body = e1 }, e2) ->
            setup_app_count e1; setup_app_count e2
    | App(x, _) -> let n = if M.mem x !app_counts then M.find x !app_counts else 0
                    in app_counts := M.add x (n + 1) !app_counts
    | _ -> ()

let find_app_count x =
    if M.mem x !app_counts then M.find x !app_counts
    else (Format.eprintf "function %s not found in app_counts@." x; 0)

let rec setup_recursive_map = function
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) ->
            setup_recursive_map e1; setup_recursive_map e2
    | LetRec({ name = (x, t); args = _; body = e1 }, e2) ->
            (if S.mem x (fv e1) then 
                (Format.eprintf "recursive function %s added@." x;
                recursive_map := M.add x true !recursive_map)
            else recursive_map := M.add x false !recursive_map);
            setup_recursive_map e1; setup_recursive_map e2
    | _ -> ()

let find_if_recursive x =
    if M.mem x !recursive_map then M.find x !recursive_map
    else (Format.eprintf "function %s not found in recursive_map@." x; false)

let rec setup_max_nest_map nest = function
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) | Let(_, e1, e2) ->
            setup_max_nest_map nest e1; setup_max_nest_map nest e2
    | LetRec({ name = (x, t); args = _; body = e1 }, e2) ->
            (if M.mem x !max_nest_map then () 
            else max_nest_map := M.add x 0 !max_nest_map);
            let nest' = if find_if_recursive x then nest + 1 else nest in
            setup_max_nest_map nest' e1; setup_max_nest_map nest e2
    | App(x, _) ->
            (try 
                (if M.find x !max_nest_map < nest then 
                    max_nest_map := M.add x nest !max_nest_map)
            with Not_found -> max_nest_map := M.add x nest !max_nest_map)
    | _ -> ()

let find_max_nest x =
    if M.mem x !max_nest_map then M.find x !max_nest_map
    else (Format.eprintf "function %s not found in max_nest_map@." x; 0) 



(*let rec get_app_count f = function (* currently not using it *)
    | IfEq(_, _, e1, e2) | IfLE(_, _, e1, e2) 
        -> max (get_app_count f e1) (get_app_count f e2)
    | Let(xt, e1, e2) -> (get_app_count f e1) + (get_app_count f e2) 
    | App(x, ys) when x = f -> 1
    | LetRec({ name = (x, t); args = yts; body = e1 }, e2) when x = f ->
            get_app_count f e1 * get_app_count x e2
    | LetRec({ name = (x, t); args = _; body = e1 }, e2) ->
            get_app_count f e1 * get_app_count x e2 + get_app_count f e2
    | _ -> 0 *)

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


let rec g env limit nest= function (* インライン展開ルーチン本体 (caml2html: inline_g) *)
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env limit nest e1, g env limit nest e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env limit nest e1, g env limit nest e2)
  | Let(xt, e1, e2) -> Let(xt, g env limit nest e1, g env limit nest e2)
  | LetRec({ name = (x, t); args = yts; body = e1 }, e2) -> (* 関数定義の場合 (caml2html: inline_letrec) *)
      let is_recursive = find_if_recursive x in
      if nest + 1 >= 2 then Format.eprintf "nested recursion@.";
      let nest' = if is_recursive then nest + 1 else nest in
      let env' = 
          if (size e1 <= (!threshold) * (nest + 1)) 
            || (size e1 <= (!threshold) * (find_max_nest x + 1)) 
            || ((find_app_count x = 1) && (size e1 <= (!threshold * one_app_weight))) 
            then M.add x (yts, e1) env else env in
      LetRec({ name = (x, t); args = yts; body = g env' limit nest' e1}, g env' limit nest e2)
  | App(x, ys) as exp
    when M.mem x env && ((not (M.mem x !recursive_map)) or (not (M.find x !recursive_map)))
    -> (* 関数適用の場合 (caml2html: inline_app) *)
    let (zs, e) = M.find x env in
    if (size e / (nest + 1)) <= !threshold then 
      (Format.eprintf "inlining %s@." x;
      let env' =
	List.fold_left2
	  (fun env' (z, t) y -> M.add z y env')
	  M.empty
	  zs
	  ys in
      Alpha.g env' e)
    else exp 
  | App(x, ys) as exp when M.mem x env -> (* limit inline expansion of recursive functions *)
    if limit mod recursive_limit = 0 then 
      let (zs, e) = M.find x env in
      if (size e / (nest + 1)) <= !threshold then 
      (Format.eprintf "inlining %s@." x;
      let env' =
	List.fold_left2
	  (fun env' (z, t) y -> M.add z y env')
	  M.empty
	  zs
	  ys in
      Alpha.g env' e) else exp 
    else (Format.eprintf "limiting inline expansion of recursive function %s@." x;
        App(x, ys))
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g env limit nest e)
  | e -> e

let f limit e = recursive_map := M.empty; app_counts := M.empty; 
                max_nest_map := M.empty; setup_app_count e; setup_recursive_map e; 
                setup_max_nest_map 0 e; g M.empty limit 0 e
