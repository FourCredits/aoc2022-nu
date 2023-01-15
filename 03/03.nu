def part1 [] {
  split row "\n" | each { |s| common-element-priority $s } | math sum
}

def part2 [] {
  split row "\n"
  | each { split chars }
  | group 3
  | each { |group| score (
    $group
    | reduce { |it, acc| intersection $acc $it }
    | first) }
  | math sum
}

def common-element-priority [s] {
  let l = ($s | str length) / 2
  let start = ($s | str substring ..$l)
  let end = ($s | str substring $l..)
  score ($start | split chars | where { |c| $end | str contains $c } | first)
}

let priorities = (
    (seq char a z | zip (seq 1 26))
    | append (seq char A Z | zip (seq 27 52)
  )
  | each { |x| {char: $x.0 priority: $x.1} }
  | transpose --header-row --as-record)

def score [char: string] {
    $priorities | get -s $char
}

def intersection [l1: list, l2: list] {
  $l1 | where { |x| $x in $l2 }
}
