(* customized version of Map *)

module M_i =
    Map.Make
    (struct
        type t = int
        let compare = compare
    end)
include M_i

let union f m1 m2 = fold f m1 m2
let add_f f key a m = if M_i.mem key m then M_i.add key (f a (M_i.find key m)) m
                        else M_i.add key a m
