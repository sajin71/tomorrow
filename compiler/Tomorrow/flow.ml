open Asm2

type node' = int
type in_edges = Pred of int list 
type out_edges = Succ of int list

type node = Node of node' * in_edges * out_edges

type t = node list

type function_flow = Id.t * t

(* type dest = Tail | NonTail of Id.t *)

let pred_lst n = if n - 1 >= 0 then [n - 1] else [] 

(*
let make_normal_node inst index = (inst, Pred(pred_lst index), Succ([index + 1]))
let make_return_node inst index = (inst, Pred(pred_lst index), Succ([]))
let make_if_node inst index else_start= (inst, Pred(pred_lst index), Succ([index + 1; index + else_start]))
let make_if_end_node else_len = (inst, Pred(pred_lst index), Succ([index + else_len]))
*)

let add_as_set x lst =
    if List.mem x lst then lst else x::lst
let rec remove_all a = function
    | [] -> []
    | x :: xs -> if x = a then remove_all a xs else x :: remove_all a xs

let rec make_irregular_edge_list inst_list pred_lst succ_lst del_lst n =
    if n >= List.length inst_list then pred_lst, succ_lst, del_lst
    else match List.nth inst_list n with
    | Jump(offset) | IfEq(_, _, offset) | IfLE(_, _, offset) | IfGE(_, _, offset)
    | IfFEq(_, _, offset) | IfFLE(_, _, offset) -> 
        make_irregular_edge_list inst_list ((n + offset, n) :: pred_lst) ((n, n + offset) :: succ_lst) (del_lst) (n + 1)
    | Jump(offset) ->
        make_irregular_edge_list inst_list ((n + offset, n) :: pred_lst) ((n, n + offset) :: succ_lst) ((n + 1, n) :: del_lst) (n + 1)
    | Return(x) -> 
            make_irregular_edge_list inst_list pred_lst succ_lst ((n + 1, n) :: del_lst) (n + 1)
    | e -> make_irregular_edge_list inst_list pred_lst succ_lst del_lst (n + 1)

let inst_to_node index = function
    | Jump(offset) -> Node(index, Pred(pred_lst index), Succ([index + offset]))
    | Return(x) -> Node(index, Pred(pred_lst index), Succ([]))
    | e -> Node(index, Pred(pred_lst index), Succ([index + 1]))

let make_default_flow_graph inst_list =
    List.map2 inst_to_node (Asm2.gen_index_lst (List.length inst_list)) inst_list 

let format_flow_node (Node(index, Pred(in_lst), Succ(out_lst))) pred_lst succ_lst del_lst =
    let new_in_nodes = List.map (fun(x, y) -> y) (List.filter (fun (x, y) -> x = index) pred_lst) in
    let new_in_nodes' = List.fold_right (remove_all) (List.map (fun(x, y) -> y) (List.filter (fun (x, y) -> x = index) del_lst)) new_in_nodes in
    let in_lst'' = List.fold_right (add_as_set) in_lst new_in_nodes' in
    let in_lst' = List.fold_right (remove_all) (List.map (fun(x, y) -> y) (List.filter (fun (x, y) -> x = index) del_lst)) in_lst'' in
    let new_out_nodes = List.map (fun(x, y) -> y) (List.filter (fun (x, y) -> x = index) succ_lst) in
    let out_lst'  = List.fold_right (add_as_set) out_lst new_out_nodes in
    Node(index, Pred(in_lst'), Succ(out_lst'))

let rec g inst_list =
    let pred_lst, succ_lst, del_lst = make_irregular_edge_list inst_list [] [] [] 0 in
    let default_flow_graph = make_default_flow_graph inst_list in
    List.map (fun node -> format_flow_node node pred_lst succ_lst del_lst) default_flow_graph
let h { Asm2.name = Id.L(l); Asm2.args = xs; Asm2.fargs = ys; Asm2.body = e; Asm2.ret = t}=
    l, g e

let f (Asm2.Prog(data, fundefs, e)) =
    List.map h fundefs, g e
   
let rec print_int_lst = function
    | [] -> ()
    | x::[] -> print_int x
    | x::xs -> print_int x; print_string ", "; print_int_lst xs

let print_flow_node (Node(index, Pred(in_lst), Succ(out_lst))) =
    print_int index; print_string ": Pred("; print_int_lst in_lst; 
    print_string ") Succ("; print_int_lst out_lst; print_string ")\n"

let print_flow_graph graph = List.iter (print_flow_node) graph

let print_flow_result (fun_flow_lst, graph) =
    List.iter (fun (id, graph) -> print_string (id ^ "\n"); print_flow_graph graph) fun_flow_lst;
    print_string "\n"; print_flow_graph graph

(*
let rec g prev index back_env = function (* Make Predstruction List(Reversed) *)
    (* return flow graph and bindings of back word edges *)
    | (dest, Asm.Ans(exp)) -> g' prev index back_env (dest, exp)
    | (dest, Asm.Let((x, t), exp, e)) -> 
            let pred, back_env' = g' [] index (NonTail(x), exp) in 
            g [] (index + List.length pred) (M_i.union (fun key a m -> M_i.add_f (List.append) key a m) back_env back_env') (dest, e) @ pred @ prev
and g' prev index back_env = function
    | NonTail(_), Asm.Nop -> make_normal_node Nop index :: prev, back_env
    | NonTail(x), Asm.Set(i) -> make_normal_node Set(x, i) index :: prev, back_env
    | NonTail(x), Asm.SetL(l) -> make_normal_node SetL(x, l) index :: prev, back_env
    | NonTail(x), Asm.SetCLV(l) -> make_normal_node SetCLV(x, l) index :: prev, back_env
    | NonTail(x), Asm.Mov(y) when x = y -> prev, back_env
    | NonTail(x), Asm.Mov(y) -> make_normal_node Mov(x, y) index :: prev, back_env
    | NonTail(x), Asm.Neg(y) -> make_normal_node Neg(x, y) index :: prev, back_env
    | NonTail(x), Asm.Add(y, z') -> make_normal_node Add(x, y, z') index :: prev, back_env
    | NonTail(x), Asm.Sub(y, z) -> make_normal_node Sub(x, y, z) index :: prev, back_env
    | NonTail(x), Asm.Mul(y, z') -> make_normal_node Mul(x, y, z') index :: prev, back_env
    | NonTail(x), Asm.Div(y, z') -> make_normal_node Div(x, y, z') index :: prev, back_env
    | NonTail(x), Asm.SLL(y, z') -> make_normal_node SLL(x, y, z') index :: prev, back_env
    | NonTail(x), Asm.SRL(y, z') -> make_normal_node SRL(x, y, z') index :: prev, back_env
    | NonTail(x), Asm.LW(y, z') -> make_normal_node LW(x, y, z') index :: prev, back_env
    | NonTail(_), Asm.SW(x, y, z') -> make_normal_node SW(x, y, z') index :: prev, back_env
    | NonTail(x), Asm.FMov(y) when x = y -> prev, back_env
    | NonTail(x), Asm.FMov(y) -> make_normal_node FMov(x, y) index :: prev, back_env
    | NonTail(x), Asm.FNeg(y) -> make_normal_node FNeg(x, y) index :: prev, back_env
    | NonTail(x), Asm.FAdd(y, z) -> make_normal_node FAdd(x, y, z) index :: prev, back_env
    | NonTail(x), Asm.FSub(y, z) -> make_normal_node FSub(x, y, z) index :: prev, back_env
    | NonTail(x), Asm.FMul(y, z) -> make_normal_node FMul(x, y, z) index :: prev, back_env
    | NonTail(x), Asm.FDiv(y, z) -> make_normal_node FDiv(x, y, z) index :: prev, back_env
    | NonTail(x), Asm.LWC(y, z') -> make_normal_node LWC(x, y, z') index :: prev, back_env
    | NonTail(_), Asm.SWC(x, y, z') -> make_normal_node SWC(x, y, z') index:: prev, back_env
    | NonTail(x), Asm.Comment(s) -> make_normal_node Comment(s) index:: prev, back_env
    | NonTail(_), Asm.Save(x, y) -> make_normal_node Save(x, y) index:: prev, back_env (* won't be neccesarry *)
    | NonTail(x), Asm.Restore(y) -> make_normal_node Restore(x, y) index:: prev, back_env(* won't be neccesarry *)
    | Tail, (Asm.Nop | Asm.SW _ | Asm.SWC _ | Asm.Comment _ | Asm.Save _ as exp) ->
            make_return_node Return(Value(None)) index :: g' prev (NonTail(Id.gentmp Type.Unit), exp), back_env
    | Tail, (Asm.Set _ | Asm.SetL _ |  Asm.Mov _ | Asm.Neg _ | Asm.Add _ | Asm.Sub _ |Asm.Mul _ | Asm.Div _ | Asm.SLL _ | Asm.SRL _ | Asm.LW _ 
        as exp) -> let tmp = Id.gentmp Type.Predt in
            make_return_node Return(Value(Some(tmp, Type.Predt))) index :: g' prev (NonTail(tmp), exp), back_env
    | Tail, (Asm.FMov _ | Asm.FNeg _ | Asm.SetCLV _  | Asm.FAdd _ | Asm.FSub _ |
    Asm.FMul _ | Asm.FDiv _  | Asm.LWC _ as exp) -> let tmp = Id.gentmp Type.Float in
            make_normal_node Return(Value(Some(tmp, Type.Float))) index :: g' prev (NonTail(tmp), exp), back_env
    | Tail, Asm.Restore(_) -> (* won't be neccesarry *)
            prev, back_env
    | Tail, Asm.IfEq(x, y, e1, e2) -> (* TODO end in else list end? *)
            let cont, else_start, new_back_env = g'_tail_if e1 e2 in
            cont @ [make_if_node IfEq(x, y, else_start) index else_start] @
            prev, new_back_env 
    | Tail, Asm.IfLE(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_tail_if e1 e2 in
            cont @ [make_if_node IfLE(x, y, else_start) index else_start] @ prev, new_back_env
    | Tail, Asm.IfGE(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_tail_if e1 e2 in
            cont @ [make_if_node IfGE(x, y, else_start) index else_start] @ prev, new_back_env
    | Tail, Asm.IfFEq(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_tail_if e1 e2 in
            cont @ [make_if_node IfFEq(x, y, else_start) index else_start] @
            prev, new_back_env
    | Tail, Asm.IfFLE(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_tail_if e1 e2 in
            cont @ [make_if_node IfFLE(x, y, else_start) index else_start] @
            prev, new_back_env
    | NonTail(z), Asm.IfEq(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_non_tail_if z e1 e2 in
            cont @ [make_if_node IfEq(x, y, else_start) index else_start] @ prev
    | NonTail(z), Asm.IfLE(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_non_tail_if z e1 e2 in
            cont @ [make_if_node IfLE(x, y, else_start) index else_start] @ prev
    | NonTail(z), Asm.IfGE(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_non_tail_if z e1 e2 in
            cont @ [make_if_node IfGE(x, y, else_start) index else_start] @ prev
    | NonTail(z), Asm.IfFEq(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_non_tail_if z e1 e2 in
            cont @ [make_if_node IfFEq(x, y, else_start) index else_start] @ prev
    | NonTail(z), Asm.IfFLE(x, y, e1, e2) ->
            let cont, else_start, new_back_env = g'_non_tail_if z e1 e2 in
            cont @ [make_if_node IfFLE(x, y, else_start) index else_start] @ prev
    | Tail, Asm.CallCls(x, ys, zs) -> 
            make_return_node Return(Cls(x, ys, zs)) index :: prev, back_env
    | Tail, Asm.CallDir(l, ys, zs) -> 
            make_return_node Return(Dir(l, ys, zs)) index :: prev, back_env
    | NonTail(a), Asm.CallCls(x, ys, zs) -> 
            make_normal_node CallCls(x, ys, zs, a) index :: prev, back_env
    | NonTail(a), Asm.CallDir(l, ys, zs) -> 
            make_normal_node CallDir(l, ys, zs, a) index :: prev, back_env
and g'_tail_if e1 e2 index =
    let true_list, true_back_env = g [] index M_i.empty (Tail, e1) in
    let false_list, false_back_env = g [] M_i.empty (index + List.length true_back_env + 1) (Tail, e2) in
    let cont = false_list @ (End(None) :: true_list) in
    let new_back_env = 
        M_i.add_f (List.append) (index + List.length true_list + List.length false_list + 2) index
        M_i.union (fun key a m -> M_i.add_f (List.append) key a m) true_back_env false_back_env in
    let else_start = List.length true_list + 2 in
    (cont, else_start, new_back_env)
and g'_non_tail_if z e1 e2 =
    let true_list = g [] index M_i.empty (NonTail(z), e1) in
    let false_list = g [] (index + List.length true_back_env + 1) M_i.empty (NonTail(z), e2) in
    let else_len = List.length false_list in
    let cont = false_list @ (make_if_end_node End(Some(List.length false_list + 1)) index else_len :: true_list) in
     let new_back_env = 
        M_i.add_f (List.append) (index + List.length true_list + List.length false_list + 2) index
        M_i.union (fun key a m -> M_i.add_f (List.append) key a m) true_back_env false_back_env in
    let else_start = List.length true_list + 2 in
    (cont, else_start, new_back_env)
*)

