let throws = {
  A: rock
  B: paper
  C: scissors
  X: rock
  Y: paper
  Z: scissors
}

def 'parse throw' [s] { $throws | get $s }

def 'parse result' [s] { { X: lose Y: draw Z: win } | get $s }

def 'score throw' [] {
  let t = $in; { rock: 1 paper: 2 scissors: 3} | get $t
}

def 'score result' [] {
  let t = $in; { win: 6 draw: 3 lose: 0} | get $t
}

def 'score part1' [them you] {
  (result $them $you | score result) + ($you | score throw)
}

def 'score part2' [them result] {
  ($result | score result) + (needed-throw $them $result | score throw)
}

def result [them you] {
  if ((beats $them) == $you) { 'win' }
  else if $them == $you      { 'draw' }
  else                       { 'lose' }
}

def needed-throw [them result] {
  { win: (beats $them) draw: $them lose: (loses-to $them) } | get $result
}

def beats [them] {
  { rock: paper, paper: scissors, scissors: rock } | get $them
}

def loses-to [them] {
  { rock: scissors, paper: rock, scissors: paper } | get $them
}

def part1 [] {
  split row "\n"
  | parse '{them} {you}' 
  | update them { parse throw $in.them }
  | update you { parse throw $in.you }
  | each { score part1 $in.them $in.you }
  | math sum
}

def part2 [] {
  split row "\n"
  | parse '{them} {result}'
  | update them { parse throw $in.them }
  | update result { parse result $in.result }
  | each { score part2 $in.them $in.result }
  | math sum
}
