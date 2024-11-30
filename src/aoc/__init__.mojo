from aoc.common import AoCDaySolver
from aoc.day_1 import Day1Solver


fn solve(day: Int, input_file: String) raises -> (String, String):
    with open(input_file, "r") as f:
        content = f.read()

    if day == 1:
        return _solve(Day1Solver(), content)
    else:
        var msg = "Module not implemented yet: Day " + str(day)
        raise Error(msg)


fn _solve[
    T: AoCDaySolver
](solver: T, content: String) raises -> (String, String):
    var part_1: String = solver.solve_part_1(content)
    var part_2: String = solver.solve_part_2(content)

    return (part_1, part_2)
