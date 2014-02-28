let limit = ref 1000

let rec iter n e = (* 最適化処理をくりかえす (caml2html: main_iter) *)
  Format.eprintf "iteration %d@." n;
  if n = 0 then e else
  let e' = (Elim.f (Subexpr.f (ConstFold.f (Inline.f n (Assoc.f (Beta.f e)))))) in
  if e = e' then e else
  iter (n - 1) e'

let lexbuf outchan l = (* バッファをコンパイルしてチャンネルへ出力する (caml2html: main_lexbuf) *)
  Id.counter := 0;
  Typing.extenv := M.empty;
  (* let asm_t = (Simm.f
	  (Virtual.f
	     (Closure.f
		(iter !limit
        (Subexpr.f
		   (Alpha.f
		      (KNormal.f
			 (Typing.f
			    (Parser.exp Lexer.token l))))))))) in
  let asm2_t = Asm2.f asm_t in
  Asm2.print_prog asm2_t; print_string "\n"; 
  let flow_result = Flow.f asm2_t in
  (Flow.print_flow_result (flow_result)); 
  (Live.print_liveness_result (Live.f asm2_t flow_result)); *)

  Emit.f outchan
    (RegAlloc.f
    (Simm.f
	  (Virtual.f
	     (Closure.f
		(iter !limit
        (Subexpr.f
		   (Alpha.f
		      (KNormal.f
			 (Typing.f
			    (Parser.exp Lexer.token l))))))))))

let string s = lexbuf stdout (Lexing.from_string s) (* 文字列をコンパイルして標準出力に表示する (caml2html: main_string) *)

let file f = (* ファイルをコンパイルしてファイルに出力する (caml2html: main_file) *)
  let inchan = open_in (f ^ ".ml") in
  let outchan = open_out (f ^ ".s") in
  try
    lexbuf outchan (Lexing.from_channel inchan);
    close_in inchan;
    close_out outchan;
  with e -> (close_in inchan; close_out outchan; raise e)

let () = (* ここからコンパイラの実行が開始される (caml2html: main_entry) *)
  let files = ref [] in
  Arg.parse
    [("-inline", Arg.Int(fun i -> Inline.threshold := i), "maximum size of functions inlined");
     ("-iter", Arg.Int(fun i -> limit := i), "maximum number of optimizations iterated")]
    (fun s -> files := !files @ [s])
    ("Mitou Min-Caml Compiler (C) Eijiro Sumii\n" ^
     Printf.sprintf "usage: %s [-inline m] [-iter n] ...filenames without \".ml\"..." Sys.argv.(0));
  List.iter
    (fun f -> ignore (file f))
    !files
