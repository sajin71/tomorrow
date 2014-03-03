type ret = 
    | Value of (Id.t * Type.t) option
    | Cls of Id.t * Id.t list * Id.t list
    | Dir of Id.l * Id.t list * Id.t list

type inst =
    | Nop
    (* | End of int option (* represents the end of true block of if *) *)
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

val add_as_set : 'a -> 'a list -> 'a list
val add_list_as_set : 'a list -> 'a list -> 'a list
val remove_all : 'a -> 'a list -> 'a list
val sub_list_as_set : 'a list -> 'a list -> 'a list

val f : Asm.prog -> prog

val gen_index_lst : int -> int list 
val print_prog : prog -> unit
