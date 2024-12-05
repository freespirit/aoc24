struct Day3Solver(AoCDaySolver):
    fn __init__(inout self):
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        var mul_pos = input_content.find("mul")

        var result = 0

        while mul_pos != -1:
            var open_pos = input_content.find("(", mul_pos)
            var close_pos = input_content.find(")", open_pos)
            var comma_pos = input_content.find(",", open_pos)
            if (
                open_pos == (mul_pos + 3)
                and comma_pos > open_pos
                and comma_pos < close_pos
            ):
                var left = input_content[open_pos + 1 : comma_pos]
                var right = input_content[comma_pos + 1 : close_pos]
                if left.isdigit() and right.isdigit():
                    result += atol(left) * atol(right)

            mul_pos = input_content.find("mul", mul_pos + 1)

        return str(result)

    fn solve_part_2(self, input_content: String) raises -> String:
        var enabled = True
        var result = 0
        var mem = input_content

        for i in range(len(mem)):
            if mem[i] == "d":
                if mem[i : i + 5] == "don't":
                    enabled = False
                elif mem[i : i + 2] == "do":
                    enabled = True

            if mem[i] == "m" and mem[i : i + 4] == "mul(" and enabled:
                var open_pos = i + 3
                var comma_pos = input_content.find(",", open_pos)
                var close_pos = input_content.find(")", open_pos)
                var left = mem[open_pos + 1 : comma_pos]
                var right = mem[comma_pos + 1 : close_pos]
                if left.isdigit() and right.isdigit():
                    result += atol(left) * atol(right)

        return str(result)
