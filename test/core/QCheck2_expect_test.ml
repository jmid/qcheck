open QCheck2_tests

(* Calling runners *)

let () = QCheck_base_runner.set_seed 1234
let _ =
  (*Memtrace.trace_if_requested ();*) (* <-- new line *)
  QCheck_base_runner.run_tests ~colors:false (*~verbose:true*) (
    Overall.tests @
    Generator.tests @
    Shrink.tests @
    Function.tests @
    FindExample.tests @
    Stats.tests)

let () = QCheck_base_runner.set_seed 153870556
let _  = QCheck_base_runner.run_tests ~colors:false [Stats.int_dist_empty_bucket]
