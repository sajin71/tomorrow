(*open MiniMLRuntime;;*)

(**************** ¥°¥í¡¼¥Ð¥ëÊÑ¿ô¤ÎÀë¸À ****************)

(* ¥ª¥Ö¥¸¥§¥¯¥È¤Î¸Ä¿ô *)
let n_objects = create_array 1 0
in
(* ¥ª¥Ö¥¸¥§¥¯¥È¤Î¥Ç¡¼¥¿¤òÆþ¤ì¤ë¥Ù¥¯¥È¥ë¡ÊºÇÂç60¸Ä¡Ë*)
let objects = 
  let dummy = create_array 0 0.0 in
  create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)
in
(* Screen ¤ÎÃæ¿´ºÂÉ¸ *)
let screen = create_array 3 0.0 in
(* »ëÅÀ¤ÎºÂÉ¸ *)
let viewpoint = create_array 3 0.0 in
(* ¸÷¸»Êý¸þ¥Ù¥¯¥È¥ë (Ã±°Ì¥Ù¥¯¥È¥ë) *)
let light = create_array 3 0.0 in
(* ¶ÀÌÌ¥Ï¥¤¥é¥¤¥È¶¯ÅÙ (É¸½à=255) *)
let beam = create_array 1 255.0 in
(* AND ¥Í¥Ã¥È¥ï¡¼¥¯¤òÊÝ»ý *)
let and_net = create_array 50 (create_array 1 (-1)) in
(* OR ¥Í¥Ã¥È¥ï¡¼¥¯¤òÊÝ»ý *)
let or_net = create_array 1 (create_array 1 (and_net.(0))) in

(* °Ê²¼¡¢¸òº¹È½Äê¥ë¡¼¥Á¥ó¤ÎÊÖ¤êÃÍ³ÊÇ¼ÍÑ *)
(* solver ¤Î¸òÅÀ ¤Î t ¤ÎÃÍ *)
let solver_dist = create_array 1 0.0 in
(* ¸òÅÀ¤ÎÄ¾ÊýÂÎÉ½ÌÌ¤Ç¤ÎÊý¸þ *)
let intsec_rectside = create_array 1 0 in
(* È¯¸«¤·¤¿¸òÅÀ¤ÎºÇ¾®¤Î t *)
let tmin = create_array 1 (1000000000.0) in
(* ¸òÅÀ¤ÎºÂÉ¸ *)
let intersection_point = create_array 3 0.0 in
(* ¾×ÆÍ¤·¤¿¥ª¥Ö¥¸¥§¥¯¥ÈÈÖ¹æ *)
let intersected_object_id = create_array 1 0 in
(* Ë¡Àþ¥Ù¥¯¥È¥ë *)
let nvector = create_array 3 0.0 in
(* ¸òÅÀ¤Î¿§ *)
let texture_color = create_array 3 0.0 in

(* ·×»»Ãæ¤Î´ÖÀÜ¼õ¸÷¶¯ÅÙ¤òÊÝ»ý *)
let diffuse_ray = create_array 3 0.0 in
(* ¥¹¥¯¥ê¡¼¥ó¾å¤ÎÅÀ¤ÎÌÀ¤ë¤µ *)
let rgb = create_array 3 0.0 in

(* ²èÁü¥µ¥¤¥º *)
let image_size = create_array 2 0 in
(* ²èÁü¤ÎÃæ¿´ = ²èÁü¥µ¥¤¥º¤ÎÈ¾Ê¬ *)
let image_center = create_array 2 0 in
(* 3¼¡¸µ¾å¤Î¥Ô¥¯¥»¥ë´Ö³Ö *)
let scan_pitch = create_array 1 0.0 in

(* judge_intersection¤ËÍ¿¤¨¤ë¸÷Àþ»ÏÅÀ *)
let startp = create_array 3 0.0 in
(* judge_intersection_fast¤ËÍ¿¤¨¤ë¸÷Àþ»ÏÅÀ *)
let startp_fast = create_array 3 0.0 in

(* ²èÌÌ¾å¤Îx,y,z¼´¤Î3¼¡¸µ¶õ´Ö¾å¤ÎÊý¸þ *)
let screenx_dir = create_array 3 0.0 in
let screeny_dir = create_array 3 0.0 in
let screenz_dir = create_array 3 0.0 in

(* Ä¾ÀÜ¸÷ÄÉÀ×¤Ç»È¤¦¸÷Êý¸þ¥Ù¥¯¥È¥ë *)
let ptrace_dirvec  = create_array 3 0.0 in

(* ´ÖÀÜ¸÷¥µ¥ó¥×¥ê¥ó¥°¤Ë»È¤¦Êý¸þ¥Ù¥¯¥È¥ë *)
let dirvecs = 
  let dummyf = create_array 0 0.0 in
  let dummyff = create_array 0 dummyf in
  let dummy_vs = create_array 0 (dummyf, dummyff) in
  create_array 5 dummy_vs
in
(* ¸÷¸»¸÷¤ÎÁ°½èÍýºÑ¤ßÊý¸þ¥Ù¥¯¥È¥ë *)
let light_dirvec =
  let dummyf2 = create_array 0 0.0 in
  let v3 = create_array 3 0.0 in
  let consts = create_array 60 dummyf2 in
  (v3, consts)
in
(* ¶ÀÊ¿ÌÌ¤ÎÈ¿¼Í¾ðÊó *)
let reflections =
  let dummyf3 = create_array 0 0.0 in
  let dummyff3 = create_array 0 dummyf3 in
  let dummydv = (dummyf3, dummyff3) in
  create_array 180 (0, dummydv, 0.0)
in
(* reflections¤ÎÍ­¸ú¤ÊÍ×ÁÇ¿ô *) 

let n_reflections = create_array 1 0 in

