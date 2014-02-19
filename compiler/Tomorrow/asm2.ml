type ret =
    | Value of (Id.t * Type.t) option
    | Cls of Id.t * Id.t list * Id.t list
    | Dir of Id.l * Id.t list * Id.t list

type inst =
    | Nop
    (* | End of int option(* represents the end of true block of if (states * where it jumps)*) *)
    | Jump of int (* shows where to jump (relative address) *)
    | Set of Id.t * int
    | SetL of Id.t * Id.l
    | SetCLV of Id.t * Id.l
    | Mov of Id.t * Id.t
    | Neg of Id.t * Id.t
    | Add of Id.t * Id.t * Asm.id_or_imm
    | Sub of Id.t * Id.t * Id.t
    | Mul of Id.t * Id.t * Asm.id_or_imm
    | Div of Id.t * Id.t * Asm.id_or_imm
    | SLL of Id.t * Id.t * Asm.id_or_imm
    | SRL of Id.t * Id.t * Asm.id_or_imm
    | LW of Id.t * Id.t * Asm.id_or_imm
    | SW of Id.t * Id.t * Asm.id_or_imm
    | FMov of Id.t * Id.t
    | FNeg of Id.t * Id.t
    | FAdd of Id.t * Id.t * Id.t
    | FSub of Id.t * Id.t * Id.t
    | FMul of Id.t * Id.t * Id.t
    | FDiv of Id.t * Id.t * Id.t
    | LWC of Id.t * Id.t * Asm.id_or_imm
    | SWC of Id.t * Id.t * Asm.id_or_imm
    (* virtual instructions *)
    | IfEq of Id.t * Id.t * int (* shows where the else block starts *)
    | IfLE of Id.t * Id.t * int
    | IfGE of Id.t * Id.t * int
    | IfFEq of Id.t * Id.t * int
    | IfFLE of Id.t * Id.t * int
    | Comment of string
    | CallCls of Id.t * Id.t list * Id.t list * Id.t (* dest *)
    | CallDir of Id.l * Id.t list * Id.t list * Id.t (* dest *)
    | Save of Id.t * Id.t
    | Restore of Id.t * Id.t
    | Return of ret 

type t = inst list

type fundef = {name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t }

type prog = Prog of (Id.l * float) list * fundef list * t

type dest = Tail | NonTail of Id.t

let rec g prev = function (* Make Instruction List(Reversed) *)
    | (dest, Asm.Ans(exp)) -> g' prev (dest, exp)
    | (dest, Asm.Let((x, t), exp, e)) -> g [] (dest, e) @ g' [] (NonTail(x), exp) @ prev
and g' prev = function
    | NonTail(_), Asm.Nop -> Nop :: prev
    | NonTail(x), Asm.Set(i) -> Set(x, i) :: prev
    | NonTail(x), Asm.SetL(l) -> SetL(x, l) :: prev
    | NonTail(x), Asm.SetCLV(l) -> SetCLV(x, l) :: prev
    | NonTail(x), Asm.Mov(y) when x = y -> prev
    | NonTail(x), Asm.Mov(y) -> Mov(x, y) :: prev
    | NonTail(x), Asm.Neg(y) -> Neg(x, y) :: prev
    | NonTail(x), Asm.Add(y, z') -> Add(x, y, z') :: prev
    | NonTail(x), Asm.Sub(y, z) -> Sub(x, y, z) :: prev
    | NonTail(x), Asm.Mul(y, z') -> Mul(x, y, z') :: prev
    | NonTail(x), Asm.Div(y, z') -> Div(x, y, z') :: prev
    | NonTail(x), Asm.SLL(y, z') -> SLL(x, y, z') :: prev
    | NonTail(x), Asm.SRL(y, z') -> SRL(x, y, z') :: prev
    | NonTail(x), Asm.LW(y, z') -> LW(x, y, z') :: prev
    | NonTail(_), Asm.SW(x, y, z') -> SW(x, y, z') :: prev
    | NonTail(x), Asm.FMov(y) when x = y -> prev
    | NonTail(x), Asm.FMov(y) -> FMov(x, y) :: prev
    | NonTail(x), Asm.FNeg(y) -> FNeg(x, y) :: prev
    | NonTail(x), Asm.FAdd(y, z) -> FAdd(x, y, z) :: prev
    | NonTail(x), Asm.FSub(y, z) -> FSub(x, y, z) :: prev
    | NonTail(x), Asm.FMul(y, z) -> FMul(x, y, z) :: prev
    | NonTail(x), Asm.FDiv(y, z) -> FDiv(x, y, z) :: prev
    | NonTail(x), Asm.LWC(y, z') -> LWC(x, y, z') :: prev
    | NonTail(_), Asm.SWC(x, y, z') -> SWC(x, y, z') :: prev
    | NonTail(x), Asm.Comment(s) -> Comment(s) :: prev
    | NonTail(_), Asm.Save(x, y) -> Save(x, y) :: prev (* won't be neccesarry *)
    | NonTail(x), Asm.Restore(y) -> Restore(x, y) :: prev (* won't be neccesarry *)
    | Tail, (Asm.Nop | Asm.SW _ | Asm.SWC _ | Asm.Comment _ | Asm.Save _ as exp) ->
        Return(Value(None)) :: g' prev (NonTail(Id.gentmp Type.Unit), exp)
    | Tail, (Asm.Set _ | Asm.SetL _ |  Asm.Mov _ | Asm.Neg _ | Asm.Add _ | Asm.Sub _ |Asm.Mul _ | Asm.Div _ | Asm.SLL _ | Asm.SRL _ | Asm.LW _ 
        as exp) -> let tmp = Id.gentmp Type.Int in
            Return(Value(Some(tmp, Type.Int))) :: g' prev (NonTail(tmp), exp)
    | Tail, (Asm.FMov _ | Asm.FNeg _ | Asm.SetCLV _  | Asm.FAdd _ | Asm.FSub _ |
    Asm.FMul _ | Asm.FDiv _  | Asm.LWC _ as exp) -> let tmp = Id.gentmp Type.Float in
            Return(Value(Some(tmp, Type.Float))) :: g' prev (NonTail(tmp), exp)
    | Tail, Asm.Restore(_) -> (* won't be neccesarry *)
            prev
    | Tail, Asm.IfEq(x, y, e1, e2) -> (* TODO end in else list end? *)
            let cont, else_start = g'_tail_if e1 e2 in
            cont @ [IfEq(x, y, else_start)] @ prev
    | Tail, Asm.IfLE(x, y, e1, e2) ->
            let cont, else_start = g'_tail_if e1 e2 in
            cont @ [IfLE(x, y, else_start)] @ prev
    | Tail, Asm.IfGE(x, y, e1, e2) ->
            let cont, else_start = g'_tail_if e1 e2 in
            cont @ [IfGE(x, y, else_start)] @ prev
    | Tail, Asm.IfFEq(x, y, e1, e2) ->
            let cont, else_start = g'_tail_if e1 e2 in
            cont @ [IfFEq(x, y, else_start)] @ prev
    | Tail, Asm.IfFLE(x, y, e1, e2) ->
            let cont, else_start = g'_tail_if e1 e2 in
            cont @ [IfFLE(x, y, else_start)] @ prev
    | NonTail(z), Asm.IfEq(x, y, e1, e2) ->
            let cont, else_start = g'_non_tail_if z e1 e2 in
            cont @ [IfEq(x, y, else_start)] @ prev
    | NonTail(z), Asm.IfLE(x, y, e1, e2) ->
            let cont, else_start = g'_non_tail_if z e1 e2 in
            cont @ [IfLE(x, y, else_start)] @ prev
    | NonTail(z), Asm.IfGE(x, y, e1, e2) ->
            let cont, else_start = g'_non_tail_if z e1 e2 in
            cont @ [IfGE(x, y, else_start)] @ prev
    | NonTail(z), Asm.IfFEq(x, y, e1, e2) ->
            let cont, else_start = g'_non_tail_if z e1 e2 in
            cont @ [IfFEq(x, y, else_start)] @ prev
    | NonTail(z), Asm.IfFLE(x, y, e1, e2) ->
            let cont, else_start = g'_non_tail_if z e1 e2 in
            cont @ [IfFLE(x, y, else_start)] @ prev
    | Tail, Asm.CallCls(x, ys, zs) -> Return(Cls(x, ys, zs)) :: prev
    | Tail, Asm.CallDir(l, ys, zs) -> Return(Dir(l, ys, zs)) :: prev
    | NonTail(a), Asm.CallCls(x, ys, zs) -> CallCls(x, ys, zs, a) :: prev
    | NonTail(a), Asm.CallDir(l, ys, zs) -> CallDir(l, ys, zs, a) :: prev
and g'_tail_if e1 e2 =
    let true_list = g [] (Tail, e1) in
    let false_list = g [] (Tail, e2) in
    let cont = false_list @ true_list in
    let else_start = List.length true_list + 1 in
    (cont, else_start)
and g'_non_tail_if z e1 e2 =
    let true_list = g [] (NonTail(z), e1) in
    let false_list = g [] (NonTail(z), e2) in
    let cont = false_list @ (Jump(List.length false_list + 1) :: true_list) in
    let else_start = List.length true_list + 2 in
    (cont, else_start)

let h { Asm.name = l; Asm.args = xs; Asm.fargs = ys; Asm.body = e; Asm.ret = t}=
    { name = l; args = xs; fargs = ys; body = List.rev (g [] (Tail, e)); ret = t}

let f (Asm.Prog(data, fundefs, e)) =
    Prog(data, List.map h fundefs, List.rev (g [] (Tail, e)))

let rec string_of_id_list = function
    | [] -> "" 
    | x::[] -> x
    | x::xs -> x ^ ", " ^ string_of_id_list xs

let gen_index_lst n =
    let rec gen_index_lst_rec m result =
        if m >= n then result
        else gen_index_lst_rec (m + 1) (m :: result)
    in List.rev (gen_index_lst_rec 0 [])

let print_inst = function
    | Nop -> print_string "Nop\n"
    | Jump(n) -> print_string ("Jump " ^ string_of_int n ^ " \n")
    | Set(x, v) -> print_string ("Set " ^ x ^ ", " ^ string_of_int v ^ "\n")
    | SetL(x, Id.L(l)) -> print_string ("SetL " ^ x ^ ", " ^ "L(" ^ l ^ ")\n")
    | SetCLV(x, Id.L(l)) -> print_string ("SetCLV " ^ x ^ ", " ^ l ^ "\n")
    | Mov(x, y) -> print_string ("Mov " ^ x ^ ", " ^ y ^ "\n")
    | Neg(x, y) -> print_string ("Neg " ^ x ^ ", " ^ y ^ "\n")
    | Add(x, y, Asm.V(z)) -> print_string ("Add " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | Add(x, y, Asm.C(z)) -> print_string ("Add " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | Sub(x, y, z) -> print_string ("Sub " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | Mul(x, y, Asm.V(z)) -> print_string ("Mul " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | Mul(x, y, Asm.C(z)) -> print_string ("Mul " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | Div(x, y, Asm.V(z)) -> print_string ("Div " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | Div(x, y, Asm.C(z)) -> print_string ("Div " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | SLL(x, y, Asm.V(z)) -> print_string ("SLL " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")  
    | SLL(x, y, Asm.C(z)) -> print_string ("SLL " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | SRL(x, y, Asm.V(z)) -> print_string ("SRL " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | SRL(x, y, Asm.C(z)) -> print_string ("SRL " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | LW(x, y, Asm.V(z)) -> print_string ("LW " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | LW(x, y, Asm.C(z)) -> print_string ("LW " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | SW(x, y, Asm.V(z)) -> print_string ("SW " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | SW(x, y, Asm.C(z)) -> print_string ("SW " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | FMov(x, y) -> print_string ("FMov " ^ x ^ ", " ^ y ^ "\n")
    | FNeg(x, y) -> print_string ("FNeg " ^ x ^ ", " ^ y ^ "\n")
    | FAdd(x, y, z) -> print_string ("FAdd " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | FSub(x, y, z) -> print_string ("FSub " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | FMul(x, y, z) -> print_string ("FMul " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | FDiv(x, y, z) -> print_string ("FDiv " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | LWC(x, y, Asm.V(z)) -> print_string ("LWC " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | LWC(x, y, Asm.C(z)) -> print_string ("LWC " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | SWC(x, y, Asm.V(z)) -> print_string ("SWC " ^ x ^ ", " ^ y ^ ", " ^ z ^ "\n")
    | SWC(x, y, Asm.C(z)) -> print_string ("SWC " ^ x ^ ", " ^ y ^ ", " ^ string_of_int z ^ "\n")
    | IfEq(x, y, else_start) -> print_string ("IfEq " ^ x ^ ", " ^ y ^ " else_start: " ^ string_of_int else_start ^ "\n") 
    | IfLE(x, y, else_start) -> print_string ("IfLE " ^ x ^ ", " ^ y ^ " else_start: " ^ string_of_int else_start ^ "\n")
    | IfGE(x, y, else_start) -> print_string ("IfGE " ^ x ^ ", " ^ y ^ " else_start: " ^ string_of_int else_start ^ "\n")
    | IfFEq(x, y, else_start) -> print_string ("IfFEq " ^ x ^ ", " ^ y ^ " else_start: " ^ string_of_int else_start ^ "\n")
    | IfFLE(x, y, else_start) -> print_string ("IfFLE " ^ x ^ ", " ^ y ^ " else_start: " ^ string_of_int else_start ^ "\n")
    | Comment(comment) -> print_string ("Comment " ^ comment ^ "\n")
    | CallCls(x, ys, zs, dest) -> print_string ("CallCls " ^ x ^ ", (" ^ string_of_id_list ys ^ "), (" ^ string_of_id_list zs ^ "), dest: " ^ dest ^ "\n")  
    | CallDir(Id.L(x), ys, zs, dest) -> print_string ("CallDir " ^ x ^ ", (" ^ string_of_id_list ys ^ "), ("  ^ string_of_id_list zs ^ "), dest: " ^ dest ^ "\n")
    | Save(x, y) -> print_string ("Save " ^ x ^ ", " ^ y ^ "\n")
    | Restore(x, y) -> print_string ("Restore " ^ x ^ ", " ^ y ^ "\n")
    | Return(Value(None)) -> print_string "Return None\n"
    | Return(Value(Some(x, typ))) -> print_string ("Return " ^ x ^ " :" ^ Type.t_to_string typ ^ "\n")
    | Return(Cls(x, ys, zs)) -> print_string ("Return Cls(" ^ x ^ ", (" ^ string_of_id_list ys ^ "), (" ^ string_of_id_list zs ^ "))")
    | Return(Dir(Id.L(x), ys, zs)) -> print_string ("Return Dir(" ^ x ^ ", (" ^ string_of_id_list ys ^ "), (" ^ string_of_id_list zs ^ "))")

let print_fundef { name = Id.L(l); args = xs; fargs = ys; body = insts; ret
= t} = 
    print_string (l ^ ": args: " ^ string_of_id_list xs ^ " fargs: " ^ string_of_id_list ys ^ "ret: " ^ Type.t_to_string t ^ "\n");
    List.iter2 (fun index inst -> print_int index; print_string ": "; print_inst inst) (gen_index_lst (List.length insts)) insts 

let print_prog (Prog(datas, fundefs, insts)) = 
    List.iter (fun (Id.L(l), data) -> print_string (l ^ ": "); print_float data;print_string "\n") datas;
    print_string "\n";
    List.iter print_fundef fundefs;
    print_string "\n";
    List.iter2 (fun index inst -> print_int index; print_string ": "; print_inst inst) (gen_index_lst (List.length insts)) insts 

