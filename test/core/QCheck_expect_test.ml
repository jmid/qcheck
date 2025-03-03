let print_float i64 =
  Printf.printf "bits: %Li - float: %g\n%!" i64 (Int64.to_float i64)

let _ = List.iter print_float
    [
      4879367852577116075L;
      4880329516726610144L;
      4882384430223028138L;
      4883095049439037711L;
      4883176358557700215L;
    ]
