open KNormal

let threshold = ref 5

let rec g env = function
  | Unit | Int _ | Float _ as e -> e
  | e when (not (effect e)) && (size e <= !threshold) && (M.mem (t_to_string e) env) -> 
          let e_string = t_to_string e in
          Format.eprintf "eliminating subexpression %s@." e_string; 
          Var(M.find e_string env) 
  | IfEq(x, y, e1, e2) -> IfEq(x, y, g env e1, g env e2)
  | IfLE(x, y, e1, e2) -> IfLE(x, y, g env e1, g env e2)
  | Let(xt, e1, e2) -> let e1' = g env e1 in
          let env' = if size e1' <= !threshold then M.add (t_to_string e1') (fst xt) env
                        else env in
          let e2' = g env' e2 in
          Let(xt, e1', e2')
  | LetRec({ name = (x, t); args = yts; body = e1}, e2) ->
          LetRec({ name = (x,t); args = yts; body = g env e1}, g env e2)
  | LetTuple(xts, y, e) -> LetTuple(xts, y, g env e)                  
  | e -> e

let f e = g M.empty e
