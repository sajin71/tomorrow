(* float instructions *)
let rec fequal a b = a = b in
let rec fless a b = (a < b) in

let rec fispos a = (a > 0.0) in
let rec fisneg a = (a < 0.0) in
let rec fiszero a = (a = 0.0) in

(*let rec fabs a =
    if a < 0.0 then -. a
    else a
in*)
let rec abs_float x = fabs x in
let rec fneg a = -. a in
let rec fhalf a = a *. 0.5 in
let rec fsqr a = a *. a in

(* bool instructions *)
let rec xor a b = a <> b in

