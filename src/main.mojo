from aoc import solve
from sys import argv


def main():
    var day = atol(argv()[1])
    var input_file = argv()[2]

    part_1, part_2 = solve(day=day, input_file=input_file)

    print("Part 1: ", part_1)
    print("Part 2: ", part_2)
