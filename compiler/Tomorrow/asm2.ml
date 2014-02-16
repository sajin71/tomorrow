type inst =
    | Nop
    | Set of Id.t * int
    | SetL of Id.t * Id.l
    | SetCLV of Id.t * Id.t
    | Mov of Id.t * Id.t
    | Neg of Id.t
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
    | LWC of Id.t * Id.t * id_or_imm
    | SWC of Id.t * Id.t * id_or_imm
    | Comment of string
    | CallCls of Id.t * Id.t list * Id.t list
    | CallDir of Id.l * Id.t list * Id.t list
    | Save of Id.t * Id.t
    | Restore of Id.t * Id.t
    | Return of (Id.t * Type.t) option

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
    | NonTail(x), Asm.SW(x, y, z') -> SW(x, y, z') :: prev
    | NonTail(x), Asm.FMov(y) when x = y -> prev
    | NonTail(x), Asm.FMov(y) -> FMov(x, y) :: prev
    | NonTail(x), Asm.FNeg(y) -> FNeg(x, y) :: prev
    | NonTail(x), Asm.FAdd(y, z) -> FAdd(x, y, z) :: prev
    | NonTail(x), Asm.FSub(y, z) -> FSub(x, y, z) :: prev
    | NonTail(x), Asm.FMul(y, z) -> FMul(x, y, z) :: prev
    | NonTail(x), Asm.FDiv(y, z) -> FDiv(x, y, z) :: prev
    | NonTail(x), Asm.Comment(s) -> Comment(s) :: prev
    | NonTail(_), Asm.Save(x, y) -> Save(x, y) :: prev (* won't be neccesarry *)
    | NonTail(x), Asm.Restore(y) -> Restore(x, y) :: prev (* won't be neccesarry *)
    | Tail, (Asm.Nop | Asm.SW _ | Asm.SWC _ | Asm.Comment _ | Asm.Save _ as inst) ->
        Return(None) :: g' prev (NonTail(Id.gentmp Type.Unit), inst)
    | Tail, (Asm.Set _ | Asm.SetL _ |  Asm.Mov _ | Asm.Neg _ | Asm.Add _ | Asm.Sub _ |Asm.Mul _ | Asm.Div _ | Asm.SLL _ | Asm.SRL _ | Asm.LW _ 
        as inst) -> let tmp = Id.gentmp Type.Int in
            Return(tmp, Type.Int) :: g' prev (NonTail(tmp), inst)
    | Tail, (Asm.FMov _ | Asm.FNeg _ | Asm.SetCLV _  | Asm.FAdd _ | Asm.FSub _ | Asm.FMul _ | Asm.FDiv _  | Asm.LWC _ as inst) -> let tmp = Id.gentmp Type.Float in
            Return(tmp, Type.Float) :: g' prev (NonTail(tmp), inst)
    | Tail, (Asm.Restore(x) as exp) -> (* won't be neccesarry *)
            prev



