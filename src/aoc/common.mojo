"""Common trait for all the dayly solvers"""


trait AoCDaySolver:
    fn solve_part_1(self, input_content: String) raises -> String:
        ...

    fn solve_part_2(self, input_content: String) raises -> String:
        ...
