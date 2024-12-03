from aoc.common import AoCDaySolver


@value
struct Report(CollectionElement):
    var levels: List[Int]


struct Day2Solver(AoCDaySolver):
    fn __init__(inout self):
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        var reports = _build_reports(input_content)

        var total_safe = 0
        for report in reports:
            if _is_safe(report[]):
                total_safe += 1

        return str(total_safe)

    fn solve_part_2(self, input_content: String) raises -> String:
        var reports = _build_reports(input_content)

        var total_safe = 0
        for report in reports:
            if _is_safe(report[]):
                total_safe += 1
            elif _try_dampen(report[]):
                total_safe += 1

        return str(total_safe)


fn _build_reports(input_content: String) raises -> List[Report]:
    var reports = List[Report]()

    for line in input_content.splitlines():
        var levels = List[Int]()
        for level in line[].split():
            levels.append(atol(level[]))

        reports.append(Report(levels))

    return reports^


fn _is_safe(report: Report) -> Bool:
    var sorted_levels = report.levels
    sort(sorted_levels)

    var is_increasing = sorted_levels == report.levels
    if not is_increasing:
        var rev = List[Int]()
        for elem in reversed(sorted_levels):
            rev.append(elem[])

        var is_decreasing = rev == report.levels
        if not is_decreasing:
            # neither increasing nor decreasing
            return False

    for i in range(0, len(report.levels) - 1):
        var diff = abs(report.levels[i + 1] - report.levels[i])
        if diff < 1 or diff > 3:
            return False

    return True


fn _try_dampen(report: Report) -> Bool:
    for i in range(len(report.levels)):
        var new_levels = report.levels
        var _unused = new_levels.pop(i)
        var dampened_report = Report(new_levels)
        if _is_safe(dampened_report):
            return True

    return False
