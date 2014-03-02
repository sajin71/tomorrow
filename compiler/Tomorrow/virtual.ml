(* translation into Tomorrow assembly with infinite number of virtual registers*)

open Asm

let data = ref [] (* constants table for float *) 

let classify xts ini addf addi =
    List.fold_left
        (fun acc (x, t) -> match t with
            | Type.Unit -> acc
            | Type.Float -> addf acc x
            | _ -> addi acc x t) ini xts

let separate xts =
    classify
        xts
        ([], [])
        (fun (int, float) x -> (int, float @ [x]))
        (fun (int, float) x _ -> (int @ [x], float))

let expand xts ini addf addi =
    classify
        xts
        ini
        (fun (offset, acc) x ->
            let offset = align offset in
            (offset + 4, addf x offset acc))
        (fun (offset, acc) x t ->
            (offset + 4, addi x t offset acc))

let rec g env = function (* generate virtual machine code *)
    | Closure.Unit -> Ans(Nop)
    | Closure.Int(i) -> Ans(Set(i))
    | Closure.Float(d) -> 
        let l =
        try
            (* reuse if it exists at constant table *)
            let (l, _) = List.find (fun (_, d') -> d = d') !data in
            l
        with Not_found ->
            let l = Id.L(Id.genid"l") in
            data := (l, d) :: !data;
            l in
            (*let x = Id.genid "l" in*)
            Ans(SetCLV(l))
            (*Let((x, Type.Int), SetL(l), Ans(LWC(x, C(0))))*)
    | Closure.Neg(x) -> Ans(Neg(x))
    | Closure.Add(x, y) -> Ans(Add(x, V(y)))
    | Closure.Sub(x, y) -> Ans(Sub(x, y))
    | Closure.Mul(x, y) -> Ans(Mul(x, V(y)))
    | Closure.Div(x, y) -> Ans(Div(x, V(y)))
    | Closure.FNeg(x) -> Ans(FNeg(x))
    | Closure.FAdd(x, y) -> Ans(FAdd(x, y))
    | Closure.FSub(x, y) -> Ans(FSub(x, y))
    | Closure.FMul(x, y) -> Ans(FMul(x, y))
    | Closure.FDiv(x, y) -> Ans(FDiv(x, y))
    | Closure.IfEq(x, y, e1, e2) ->
        (match M.find x env with
        | Type.Bool | Type.Int -> Ans(IfEq(x, y, g env e1, g env e2))
        | Type.Float -> Ans(IfFEq(x, y, g env e1, g env e2))
        | _ -> failwith "equality supported only for bool, int, and float")
    | Closure.IfLE(x, y, e1, e2) ->
        (match M.find x env with
        | Type.Bool | Type.Int -> 
                let tmp = Id.genid "tmp" in 
                Let((tmp, Type.Int), SLT(y, x), 
                Ans(IfEq(tmp, reg_zero, g env e1, g env e2)))(* Ans(IfLE(x, y, Id.genid "t", g env e1, g env e2)) *)
        | Type.Float -> Ans(IfFLE(x, y, g env e1, g env e2))
        | _ -> failwith "inequality supported only for bool, int, and float")
    | Closure.Let((x, t1), e1, e2) ->
        let e1' = g env e1 in
        let e2' = g (M.add x t1 env) e2 in
        concat e1' (x, t1) e2'
    | Closure.Var(x) ->
        (match M.find x env with
        | Type.Unit -> Ans(Nop)
        | Type.Float -> Ans(FMov(x)) 
        | _ -> Ans(Mov(x)))
    | Closure.MakeCls((x, t), {Closure.entry = l; Closure.actual_fv = ys}, e2) ->
        let e2' = g (M.add x t env) e2 in
        let offset, store_fv = 
            expand
                (List.map (fun y -> (y, M.find y env)) ys)
                (4, e2')
                (fun y offset store_fv -> seq(SWC(y, x, C(offset)), store_fv))
                (fun y _ offset store_fv -> seq(SW(y, x, C(offset)), store_fv)) in
                Let((x, t), Mov(reg_hp),
                Let((reg_hp, Type.Int), Add(reg_hp, C(align offset)),
                    let z = Id.genid "l" in
                    Let((z, Type.Int), SetL(l),  (* not sure if you need Setl *)
                    seq(SW(z, x, C(0)),
                        store_fv))))
    | Closure.AppCls("min_caml_sqrt", ys) | Closure.AppDir(Id.L("min_caml_sqrt"), ys)  
    when let int, float = separate (List.map (fun y -> (y, M.find y env)) ys) in
        List.length int = 0 && List.length float = 1
    (* using hardware instruction sqrt.s *)
    -> (match separate (List.map (fun y -> (y, M.find y env)) ys) with 
            | [], [y] -> Ans(FSqrt(y))
            | _ -> assert false) 
    | Closure.AppCls("min_caml_fabs", ys) | Closure.AppDir(Id.L("min_caml_fabs")
    ,ys)when let int, float = separate (List.map (fun y -> (y, M.find y env)) ys) in
        List.length int = 0 && List.length float = 1
    (* using hardware instruction abs.s *)
    -> (match separate (List.map (fun y -> (y, M.find y env)) ys) with 
            | [], [y] -> Ans(FAbs(y))
            | _ -> assert false) 
    | Closure.AppCls("min_caml_print_char", ys)  | Closure.AppDir(Id.L("min_caml_print_char") ,ys) 
    -> (match separate (List.map (fun y -> (y, M.find y env)) ys) with
            | [y], [] -> Ans(SW(y, reg_zero, C(-1))) 
            | _ -> assert false)
    | Closure.AppCls("min_caml_read_int", ys)  | Closure.AppDir(Id.L("min_caml_read_int") ,ys) 
    -> (match separate (List.map (fun y -> (y, M.find y env)) ys) with
            | [], [] -> Ans(LW(reg_zero, C(-1))) 
            | _ -> assert false)
    | Closure.AppCls("min_caml_read_float", ys)  | Closure.AppDir(Id.L("min_caml_read_float") ,ys) 
    -> (match separate (List.map (fun y -> (y, M.find y env)) ys) with
            | [], [] -> Ans(LWC(reg_zero, C(-2))) 
            | _ -> assert false)
    | Closure.AppCls(x, ys) ->
        let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in 
        Ans(CallCls(x, int, float))
    | Closure.AppDir(Id.L(x), ys) ->
        let (int, float) = separate (List.map (fun y -> (y, M.find y env)) ys) in
        Ans(CallDir(Id.L(x), int, float))
    | Closure.Tuple(xs) ->
        let y = Id.genid "t" in
        let (offset, store) =
        expand
            (List.map (fun x -> (x, M.find x env)) xs)
            (0, Ans(Mov(y)))
            (fun x offset store -> seq(SWC(x, y, C(offset)), store))
            (fun x _ offset store -> seq(SW(x, y, C(offset)), store)) in
            Let((y, Type.Tuple(List.map (fun x -> M.find x env) xs)), 
            Mov(reg_hp), Let((reg_hp, Type.Int), Add(reg_hp, C(align offset)),
            store))
    | Closure.LetTuple(xts, y, e2) ->
        let s = Closure.fv e2 in
        let (offset, load) =
            expand
                xts
                (0, g (M.add_list xts env) e2)
                (fun x offset load ->
                    if not (S.mem x s) then load else
                    fletd(x, LWC(y, C(offset)), load))
                (fun x t offset load ->
                    if not (S.mem x s) then load else
                    Let((x, t), LW(y, C(offset)), load)) in 
        load
    | Closure.Get(x, y) -> 
        let offset = Id.genid "o" in
        (match M.find x env with
        | Type.Array(Type.Unit) -> Ans(Nop)
        | Type.Array(Type.Float) ->
            Let((offset, Type.Int), SLL(y, C(2)), (* TODO not sure if 2 *)
            Ans(LWC(x, V(offset))))
        | Type.Array(_) ->
            Let((offset, Type.Int), SLL(y, C(2)),
            Ans(LW(x, V(offset))))
        | _ -> assert false)
    | Closure.Put(x, y, z) ->
        let offset = Id.genid "o" in
        (match M.find x env with
        | Type.Array(Type.Unit) -> Ans(Nop)
        | Type.Array(Type.Float) ->
            Let((offset, Type.Int), SLL(y, C(2)), (* TODO not sure if 2 *)
            Ans(SWC(z, x, V(offset)))) 
        | Type.Array(_) ->
            Let((offset, Type.Int), SLL(y, C(2)),
            Ans(SW(z, x, V(offset))))
        | _ -> assert false)
    | Closure.ExtArray(Id.L(x)) -> Ans(SetL(Id.L("min_caml_" ^ x))) (* not sure
    if use SetL *)

(* generate virtual machine code for functions *)
let h {Closure.name = (Id.L(x), t); Closure.args = yts; Closure.formal_fv = zts;
    Closure.body = e} =
        let (int, float) = separate yts in
        let (offset, load) =
            expand
                zts
                (4, g (M.add x t (M.add_list yts (M.add_list zts M.empty))) e)
                (fun z offset load -> fletd(z, LWC(reg_cl, C(offset)), load))
                (fun z t offset load -> Let((z, t), LW(reg_cl, C(offset)),
                load)) in
        match t with
        | Type.Fun(_, t2) ->
            { name = Id.L(x); args = int; fargs = float; body = load; ret = t2 }
        | _ -> Format.eprintf "fundefs error"; assert false

            

(* generate machine code for the whole program *)
let f (Closure.Prog(fundefs, e)) =
    data := [];
    let fundefs = List.map h fundefs in
    let e = g M.empty e in
    Prog(!data, fundefs, e)
