open Asm

external get_int32 : float -> int32 = "get_int32"
(*external gethi : float -> int32 = "gethi"*)
(*external getlo : float -> int32 = "getlo" *)

let log2 x = log10 x /. log10 2.

let stackset = ref S.empty (* Set of already save variables *)
let stackmap = ref [] (* The position in the stack of the saved variables *)

let save x = 
    stackset := S.add x !stackset;
    if not (List.mem x !stackmap) then
        stackmap := !stackmap @ [x]

(* let savef x =
    stackset := S.add x !stackset;
    if not (List.mem x !stackmap) then
        (let pad =
            if List.length !stackmap mod 2 = 0 then [] else [Id.gentmp Type.Int] in 
        stackmap := !stackmap @ pad @ [x; x])
*)
let locate x =
    let rec loc = function
        | [] -> []
        | y :: zs when x = y -> 0 :: List.map succ (loc zs)
        | y :: zs -> List.map succ (loc zs) in
        loc !stackmap

let offset x = try 4 * List.hd (locate x) with Failure("hd") -> Format.eprintf "not found %s@." x; assert false
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
    | NonTail(x), Set(i) -> Printf.fprintf oc "\tset\t%s, %d\n" (reg x) i
    | NonTail(x), SetL(Id.L(y)) -> Printf.fprintf oc "\tsetl\t%s, %s\n" (reg x) y
    | NonTail(x), SetCLV(Id.L(y)) -> Printf.fprintf oc "\tsetclv\t%s, %s\n" x y
    | NonTail(x), Mov(y) when x = y -> ()
    | NonTail(x), Mov(y) -> (* Printf.fprintf oc "\t#NonTail Mov\n"; *)
            Printf.fprintf oc "\tmov\t%s, %s\n" (reg x) (reg y)
    | NonTail(x), Neg(y) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg x) (reg
    reg_zero) (reg x)
    | NonTail(x), Add(y, V(z)) -> Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), Add(y, C(z)) -> Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg x) (reg y) z
    | NonTail(x), Sub(y, z) -> Printf.fprintf oc "\tsub\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), Mul(y, V(z)) -> Printf.fprintf oc "\tsll\t %s, %s, 2\n" (reg x) (reg y)
    (*TODO tenuki"\tmulerror\n"*) 
    | NonTail(x), Mul(y, C(z)) -> Printf.fprintf oc "\tsll\t%s, %s, %d\n" (reg
    x) (reg y) (int_of_float (log2 (float_of_int z)))
    | NonTail(x), Div(y, V(z)) -> Printf.fprintf oc "\tsra\t%s, %s, 1\n" (reg x) (reg y) 
    (*TODO tenuki"\tdiverror\n"*)
    | NonTail(x), Div(y, C(z)) -> Printf.fprintf oc "\tsra\t%s, %s, %d\n" (reg
    x) (reg y) (int_of_float (log2 (float_of_int z)))
    | NonTail(x), SLL(y, V(z)) -> Printf.fprintf oc "\tsll\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), SLL(y, C(z)) -> Printf.fprintf oc "\tsll\t%s, %s, %d\n" (reg x) (reg y) z
    | NonTail(x), SRL(y, V(z)) -> Printf.fprintf oc "\tsrl\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), SRL(y, C(z)) -> Printf.fprintf oc "\tsrl\t%s, %s, %d\n" (reg x) (reg y) z
    | NonTail(x), LW(y, V(z)) -> 
            Format.eprintf "error variable LW@."; assert false
            (*Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg (reg_sw)) (reg z) (reg y);
            Printf.fprintf oc "\tlw\t%s, 0(%s)\n" (reg x) (reg (reg_sw)) *)
    | NonTail(x), LW(y, C(z)) -> Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) z (reg y)
    | NonTail(_), SW(x, y, V(z)) -> 
            Format.eprintf "error variable SW@."; assert false
            (*Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg (reg_sw)) (reg z) (reg y);
            Printf.fprintf oc "\tsw\t%s, 0(%s)\n" (reg x) (reg (reg_sw)) *)
    | NonTail(_), SW(x, y, C(z)) -> Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) z (reg y)
    | NonTail(x), SLT(y, z) -> Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg x) (reg y) (reg z)
    | NonTail(x), FMov(y) when x = y -> ()
    | NonTail(x), FMov(y) -> 
            Printf.fprintf oc "\tmov.s\t%s, %s\n"  x y
            (*Printf.fprintf oc "\tmov.s\t%s, %s\n" (co_freg x) (co_freg y)*)
    | NonTail(x), FNeg(y) -> 
            Printf.fprintf oc "\tneg.s\t%s, %s\n" x y
    | NonTail(x), FAdd(y, z) -> Printf.fprintf oc "\tadd.s\t%s, %s, %s\n"  x y z
    | NonTail(x), FSub(y, z) -> Printf.fprintf oc "\tsub.s\t%s, %s, %s\n"  x y z
    | NonTail(x), FMul(y, z) -> Printf.fprintf oc "\tmul.s\t%s, %s, %s\n"  x y z
    | NonTail(x), FDiv(y, z) -> Printf.fprintf oc "\tdiv.s\t%s, %s, %s\n" x y z
    | NonTail(x), LWC(y, V(z)) ->
            Format.eprintf "error variable LWC@."; assert false
            (*Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg (reg_sw)) (reg z) (reg y);
            Printf.fprintf oc "\tlwc\t%s, 0(%s)\n" x (reg reg_sw) *)
    | NonTail(x), LWC(y, C(z)) -> Printf.fprintf oc "\tlwc\t%s, %d(%s)\n" x z (reg y)
    | NonTail(_), SWC(x, y, V(z)) -> 
            Format.eprintf "error variable SWC@."; assert false
            (*Printf.fprintf oc "\tadd\t%s, %s, %s\n" (reg (reg_sw)) (reg z) (reg y);
            Printf.fprintf oc "\tswc\t%s, 0(%s)\n" x (reg (reg_sw))*)
    | NonTail(_), SWC(x, y, C(z)) -> Printf.fprintf oc "\tswc\t%s, %d(%s)\n" x z (reg y)
    | NonTail(x), FAbs(y) ->
            Printf.fprintf oc "\tabs.s\t%s, %s\n" x y
    | NonTail(x), FSqrt(y) ->
            Printf.fprintf oc "\tsqrt.s\t%s, %s\n" x y
    | NonTail(_), Comment(s) -> Printf.fprintf oc "\t# %s\n" s
    (* save *)
    | NonTail(_), Save(x, y) when List.mem x allregs && not (S.mem y !stackset) 
        -> save y;
            Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
    | NonTail(_), Save(x, y) when List.mem x allfregs && not(S.mem y !stackset)
        -> save y;
            Printf.fprintf oc "\tswc\t%s, %d(%s)\n" x (offset y) (reg reg_sp)
    | NonTail(_), Save(x, y) -> assert (S.mem y !stackset); ()
    (* restore *)
    | NonTail(x), Restore(y) when List.mem x allregs ->
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg x) (offset y) (reg reg_sp)
    | NonTail(x), Restore(y) ->
        assert (List.mem x allfregs);
        Printf.fprintf oc "\tlwc\t%s, %d(%s)\n" x (offset y) (reg reg_sp)
    (* tail *)
    | Tail, (Nop | SW _ | SWC _ | Comment _ | Save _ as exp) ->
        g' oc (NonTail(Id.gentmp Type.Unit), exp);
        Printf.fprintf oc "\tjr $31\n" 
        (*Printf.fprintf oc "\tnop\n"*)
    | Tail, (Set _ | SetL _ |  Mov _ | Neg _ | Add _ | Sub _ |Mul _ | Div _ | SLL _ | SRL _ | LW _ | SLT _
        as exp) ->
            g' oc (NonTail(regs.(0)), exp);
            Printf.fprintf oc "\tjr $31\n"
            (*Printf.fprintf oc "\tnop\n"*)
    | Tail, (FMov _ | FNeg _ | SetCLV _  |FAdd _ | FSub _ | FMul _ | FDiv _  | LWC _ | FSqrt _ | FAbs _ as exp) ->
        g' oc (NonTail(fregs.(0)), exp);
        Printf.fprintf oc "\tjr $31\n"
        (*Printf.fprintf oc "\tnop\n"*)
    | Tail, (Restore(x) as exp) ->
        (match locate x with
        | [i] -> g' oc (NonTail(regs.(0)), exp)
        | [i; j] when (i + 1 = j) -> g' oc (NonTail(fregs.(0)), exp) (* not sure*) 
        | _ -> assert false);
        Printf.fprintf oc "\tjr $31\n";
        (*Printf.fprintf oc "\tnop\n"*)
    | Tail, IfEq(x, y, e1, e2) ->
        let b_else = Id.genid ("beq_else") in
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg x) (reg y) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2)
    (* | Tail, IfLE(x, y, z, e1, e2) ->
        let b_else = Id.genid("ble_else") in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg z) (reg y) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg z) (reg reg_zero) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2) *)
    | Tail, IfLE(x, y, e1, e2) ->
        Format.eprintf "Error IfLE@."; assert false
        (* let b_else = Id.genid("ble_else") in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg y) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_sw) (reg reg_zero) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2)*)  
    (* | Tail, IfGE(x, y, z, e1, e2) ->
        let b_else = Id.genid("bge_else") in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg z) (reg x) (reg y);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg z) (reg reg_zero) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2) *)
    | Tail, IfGE(x, y, e1, e2) ->
        Format.eprintf "Error IfGE@."; assert false
        (*let b_else = Id.genid("bge_else") in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg x) (reg y);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_sw) (reg reg_zero) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2) *) 
    | Tail, IfFEq(x, y, e1, e2) -> (* TODO for float calculation *)
        let b_else = Id.genid("fbeq_else") in
        Printf.fprintf oc "\tc.eq.s\t%s, %s\n"  x y;
        Printf.fprintf oc "\tbcf\t%s\n" b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2)
    | Tail, IfFLE(x, y, e1, e2) ->
        let b_else = Id.genid("fble_else") in
        Printf.fprintf oc "\tc.olt.s\t%s, %s\n" y x;
        Printf.fprintf oc "\tbct\t%s\n" b_else;
        let stackset_back = !stackset in
        g oc (Tail, e1);
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (Tail, e2)
    | NonTail(z), IfEq(x, y, e1, e2) ->
        let b_else = Id.genid "beq_else" in
        let b_cont = Id.genid "beq_cont" in
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg x) (reg y) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (NonTail(z), e1); 
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        (*Printf.fprintf oc "\tnop\n";*)
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2
    (* | NonTail(z), IfLE(x, y, tmp, e1, e2) -> 
        let b_else = Id.genid "ble_else" in
        let b_cont = Id.genid "ble_cont" in
        (*Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sw) (reg y) 1;*)
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg tmp) (reg y) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg tmp) (reg reg_zero) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (NonTail(z), e1);
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        (*Printf.fprintf oc "\tnop\n";*)
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2 *)
    | NonTail(z), IfLE(x, y, e1, e2) -> 
        Format.eprintf "Error IfLE@."; assert false
        (* let b_else = Id.genid "ble_else" in
        let b_cont = Id.genid "ble_cont" in
        (*Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sw) (reg y) 1;*)
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg y) (reg x);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_sw) (reg reg_zero) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (NonTail(z), e1);
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        (*Printf.fprintf oc "\tnop\n";*)
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2 *) 
    (* | NonTail(z), IfGE(x, y, tmp, e1, e2) ->
        let b_else = Id.genid "beq_else" in
        let b_cont = Id.genid "beq_cont" in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg tmp) (reg x) (reg y);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_zero) (reg tmp) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (NonTail(z), e1); 
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        (*Printf.fprintf oc "\tnop\n";*)
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2 *)
    | NonTail(z), IfGE(x, y, e1, e2) ->
        Format.eprintf "Error IfGE@."; assert false
        (* let b_else = Id.genid "beq_else" in
        let b_cont = Id.genid "beq_cont" in
        Printf.fprintf oc "\tslt\t%s, %s, %s\n" (reg reg_sw) (reg x) (reg y);
        Printf.fprintf oc "\tbne\t%s, %s, %s\n" (reg reg_zero) (reg reg_sw) b_else;
        (*Printf.fprintf oc "\tnop\n";*)
        let stackset_back = !stackset in
        g oc (NonTail(z), e1); 
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        (*Printf.fprintf oc "\tnop\n";*)
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2*) 
    | NonTail(z), IfFEq(x, y, e1, e2) -> (* TODO float calculation *)
        let b_else = Id.genid "fbeq_else" in
        let b_cont = Id.genid "fbeq_cont" in
        Printf.fprintf oc "\tc.eq.s\t%s,%s\n" x y;
        Printf.fprintf oc "\tbcf\t%s\n" b_else;
        let stackset_back = !stackset in
        g oc (NonTail(z), e1);
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2
        (*Printf.fprintf oc "\tnop\n"*)
    | NonTail(z), IfFLE(x, y, e1, e2) -> (* TODO float calculation *)
        let b_else = Id.genid "fbeq_else" in
        let b_cont = Id.genid "fbeq_cont" in
        Printf.fprintf oc "\tc.olt.s\t%s, %s\n" y x;
        Printf.fprintf oc "\tbct\t%s\n" b_else;
        let stackset_back = !stackset in
        g oc (NonTail(z), e1);
        let stackset1 = !stackset in
        Printf.fprintf oc "\tj\t%s\n" b_cont;
        Printf.fprintf oc "%s:\n" b_else;
        stackset := stackset_back;
        g oc (NonTail(z), e2);
        Printf.fprintf oc "%s:\n" b_cont;
        let stackset2 = !stackset in
        stackset := S.inter stackset1 stackset2
        (*Printf.fprintf oc "\tnop\n"*)
    (* implementation of function call *)
    | Tail, CallCls(x, ys, zs) -> (* call at tail *)
        g'_args oc [(x, reg_cl)] ys zs;
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_sw) 0 (reg reg_cl);
        Printf.fprintf oc "\tjr\t%s\n" (reg reg_sw)
        (*Printf.fprintf oc "\tnop\n"*)
    | Tail, CallDir(Id.L(x), ys, zs) -> (* call at tail *)
        g'_args oc [] ys zs;
        Printf.fprintf oc "\tj\t%s\n" x
        (*Printf.fprintf oc "\tnop\n"*)
    | NonTail(a), CallCls(x, ys, zs) ->
        g'_args oc [(x, reg_cl)] ys zs;
        let ss = stacksize () in
        Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp);
        Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_sw)  0 (reg reg_cl) ;
        Printf.fprintf oc "\tjal\tclosure_indirect\n";
        Printf.fprintf oc "\tnop\n";
        Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) (-ss);
        Printf.fprintf oc "\tlw\t%s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp); 
        (* Printf.fprintf oc "\t#NonTail CallCls\n"; *)
        if List.mem a allregs && a <> regs.(0) then
            Printf.fprintf oc "\tmov\t%s, %s\n" (reg a) (reg regs.(0))
        else if List.mem a allfregs && a <> fregs.(0) then
            (Printf.fprintf oc "\tmov.s\t%s, %s\n" a fregs.(0);
            (*Printf.fprintf oc "\tmov.s\t%s, %s\n" (co_freg a) (co_freg
             * fregs.(0))*))
   | NonTail(a), CallDir(Id.L(x), ys, zs) ->
        g'_args oc [] ys zs;
        let ss = stacksize () in
        Printf.fprintf oc "\tsw\t%s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp);
        Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) ss;
        Printf.fprintf oc "\tjal\t%s\n" x;
        Printf.fprintf oc "\tnop\n";
        Printf.fprintf oc "\taddi\t%s, %s, %d\n" (reg reg_sp) (reg reg_sp) (-ss);
        Printf.fprintf oc "\tlw\t %s, %d(%s)\n" (reg reg_ra) (ss - 4) (reg reg_sp);
        (* Printf.fprintf oc "\t#NonTail CallDir\n"; *)
        if List.mem a allregs && a <> regs.(0) then
            Printf.fprintf oc "\tmov\t%s, %s\n" (reg a) (reg regs.(0))
        else if List.mem a allfregs && a <> fregs.(0) then
            (Printf.fprintf oc "\tmov.s\t%s, %s\n" a fregs.(0);
            (*Printf.fprintf oc "\tmov.s\t%s, %s\n" (co_freg a) (co_freg  fregs.(0))*))
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
    (* Printf.fprintf oc "\t#g'_args\n"; *)
    let (i, yrs) =
        List.fold_left
            (fun (i, yrs) y -> (i + 1, (y, regs.(i)) :: yrs))
            (0, x_reg_cl)
            ys in
    List.iter
        (fun (y, r) -> Printf.fprintf oc "\tmov\t%s, %s\n" (reg r) (reg y))
        (shuffle reg_sw yrs);
    let (d, zfrs) =
        List.fold_left
            (fun (d, zfrs) z -> (d + 1, (z, fregs.(d)) :: zfrs))
            (0, [])
            zs in
    List.iter
        (fun (z, fr) ->
            Printf.fprintf oc "\tmov.s\t%s, %s\n" fr z;
            (*Printf.fprintf oc "\tmov.s\t%s, %s\n" (co_freg fr) (co_freg z)*))
        (shuffle reg_fsw zfrs)


let h oc { name = Id.L(x); args = _; fargs = _; body = e; ret = _ } =
  Printf.fprintf oc "%s:\n" x;
  stackset := S.empty;
  stackmap := [];
  g oc (Tail, e)


let f oc (Prog(data, fundefs, e)) =
  Format.eprintf "generating assembly...@.";
  Printf.fprintf oc "\tlui\t$29, 0x8000\n";
  Printf.fprintf oc "\tlui\t$30, 0x8001\n";
  Printf.fprintf oc "\tlui\t$3, 0x8003\n";
  Printf.fprintf oc "\taddi\t$4, $3, 4\n";
  Printf.fprintf oc "\tsw\t$4, 0($3)\n";

  Printf.fprintf oc "\tjal\tmin_caml_start\n";
  Printf.fprintf oc "\tnop\n";
  Printf.fprintf oc "\thalt\n";
  (* emitting float constant table *)
  List.iter
    (fun (Id.L(x), d) ->
      Printf.fprintf oc "%s:\t# %f\n" x d;
      Printf.fprintf oc "\t.long\t0x%lx\n" (get_int32 d))
      (*Printf.fprintf oc "\t.long\t0x%lx\n" (gethi d);
      Printf.fprintf oc "\t.long\t0x%lx\n" (getlo d))*)
    data;

  (*emitting print_int and print_char*)
  (*Printf.fprintf oc "min_caml_print_int:\n";
  Printf.fprintf oc "\tsw\t$1, -1($0)\n";
  Printf.fprintf oc "\tjr\t$31\n";
  Printf.fprintf oc "min_caml_print_char:\n";
  Printf.fprintf oc "\tsw\t$1, -1($0)\n";
  Printf.fprintf oc "\tjr\t$31\n";*)

  Printf.fprintf oc "closure_indirect:\n";
  Printf.fprintf oc "\tjr\t$27\n";

  List.iter (fun fundef -> h oc fundef) fundefs;
  Printf.fprintf oc "min_caml_start:\n";
  (*Printf.fprintf oc "\tsave\t%%sp, -112, %%sp\n";*) (* from gcc; why 112? *)
  stackset := S.empty;
  stackmap := [];
  g oc (NonTail(regs.(0)), e);
  Printf.fprintf oc "\tjr\t$31\n"
