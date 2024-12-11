from collections import Dict
from math import log10


@value
struct StepKey(KeyElement):
    var value: Int
    var blinks: Int

    fn __hash__(self: Self) -> UInt:
        return hash(self.value) ^ hash(self.blinks)

    fn __eq__(self: Self, other: Self) -> Bool:
        return self.value == other.value and self.blinks == other.blinks

    fn __ne__(self: Self, other: Self) -> Bool:
        return not self == other

    fn __str__(self: Self) -> String:
        return str(self.value) + " @ " + str(self.blinks)


alias Cache = Dict[StepKey, Int]


struct Day11Solver(AoCDaySolver):
    fn __init__(inout self) -> None:
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        var result = _helper(input_content, 25)
        return str(result)

    fn solve_part_2(self, input_content: String) raises -> String:
        var result = _helper(input_content, 75)
        return str(result)


fn _helper(input_content: String, times: Int) raises -> Int:
    var stones = input_content.splitlines()[0]

    var cache = Cache()
    var result: Int = 0
    for stone in stones.split():
        var tmp_container = List[Int](atol(stone[]))
        result += _walk(tmp_container, times, cache)

    return result


fn _walk(stones: List[Int], blinks_left: Int, inout cache: Cache) raises -> Int:
    if blinks_left == 0:
        return 1

    var result: Int = 0
    for i in range(len(stones)):
        var stone = stones[i]

        var cache_key = StepKey(stone, blinks_left)
        if cache_key in cache:
            result += cache[cache_key]
            continue

        if stone == 0:
            var tmp = _walk(List[Int](1), blinks_left - 1, cache)
            cache[cache_key] = tmp
            result += tmp
        else:
            var num_digits = int(log10(Float64(stone))) + 1
            if num_digits % 2 == 0:
                var denominator = pow(10, num_digits // 2)
                var left = stone // denominator
                var right = stone % denominator
                var tmp = 0
                tmp += _walk(List[Int](left), blinks_left - 1, cache)
                tmp += _walk(List[Int](right), blinks_left - 1, cache)
                cache[cache_key] = tmp
                result += tmp
            else:
                var new_value = stone * 2024
                var tmp = _walk(List[Int](new_value), blinks_left - 1, cache)
                cache[cache_key] = tmp
                result += tmp

    return result
