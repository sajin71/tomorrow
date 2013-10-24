type id_or_imm = V of Id.t | C of int
type t = 
    | Ans of exp
    | Let of (Id.t * Type.t) * exp *t
and exp = 
    | Nop
    | Add of Id.t * id_or_imm
    | Sub of Id.t * Id.t 
    | Mul of Id.t * id_or_imm
    | Div of Id.t * Id.t 
    | SLL of Id.t * Id.t
    | SRL of Id.t * Id.t
    | LW of Id.t * int 
    | SW of Id.t * Id.t * int 
    | FAdd of Id.t * Id.t
    | FMul of Id.t * Id.t
    | FDiv of Id.t * Id.t
    | Comment of string
    (* virtual instructions *)
    | IfEq of Id.t * id_or_imm * t * t
    | IfLE of Id.t * id_or_imm * t * t
    | IfGE of Id.t * id_or_imm * t * t
    | IfFEq of Id.t * Id.t * t * t
    | IfFLE of Id.t * Id.t * t * t
    (* closure address, integer arguments and float arguments *)
    | CallCls of Id.t * Id.t list * Id.t list
    | CallDir of Id.t * Id.t list * Id.t list
    | Save of Id.t * Id.t (* store register variables to stack variables *)
    | Restore of Id.t (* restore values from stack variables *)
type fundef = {name : Id.l; args : Id.t list; fargs : Id.t list; body : t; ret : Type.t}

type prog = Prog of (Id.l * float) list * fundef list * t

val fletd : Id.t * exp * t -> t (* shorthand of Let for float *)
val seq : exp * t -> t (* shorthand of Let for unit *)

val regs : Id.t array
val fregs : Id.t array
val allregs : Id.t list
val allfregs : Id.t list
val reg_cl : Id.t
val reg_sw : Id.t
val reg_fsw : Id.t
val reg_ra : Id.t
val reg_hp : Id.t
val reg_sp : Id.t
val is_reg : Id.t -> bool
val co_freg : Id.t -> Id.t

val fv : t -> Id.t list
val concat : t -> Id.t * Type.t -> t -> t

val align : int -> int
