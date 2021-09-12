open QCheck2

let pair_sum_lt_128 =
  Test.make ~name:"pairs sum to less than 128"
    Gen.(pair (pint ~origin:0) (pint ~origin:0))
    (Log.shrinks Print.(pair int int) @@
     fun (i,j) -> i+j<128)
;;
try Test.check_exn pair_sum_lt_128 with Test.Test_fail _ -> ()
