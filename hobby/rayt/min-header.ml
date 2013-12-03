let n_objects = create_array 1 0

(* ���֥������ȤΥǡ����������٥��ȥ�ʺ���60�ġ�*)
in
let objects = 
  let dummy = create_array 0 0.0 in
  create_array 60 (0, 0, 0, 0, dummy, dummy, false, dummy, dummy, dummy, dummy)

(* Screen ���濴��ɸ *)
in
let screen = create_array 3 0.0
(* �����κ�ɸ *)
in
let viewpoint = create_array 3 0.0
(* ���������٥��ȥ� (ñ�̥٥��ȥ�) *)
in
let light = create_array 3 0.0
(* ���̥ϥ��饤�ȶ��� (ɸ��=255) *)
in
let beam = create_array 1 255.0
(* AND �ͥåȥ�����ݻ� *)
in
let and_net = create_array 50 (create_array 1 (-1))
(* OR �ͥåȥ�����ݻ� *)
in
let or_net = create_array 1 (create_array 1 (and_net.(0)))

(* �ʲ�����Ƚ��롼������֤��ͳ�Ǽ�� *)
(* solver �θ��� �� t ���� *)
in
let solver_dist = create_array 1 0.0
(* ������ľ����ɽ�̤Ǥ����� *)
in
let intsec_rectside = create_array 1 0
(* ȯ�����������κǾ��� t *)
in
let tmin = create_array 1 (1000000000.0)
(* �����κ�ɸ *)
in
let intersection_point = create_array 3 0.0
(* ���ͤ������֥��������ֹ� *)
in
let intersected_object_id = create_array 1 0
(* ˡ���٥��ȥ� *)
in
let nvector = create_array 3 0.0
(* �����ο� *)
in
let texture_color = create_array 3 0.0

(* �׻���δ��ܼ������٤��ݻ� *)
in
let diffuse_ray = create_array 3 0.0
(* �����꡼�����������뤵 *)
in
let rgb = create_array 3 0.0

(* ���������� *)
in
let image_size = create_array 2 0
(* �������濴 = ������������Ⱦʬ *)
in
let image_center = create_array 2 0
(* 3������Υԥ�����ֳ� *)
in
let scan_pitch = create_array 1 0.0

(* judge_intersection��Ϳ����������� *)
in
let startp = create_array 3 0.0
(* judge_intersection_fast��Ϳ����������� *)
in
let startp_fast = create_array 3 0.0

(* ���̾��x,y,z����3�������־������ *)
in
let screenx_dir = create_array 3 0.0
in
let screeny_dir = create_array 3 0.0
in
let screenz_dir = create_array 3 0.0

(* ľ�ܸ����פǻȤ��������٥��ȥ� *)
in
let ptrace_dirvec  = create_array 3 0.0

(* ���ܸ�����ץ�󥰤˻Ȥ������٥��ȥ� *)
in
let dirvecs = 
  let dummyf = create_array 0 0.0 in
  let dummyff = create_array 0 dummyf in
  let dummy_vs = create_array 0 (dummyf, dummyff) in
  create_array 5 dummy_vs

(* ���������������Ѥ������٥��ȥ� *)
in
let light_dirvec =
  let dummyf2 = create_array 0 0.0 in
  let v3 = create_array 3 0.0 in
  let consts = create_array 60 dummyf2 in
  (v3, consts)

(* ��ʿ�̤�ȿ�;��� *)
in
let reflections =
  let dummyf3 = create_array 0 0.0 in
  let dummyff3 = create_array 0 dummyf3 in
  let dummydv = (dummyf3, dummyff3) in
  create_array 180 (0, dummydv, 0.0)

(* reflections��ͭ�������ǿ� *) 

in
let n_reflections = create_array 1 0

in
