(** QCheck(1) tests **)

(* tests of statistics and histogram display *)
module Stats = struct
  open QCheck

  let int_dist_tests =
    let dist = ("dist",fun x -> x) in
    [ Test.make ~name:"int dist"                       ~count:100000 (add_stat dist int)                              (fun _ -> true);
      Test.make ~name:"oneof int dist"                 ~count:1000   (add_stat dist (oneofl[min_int;-1;0;1;max_int])) (fun _ -> true);
    ]

  let int_dist_empty_bucket =
    Test.make ~name:"int_dist_empty_bucket" ~count:1_000
      (add_stat ("dist",fun x -> x) (oneof [small_int_corners ();int])) (fun _ -> true)

  let tests = int_dist_tests
end
