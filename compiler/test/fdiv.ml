let rec testdiv x y = x /. y in
let f1 = 15.0 in
let f2 = 4.0  in
let ans = 100.0 *. (testdiv f1 f2) in
print_int (truncate ans)



