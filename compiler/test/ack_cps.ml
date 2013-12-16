let rec ack_cps x y cont =
    if x <= 0 then let rec f a = a + 1 in cont (f y)
    else if y <= 0 then ack_cps (x - 1) 1 cont
    else let rec f a = ack_cps (x - 1) a cont in ack_cps x (y - 1) f
in let rec f x = x in print_int (ack_cps 3 10 f) 
