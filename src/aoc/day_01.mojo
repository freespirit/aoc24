from aoc.common import AoCDaySolver


struct Day1Solver(AoCDaySolver):
    fn __init__(inout self):
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        var lines = input_content.splitlines()
        var left = List[Int]()
        var right = List[Int]()
        for line in lines:
            var parts = line[].split()
            left.append(atol(parts[0]))
            right.append(atol(parts[1]))

        sort(left)
        sort(right)

        var result = 0
        for i in range(0, len(left)):
            result += abs(right[i] - left[i])

        return str(result)

    fn solve_part_2(self, input_content: String) raises -> String:
        var lines = input_content.splitlines()
        var left = List[Int]()
        var right = List[Int]()
        for line in lines:
            var parts = line[].split()
            left.append(atol(parts[0]))
            right.append(atol(parts[1]))


        var sim_score = 0
        for i in range(0, len(left)):
            var count = right.count(left[i])
            sim_score += (left[i] * count)

        return str(sim_score)
