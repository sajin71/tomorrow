open Asm

external gethi : float -> int32 = "gethi"
external getlo : float -> int32 = "getlo"

let stackset = ref S.empty (* Set of already save variables *)
let stackmap = ref [] (* The position in the stack of the saved variables *)

let save x = 
    stackset := S.add x !stackset;
    if not (List.mem x !stackmap) then
        stackmap := !stackmap @ [x]

let savef x =
    stackset := S.add x !stackset;
    if not (List.mem x !stackmap) then
        (let pad =
            if List.length !stackmap mod 2 = 0 then [] else [Id.gentmp Type.Int] in 
        stackmap := !stackmap @ pad @ [x; x])

let locate x =
    let rec loc = function
        | [] -> []
        | y :: zs when x = y -> 0 :: List.map succ(loc zs)
        | y :: zs -> List.map succ (loc zs) in
        loc !stackmap

let offset x = 4 * List.hd (locate x)
let stacksize () = align ((List.length !stackmap + 1) * 4)

let reg r =
    if is_reg r then
        (String.sub r 0 1) ^ (String.sub r 2 (String.length r - 2))
    else r

let rec shuffle sw xys =
    (* remove identical moves *)
    let _, xys = List.partition (fun(x, y) -> x = y) xys in
    (* find acyclic moves *)
    match List.partition (fun(_, y) -> List.mem_assoc y xys) xys with
    | [], [] -> []
    | (x, y) :: xys, [] -> (* no acyclic moves; resolve cyclic move *)
            (y, sw) :: (x, y) :: shuffle sw (List.map
                        (function
                            | (y', z) when y = y' -> (sw, z)
                            | yz -> yz)
                            xys)
    | xys, acyc -> acyc @ shuffle sw xys

type dest = Tail | NonTail of Id.t 
(* Data type that shows whether it is tail or not *)

let rec g oc = function (* Emit assembly of instructions *)
    | (dest, Ans(exp)) -> g' oc (dest, exp)
    | (dest, Let((x, t), exp, e)) -> g' oc (NonTail (x), exp); g oc (dest, e)
and g' oc = function (* Emit assembly of each instruction *)
    (* Set result to dest if not tail *)
    | NonTail(_), Nop -> ()
    | NonTail(x), Set(i) -> Printf.fprintf oc "\tlli\t%s, %d\n" (reg x) i
    | NonTail(x), SetL(Id.L(y)) -> Printf.fprintf oc "\tset\t%s, %s\n" (reg y) (reg x)
    | NonTail(x), Mov(y) when x = y -> ()
    | NonTail(x), Mov(y) -> Printf.fprintf oc "\tmov\t%s, %s\n" (reg y) (reg x)
    | NonTail(x), Neg(y) -> Printf.fprintf oc "\tmuli\t%s, %s, %d\n" (reg x) (reg y) (-1)
    | NonTail(x), Add(y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), Add(y, C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg x) (reg y) z
    | NonTail(x), Sub(y, z) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), Mul(y, V(z)) -> Printf.fprintf oc "\tmul\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), Mul(y, C(z)) -> Printf.fprintf oc "\tmuli\t%s, %s, %d\n" (reg x) (reg y) z
    | NonTail(x), Div(y, z) -> Printf.fprintf oc "\tdiv\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), SLL(y, V(z)) -> Printf.fprintf oc "\tsll\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), SLL(y, C(z)) -> Printf.fprintf oc "\tsll\t%s, %s, %d\n" (reg x) (reg y) z
    | NonTail(x), SRL(y, V(z)) -> Printf.fprintf oc "\tsrl\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), SRL(y, C(z)) -> Printf.fprintf oc "\tsrl\t%s, %s, %d\n" (reg x) (reg y) z
    | NonTail(x), LW(y, z) -> Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) z (reg y)
    | NonTail(_), SW(x, y, z) -> Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) z (reg y)
    | NonTail(x), FMov(y) when x = y -> ()
    | NonTail(x), FMov(y) -> 
            Printf.fprintf oc "\tfmov\t%s, %s\n" (reg x) (reg y);
            Printf.fprintf oc "\tfmov\t%s, %s\n" (co_freg y) (co_freg x)
    | NonTail(x), FNeg(y) -> 
            Printf.fprintf oc "\tnop\n" (* TODO float calculation *)
    | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\tfadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\tfsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\tfmul\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), FDiv(y, z) -> Printf.fprintf oc "\tfdiv\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(_), Comment(s) -> Printf.fprintf oc "\t# %s\n" s
    (* save *)
    | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) 
        -> save y;
            Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
    | NonTail(_), Save(x, y) when List.mem x allfregs && not(S.mem y !stackset)
        -> save y;
            Printf.fprintf oc "\tsw\t%s, %d(%s)\n" x (offset y) (reg reg_sp)
    | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
    (* restore *)
    | NonTail(x), Restore(y) when List.mem x allregs ->
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
    | NonTail(x), Restore(y) ->
        assert (List.mem x allfregs);
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
    (* tail *)
    | Tail, (Nop | SW _ | Comment _ | Save _ as exp) ->
        g' oc (NonTail(Id.gentmp Type.Unit), exp);
        Printf.fprintf oc "jr $31\n"; 
        Printf.fprintf oc "\tnop\n"
    | Tail, (Set _ | SetL _ | Mov _ | Neg _ | Add _ | Sub _ |Mul _ | Div _ | SLL _ | SRL _ | LW _ 
        as exp) ->
            g' oc (NonTail(regs.(0)), exp);
            Printf.fprintf oc "\tjr $31\n";
            Printf.fprintf oc "\tnop\n"
    | Tail, (FMov _ | FNeg _ | FAdd _ | FSub _ | FMul _ | FDiv _ as exp) ->
        g' oc (NonTail(fregs.(0)), exp);
        Printf.fprintf oc "\tjr $31\n";
        Printf.fprintf oc "\tnop\n"
    | Tail, (Restore(x) as exp) ->
        (match locate x with
        | [i] -> g' oc (NonTail(regs.(0)), exp)
        | [i; j] when (i + 1 = j) -> g' oc (NonTail(fregs.(0)), exp) (* not sure*) 
        | _ -> assert false);
        Printf.fprintf oc "\tjr $31\n";
        Printf.fprintf oc "\tnop\n"
    | Tail, IfEq(x, y, e1, e2) ->
        let b_else = Id.genid ("beq_else") in
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg x) (reg y) b_else;
        Printf.fprintf oc "\tnop\n";
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2)
    | Tail, IfLE(x, y, e1, e2) ->
        let b_else = Id.genid("ble_else") in
        Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sw) (reg y) 1;
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg reg_sw) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_sw) (reg reg_zero) b_else;
        Printf.fprintf oc "\tnop\n";
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2)
    | Tail, IfGE(x, y, e1, e2) ->
        let b_else = Id.genid("bge_else") in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg y) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_sw) (reg reg_zero) b_else;   
        Printf.fprintf oc "\tnop\n";
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2)
    | Tail, IfFEq(x, y, e1, e2) -> (* TODO for float calculation *)
        Printf.fprintf oc "\tnop\n"
    | NonTail(z), IfEq(x, y, e1, e2) ->
        let b_else = Id.genid "beq_else" in
        let b_cont = Id.genid "beq_cont" in
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg x) (reg y) b_else;
        Printf.fprintf oc "\tnop\n";
        let stackset_back = !stackset in
        g oc (NonTail(z), e1); 
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        Printf.fprintf oc "\tnop\n";
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2
    | NonTail(z), IfLE(x, y, e1, e2) -> 
        let b_else = Id.genid "ble_else" in
        let b_cont = Id.genid "ble_cont" in
        Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sw) (reg y) 1;
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg reg_sw) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_sw) (reg reg_zero) b_else;
        Printf.fprintf oc "\tnop\n";
        let stackset_back = !stackset in
        g oc (NonTail(z), e1);
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        Printf.fprintf oc "\tnop\n";
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2
    | NonTail(z), IfGE(x, y, e1, e2) ->
        let b_else = Id.genid "beq_else" in
        let b_cont = Id.genid "beq_cont" in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg y) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_zero) (reg reg_sw) b_else;
        Printf.fprintf oc "\tnop\n";
        let stackset_back = !stackset in
        g oc (NonTail(z), e1); 
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        Printf.fprintf oc "\tnop\n";
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2
    | NonTail(z), IfFEq(x, y, e1, e2) -> (* TODO float calculation *)
        Printf.fprintf oc "\tnop\n"
    | NonTail(z), IfFLE(x, y, e1, e2) -> (* TODO float calculation *)
        Printf.fprintf oc "\tnop\n"
    (* implementation of function call *)
    | Tail, CallCls(x, ys, zs) -> (* call at tail *)
        g'_args oc [(x, reg_cl)] ys zs;
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_sw) 0 (reg reg_cl);
        Printf.fprintf oc "\tj\t%s\n" (reg reg_sw);
        Printf.fprintf oc "\tnop\n"
    | Tail, CallDir(Id.L(x), ys, zs) -> (* call at tail *)
        g'_args oc [] ys zs;
        Printf.fprintf oc "\tj\t%s\n" x;
        Printf.fprintf oc "\tnop\n"
    | NonTail(a), CallCls(x, ys, zs) ->
        g'_args oc [(x, reg_cl)] ys zs;
        let ss = stacksize () in
        Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp);
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_sw)  0 (reg reg_cl) ;
        Printf.fprintf oc "\tjal\t%s\n" (reg reg_sw);
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp); 
        if List.mem a allregs && a <> regs.(0) then
            Printf.fprintf oc "\tmov\t%s, %s\n" regs.(0) a
        else if List.mem a allfregs && a <> fregs.(0) then
            (Printf.fprintf oc "\tfmov\t%s, %s\n" fregs.(0) a;
            Printf.fprintf oc "\tfmov\t%s, %s\n" (co_freg fregs.(0)) (co_freg a))
   | NonTail(a), CallDir(Id.L(x), ys, zs) ->
        g'_args oc [] ys zs;
        let ss = stacksize () in
        Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp);
        Printf.fprintf oc "\tjal\t%s\n" x;
        Printf.fprintf oc "\tlw\t %s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp);
        if List.mem a allregs && a <> regs.(0) then
            Printf.fprintf oc "\tmov\t%s, %s\n" regs.(0) a
        else if List.mem a allfregs && a <> fregs.(0) then
            (Printf.fprintf oc "\tfmov\t%s, %s\n" fregs.(0) a;
            Printf.fprintf oc "\tfmov\t%s, %s\n" (co_freg fregs.(0)) (co_freg a))
(*and g'_tail_if oc e1 e2 reg1 reg2 b bn =
    let b_else = Id.genid(b ^ "_else") in
    Printf.fprintf oc "\t%s\t%s\n" bn b_else;
    Printf.fprintf oc "\tnop\n";
    let stackset_back = !stackset in
    g oc (Tail, e1);
    Printf.fprintf oc "%s:\n" b_else;
    stackset := stackset_back;
    g oc (Tail, e2)
and g'_non_tail_if oc dest e1 e2 reg1 reg2 b bn =
    let b_else = Id.genid (b ^ "_else") in
    let b_cont = Id.genid (b ^ "_cont") in
    Printf.fprintf oc "\t%s\t%s\n" bn b_else;
    Printf.fprintf oc "\tnop\n";
    let stackset_back = !stackset in
    g oc (dest, e1);
    let stackset1 = !stackset in
    Printf.fprintf oc ""
    Printf.fprintf oc "\tnop\n";
    Printf.fprintf oc "%s:\n" b_else;
    stackset := stackset_back; *)
and g'_args oc x_reg_cl ys zs =
    let (i, yrs) =
        List.fold_left
            (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
            (0, x_reg_cl)
            ys in
    List.iter
        (fun (y, r) -> Printf.fprintf oc "\tmov\t%s, %s\n" (reg y) (reg r))
        (shuffle reg_sw yrs);
    let (d, zfrs) =
        List.fold_left
            (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
            (0, [])
            zs in
    List.iter
        (fun (z, fr) ->
            Printf.fprintf oc "\tfmov\t%s, %s\n" (reg z) fr;
            Printf.fprintf oc "\tfmov\t%s, %s\n" (co_freg z) (co_freg fr))
        (shuffle reg_fsw zfrs)


let h oc { name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  Printf.fprintf oc "%s:\n" x;
  stackset := S.empty;
  stackmap := [];
  g oc (Tail, e)


let f oc (Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  Printf.fprintf oc ".section\t\".rodata\"\n";
  Printf.fprintf oc ".align\t8\n";
  List.iter
    (fun (Id.L(x), d) ->
      Printf.fprintf oc "%s:\t! %f\n" x d;
      Printf.fprintf oc "\t.long\t0x%lx\n" (gethi d);
      Printf.fprintf oc "\t.long\t0x%lx\n" (getlo d))
    data;
  Printf.fprintf oc ".section\t\".text\"\n";
  List.iter (fun fundef -> h oc fundef) fundefs;
  Printf.fprintf oc ".global\tmin_caml_start\n";
  Printf.fprintf oc "min_caml_start:\n";
  (*Printf.fprintf oc "\tsave\t%%sp, -112, %%sp\n";*) (* from gcc; why 112? *)
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail(regs.(0)), e);
  Printf.fprintf oc "\thalt\n"
