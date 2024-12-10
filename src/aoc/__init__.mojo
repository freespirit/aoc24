from .common import AoCDaySolver
from .day_01 import Day1Solver
from .day_02 import Day2Solver
from .day_03 import Day3Solver
from .day_04 import Day4Solver
from .day_05 import Day5Solver
from .day_10 import Day10Solver


fn solve(day: Int, input_file: String) raises -> (String, String):
    with open(input_file, "r") as f:
        content = f.read()

    if day == 1:
        return _solve(Day1Solver(), content)
    elif day == 2:
        return _solve(Day2Solver(), content)
    elif day == 3:
        return _solve(Day3Solver(), content)
    elif day == 4:
        return _solve(Day4Solver(), content)
    elif day == 5:
        return _solve(Day5Solver(), content)
    elif day == 10:
        return _solve(Day10Solver(), content)
    else:
        var msg = "Module not implemented yet: Day " + str(day)
        raise Error(msg)


fn _solve[
    T: AoCDaySolver
](solver: T, content: String) raises -> (String, String):
    var part_1: String = solver.solve_part_1(content)
    var part_2: String = solver.solve_part_2(content)

    return (part_1, part_2)
