open Asm

let rec g env = function (* 16 bit optimization of instructions *)
    | Ans(exp) -> Ans(g' env exp)
(*    | Let((x, t), Set(i), e) when (-32768 <= i) && (i < 32768) ->
            let e' = g (M.add x i env) e in
            if List.mem x (fv e') then Let((x, t), Li(i), e') else e' *)
    | Let(xt, exp, e) -> Let(xt, g' env exp, g env e)
and g' env = function (* 16 bit optimization of each instruction *)
    | Add(x, V(y)) when M.mem y env -> Add(x, C(M.find y env))
    | Add(x, V(y)) when M.mem x env -> Add(y, C(M.find x env))
    | Mul(x, V(y)) when M.mem y env -> Mul(x, C(M.find y env))
    | Mul(x, V(y)) when M.mem x env -> Mul(y, C(M.find x env))
    | SLL(x, V(y)) when M.mem y env -> SLL(x, C(M.find y env))
    | SRL(x, V(y)) when M.mem y env -> SRL(x, C(M.find y env))
    | SW(x, y, V(z)) when M.mem y env -> SW(x, y, C(M.find z env))
    | LW(x, V(y)) when M.mem y env -> LW(x, C(M.find y env)) 
    | SWC(x, y, V(z)) when M.mem y env -> SWC(x, y, C(M.find z env))
    | LWC(x, V(y)) when M.mem y env -> LWC(x, C(M.find y env))
    (*| IfEq(x, V(y), e1, e2) when M.mem y env ->
        IfEq(x, C(M.find y env), g env e1, g env e2)
    | IfLE(x, V(y), e1, e2) when M.mem y env ->
        IfLE(x, C(M.find y env), g env e1, g env e2)
    | IfGE(x, V(y), e1, e2) when M.mem y env ->
        IfGE(x, C(M.find y env), g env e1, g env e2)
    | IfEq(x, V(y), e1, e2) when M.mem x env ->
        IfEq(y, C(M.find x env), g env e1, g env e2)
    | IfLE(x, V(y), e1, e2) when M.mem x env ->
        IfGE(y, C(M.find x env), g env e1, g env e2)
    | IfGE(x, V(y), e1, e2) when M.mem x env ->
        IfLE(y, C(M.find x env), g env e1, g env e2)
    | IfEq(x, y', e1, e2) -> IfEq(x, y', g env e1, g env e2)
    | IfLE(x, y', e1, e2) -> IfLE(x, y', g env e1, g env e2)
    | IfGE(x, y', e1, e2) -> IfGE(x, y', g env e1, g env e2)
    | IfFEq(x, y, e1, e2) -> IfFEq(x, y, g env e1, g env e2)
    | IfFLE(x, y, e1, e2) -> IfFLE(x, y, g env e1, g env e2)*)
    | e -> e

(* 16 bit optimization of the top level function *)
let h { name = l; args = xs; fargs = ys; body = e; ret = t } = 
  { name = l; args = xs; fargs = ys; body = g M.empty e; ret = t }

(* 16 bit optimizaton of the whole program *)
let f (Prog(data, fundefs, e)) = 
  Prog(data, List.map h fundefs, g M.empty e)
