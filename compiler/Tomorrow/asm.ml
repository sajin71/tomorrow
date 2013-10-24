(* Tomorrow assembly with a few virtual instructions *)

(* TODO not sure if neccesarry *)
type id_or_imm = V of Id.t | C of int

type t = (* Array of instructions *)
    | Ans of exp
    | Let of (Id.t * Type.t) * exp *t
and exp = (* represents each instructions *)
    | Nop
    | Set of int (* pseudo-instruction *)
    | Mov of Id.t (* pseudo-instruction *)
    | Neg of Id.t
    | Add of Id.t * id_or_imm
    | Sub of Id.t * Id.t
    | Mul of Id.t * id_or_imm
    | Div of Id.t * Id.t
    | SLL of Id.t * Id.t
    | SRL of Id.t * Id.t
    | LW of Id.t * int 
    | SW of Id.t * Id.t * int 
    | FMovD of Id.t
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

(* Data structure representing the whole program *)
type prog = Prog of (Id.l * float) list * fundef list * t

let fletd(x, e1, e2) = Let((x, Type.Float), e1, e2)
let seq(e1, e2) = Let((Id.gentmp Type.Unit, Type.Unit), e1, e2)

let regs = [| "$r2"; "$r5"; "$r6"; "$r7"; "$r8"; "$r9"; "$r10"; 
  "$r11"; "$r12"; "$r13"; "$r14"; "$r15"; "$r16"; "$r17"; "$r18"; 
  "$r19"; "$r20"; "$r21"; "$r22"; "$r23"; "$r24"; "$r25"; "$r26"; 
  "$r27"; "$r28"; "$r29"; "$r30" |]
let fregs = Array.init 32 (fun i -> Printf.sprintf "$f%d" i)
let allregs = Array.to_list regs
let allfregs = Array.to_list fregs
let reg_cl = regs.(Array.length regs - 1) (* closure address *)
let reg_sw = regs.(Array.length regs - 2) (* temporary for swap *)
let reg_fsw = fregs.(Array.length fregs - 1) (* temporary for swap *)

(* TODO not sure if hp, sp, tmp is right *)
let reg_hp = "r28"
let reg_sp = "r29"
let reg_tmp = "r31"

let is_reg x = x.[0] = '%'

(* super-tenuki *)
let rec remove_and_uniq xs = function
    | [] -> []
    | x :: ys when S.mem x xs -> remove_and_uniq xs ys
    | x :: ys -> x :: remove_and_uniq (S.add x xs) ys

(* free variables in the order of use (for spilling) *)
let fv_id_or_imm = function V(x) -> [x] | _ -> []
let rec fv_exp = function
    | Nop | Set(_) | Comment(_) | Restore(_) -> []
    | Mov(x) | Neg(x) | FMov(x) | FNeg(x) | Save(x, _) | LW(x, _) -> [x]
    | Add(x, y') | Mul(x, y') -> 
            x :: fv_id_or_imm y' 
    | SW(x, y, _) -> [x; y]
    | Sub(x, y) | Div(x, y) | SLL(x, y) | SLR(x, y) | FAdd(x, y) | Fsub(x, y) | FMul(x, y) | FDiv(x, y) -> [x; y] 
    | IfEq(x, y', e1, e2) | IfLE(x, y', e1, e2) | IfGE(x, y', e1, e2) -> 
            x :: fv_id_or_imm y' @ remove_and_uniq S.empty (fv e1 @ fv e2) 
    | IfFEq(x, y, e1, e2) | IfFLE(x, y, e1, e2) -> 
            x :: y :: remove_and_uniq S.empty (fv e1 @ fv e2)
    | CallCls(x, ys, zs) -> x :: ys @ zs
    | CallDir(_, ys, zs) -> ys @ zs
and fv = function
    | Ans(exp) -> fv_exp exp
    | Let((x, t), exp, e) ->
      fv_exp exp @ remove_and_uniq (S.singleton x) (fv e)

let fv e = remove_and_uniq S.empty (fv e)

let rec concat e1 xt e2 =
    match e1 with
    | Ans(exp) -> Let(xt, exp, e2)
    | Let(yt, exp, e1') -> Let(yt, exp, concat e1' xt e2)

let align i = (if i mod 8 = 0 then i else i + 4)
