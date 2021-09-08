open QCheck

let nats_smaller_5001 =
  Test.make ~name:"nat < 5001"
    (make ~shrink:Shrink.int Gen.nat) (Log.shrinks_int @@ fun n -> n < 5001)
;;
try Test.check_exn nats_smaller_5001 with Test.Test_fail _ -> ()