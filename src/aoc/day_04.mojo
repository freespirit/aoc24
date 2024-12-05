from collections import List, Optional


alias WINDOW_SIZE_XMAS = 4
alias WINDOW_SIZE_MAS = 3
alias XMAS = "XMAS"
alias SAMX = "SAMX"


@value
struct Direction:
    var dx: Int
    var dy: Int


struct Day4Solver(AoCDaySolver):
    fn __init__(inout self):
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        var directions = List(
            Direction(0, 1),  # right
            Direction(0, -1),  # left
            Direction(1, 0),  # down
            Direction(-1, 0),  # up
            Direction(1, 1),  # bottom right
            Direction(-1, -1),  # top left
            Direction(-1, 1),  # top right
            Direction(1, -1),  # bottom left
        )

        var rows = List[String]()
        for row in input_content.splitlines():
            rows.append(row[])

        var appearances = 0
        for i in range(len(rows)):
            var row = rows[i]
            for j in range(len(row)):
                if row[j] != "X":
                    continue

                for dx_dy in directions:
                    var dx = dx_dy[].dx
                    var dy = dx_dy[].dy
                    var word_in_window = _build_word(
                        i, j, dx, dy, WINDOW_SIZE_XMAS, rows
                    )
                    if not word_in_window:
                        continue

                    if (
                        word_in_window.value() == "XMAS"
                        or word_in_window.value() == "SAMX"
                    ):
                        appearances += 1

        return str(appearances)

    fn solve_part_2(self, input_content: String) raises -> String:
        var rows = List[String]()
        for row in input_content.splitlines():
            rows.append(row[])

        var appearances = 0
        for i in range(len(rows)):
            var row = rows[i]
            for j in range(len(row)):
                if row[j] != "A":
                    continue

                # main diagonal with A in the center
                var main_diagonal = _build_word(
                    i - 1, j - 1, +1, +1, WINDOW_SIZE_MAS, rows
                )
                # secondary diagonal with A in the center
                var secondary_diagonal = _build_word(
                    i + 1, j - 1, -1, +1, WINDOW_SIZE_MAS, rows
                )

                var words_to_check = List[String]()
                if main_diagonal and secondary_diagonal:
                    var main_d = main_diagonal.value()
                    var secondary_d = secondary_diagonal.value()
                    if (main_d == "MAS" or main_d == "SAM") and (
                        secondary_d == "MAS" or secondary_d == "SAM"
                    ):
                        appearances += 1

        return str(appearances)


fn _is_valid_position(x: Int, y: Int, num_lines: Int, num_columns: Int) -> Bool:
    return x >= 0 and x < num_lines and y >= 0 and y < num_columns


fn _build_word(
    start_x: Int,
    start_y: Int,
    dx: Int,
    dy: Int,
    window_size: Int,
    input: List[String],
) -> Optional[String]:
    word = String()
    x, y = start_x, start_y

    for _ in range(window_size):
        if not _is_valid_position(x, y, len(input), len(input[0])):
            return Optional[String](None)

        word += input[x][y]
        x += dx
        y += dy

    return Optional[String](word)
