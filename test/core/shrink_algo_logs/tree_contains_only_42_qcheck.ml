open QCheck

module IntTree = struct
  open QCheck

  type tree = Leaf of int | Node of tree * tree

  let leaf x = Leaf x
  let node x y = Node (x,y)

  let rec depth = function
    | Leaf _ -> 1
    | Node (x, y) -> 1 + max (depth x) (depth y)

  let rec print_tree = function
    | Leaf x -> Printf.sprintf "Leaf %d" x
    | Node (x, y) -> Printf.sprintf "Node (%s, %s)" (print_tree x) (print_tree y)

  let gen_tree = Gen.(sized @@ fix
                        (fun self n -> match n with
                           | 0 -> map leaf nat
                           | n ->
                             frequency
                               [1, map leaf nat;
                                2, map2 node (self (n/2)) (self (n/2))]
                        ))

  let rec shrink_tree t = match t with
    | Leaf l -> Iter.map (fun l' -> Leaf l') (Shrink.int l)
    | Node (x,y) ->
      let open Iter in
      of_list [x;y]
      <+> map (fun x' -> Node (x',y)) (shrink_tree x)
      <+> map (fun y' -> Node (x,y')) (shrink_tree y)

  let rec contains_only_n tree n = match tree with
    | Leaf n' -> n = n'
    | Node (x, y) -> contains_only_n x n && contains_only_n y n
end

let tree_contains_only_42 =
  Test.make ~name:"tree contains only 42"
    IntTree.(make ~print:print_tree ~shrink:shrink_tree gen_tree)
    (Log.shrinks IntTree.print_tree @@ fun tree -> IntTree.contains_only_n tree 42)
;;
try Test.check_exn tree_contains_only_42 with Test.Test_fail _ -> ()
