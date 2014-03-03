type node' = int
type in_edges = Pred of int list
type out_edges = Succ of int list

type node = Node of node' * in_edges * out_edges

type t = node list 

type function_flow = Id.t * t

val f : Asm2.prog -> function_flow list * t
val print_flow_result : (function_flow list * t) -> unit 
