def part1 [] {
    split row "\n"
    | split list ''
    | each { each { into int } | math sum }
    | math max
}

def part2 [] {
    split row "\n"
    | split list ''
    | each { each { into int } | math sum }
    | sort -r
    | take 3
    | math sum
}

