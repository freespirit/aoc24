from time import sleep


struct Day15Solver(AoCDaySolver):
    fn __init__(inout self) -> None:
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        return _helper(input_content)

    fn solve_part_2(self, input_content: String) raises -> String:
        return "TODO"


fn _helper(input_content: String) raises -> String:
    var parts = input_content.split("\n\n")
    var map = List[List[String]]()
    for line in parts[0].splitlines():
        var row = List[String]()
        for char in line[]:
            row.append(String(char))
        map.append(row)


    var movements_raw = parts[1].splitlines()
    var movements = List[String]()
    for line in movements_raw:
        for char in line[]:
            movements.append(String(char))

    # print_map(map)
    # print(String("{}").format(movements.__repr__()))

    var start_pos = (0, 0)
    for i in range(len(map)):
        var line = map[i]
        for j in range(len(line)):
            if line[j] == "@":
                start_pos = (i, j)
                break
    # print(start_pos[0], start_pos[1])

    var pos = Tuple(start_pos[0], start_pos[1])
    for movement in movements:
        var offset = offset(movement[])
        (x, y) = (pos[0] + offset[0], pos[1] + offset[1])
        # print("@ ", pos[0], pos[1], movement[])

        if map[x][y] == "#":
            continue

        if map[x][y] == "O":
            try_move_boxes(map, (x, y), offset)
        if try_move_robot(map, pos, (x, y)):
            pos = (x, y)
        # print_map(map)
        # sleep(0.05)

    var gps_sum = 0
    for i in range(len(map)):
        var line = map[i]
        for j in range(len(line)):
            if line[j] == "O":
                gps_sum += (100 * i + j)

    return str(gps_sum)


fn print_map(map: List[List[String]]):
    for line in map:
        print("".join(line[]))


fn offset(movement: String) raises -> Tuple[Int, Int]:
    if movement == "^":
        return (-1, 0)
    elif movement == "v":
        return (1, 0)
    elif movement == "<":
        return (0, -1)
    elif movement == ">":
        return (0, 1)
    else:
        raise Error("Invalid movement: " + movement)


fn try_move_boxes(
    inout map: List[List[String]], pos_from: Tuple[Int, Int], offset: Tuple[Int, Int]
):
    var from_x = pos_from[0]
    var from_y = pos_from[1]
    var to_x = pos_from[0] + offset[0]
    var to_y = pos_from[1] + offset[1]

    if map[to_x][to_y] == "#":
        return

    if map[to_x][to_y] == "O":
        try_move_boxes(map, (to_x, to_y), offset)

    if map[to_x][to_y] == ".":
        map[from_x][from_y] = "."
        map[to_x][to_y] = "O"

fn try_move_robot(
    inout map: List[List[String]], pos_from: Tuple[Int, Int], pos_to: Tuple[Int, Int]
) -> Bool:
    if map[pos_to[0]][pos_to[1]] == ".":
        map[pos_from[0]][pos_from[1]] = "."
        map[pos_to[0]][pos_to[1]] = "@"
        return True

    return False

