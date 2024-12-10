from collections import Set

struct Day10Solver(AoCDaySolver):
    fn __init__(inout self) -> None:
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        # unroll the input
        var input = List[Int]()
        for row in input_content.splitlines():
            var line = row[].strip()
            for i in range(len(line)):
                input.append(atol(line[i]))

        var trailheads = List[Int]()
        for i in range(len(input)):
            if input[i] == 0:
                trailheads.append(i)

        var total_score = 0
        var total_ratings = 0

        var width = len(input_content.splitlines()[0].strip())
        for start_pos in trailheads:
            var tops = _walk(start_pos[], input, width)
            var score = len(Set(tops))
            var rating = len(tops)
            # print("Tops " + str(start_pos[]) + ": " + str(score))
            # print("Paths: " + str(len(tops)))
            total_score += score
            total_ratings += rating

        return str(total_score) + " " + str(total_ratings)

    fn solve_part_2(self, input_content: String) raises -> String:
        return "Check part 1 - solved together"


fn _walk(cur_pos: Int, map: List[Int], columns: Int) -> List[Int]:
    # print(str(cur_pos // columns) + "," + str(cur_pos % columns) + " -> " + str(map[cur_pos]))

    if map[cur_pos] == 9:
        return List[Int](cur_pos)

    var paths = List[Int]()

    var up = cur_pos - columns
    if up >= 0 and (map[up] - map[cur_pos] == 1):
        paths += _walk(up, map, columns)

    var down = cur_pos + columns
    if down < len(map) and (map[down] - map[cur_pos] == 1):
        paths += _walk(down, map, columns)

    var on_same_row = False

    var left = cur_pos - 1
    on_same_row = (left // columns == cur_pos // columns)
    if on_same_row and (map[left] - map[cur_pos] == 1):
        paths += _walk(left, map, columns)

    var right = cur_pos + 1
    on_same_row = (right // columns == cur_pos // columns)
    if on_same_row and (map[right] - map[cur_pos] == 1):
        paths += _walk(right, map, columns)

    return paths
