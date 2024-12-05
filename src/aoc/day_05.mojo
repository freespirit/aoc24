from collections import Dict, List, Optional, Set


struct Day5Solver(AoCDaySolver):
    fn __init__(inout self):
        pass

    fn solve_part_1(self, input_content: String) raises -> String:
        var index_break = input_content.splitlines().index("")
        var rules = input_content.splitlines()[:index_break]
        var updates = input_content.splitlines()[index_break + 1 :]

        validator = PageOrderValidator()
        for rule in rules:
            var parts = rule[].split("|")
            var before = atol(parts[0])
            var after = atol(parts[1])

            validator.add_rule(before, after)

        var middle_sum = 0
        for sequence in updates:
            if validator.verify_sequence(sequence[]):
                var pages = List[Int]()
                for page in sequence[].split(","):
                    pages.append(atol(page[]))
                middle_sum += pages[len(pages) // 2]

        return str(middle_sum)

    fn solve_part_2(self, input_content: String) raises -> String:
        var index_break = input_content.splitlines().index("")
        var rules = input_content.splitlines()[:index_break]
        var updates = input_content.splitlines()[index_break + 1 :]

        validator = PageOrderValidator()
        for rule in rules:
            var parts = rule[].split("|")
            var before = atol(parts[0])
            var after = atol(parts[1])

            validator.add_rule(before, after)

        # Process each sequence
        var middle_sum = 0
        for sequence in updates:
            if not validator.verify_sequence(sequence[]):
                var pages = List[Int]()
                for page in sequence[].split(","):
                    pages.append(atol(page[]))

                var sorted_pages = validator.topological_sort(pages)
                middle_sum += sorted_pages[len(sorted_pages) // 2]

        return str(middle_sum)


@value
struct Dependencies(CollectionElement):
    var _dependencies: Set[Int]

    fn __init__(inout self, owned dependencies: Set[Int]):
        self._dependencies = dependencies^

    fn __copyinit__(inout self, other: Dependencies):
        self._dependencies = Set[Int]()
        for dep in other._dependencies:
            self._dependencies.add(dep[])

    fn add(inout self, dep: Int):
        self._dependencies.add(dep)

    fn __len__(self) -> Int:
        return len(self._dependencies)

    fn __contains__(self, dep: Int) -> Bool:
        return dep in self._dependencies


struct PageOrderValidator:
    var depends_on: Dict[Int, Dependencies]

    def __init__(inout self):
        self.depends_on = Dict[Int, Dependencies]()

    fn add_rule(inout self, before: Int, after: Int):
        var dependencies = self.depends_on.get(after)
        if not dependencies:
            dependencies = Optional(Dependencies(Set[Int]()))

        dependencies.value().add(before)
        self.depends_on[after] = dependencies.value()

    fn verify_sequence(self, sequence: String) raises -> Bool:
        var pages = sequence.strip().split(",")

        # Create position lookup for O(1) position checks
        var positions = Dict[Int, Int]()
        for i in range(len(pages)):
            var page = atol(pages[i])
            positions[page] = i

        for _page in pages:
            var page = atol(_page[])
            var dependency = self.depends_on.get(page)
            if not dependency:
                continue

            for dep in dependency.value()._dependencies:
                if dep[] in positions:
                    if positions[dep[]] >= positions[page]:
                        return False

        return True

    def topological_sort(self, pages: List[Int]) -> List[Int]:
        # Create a copy of dependencies for just these pages
        var local_depends = Dict[Int, Dependencies]()
        for p in pages:
            var dependencies = self.depends_on[p[]]
            var local_deps = Set[Int]()
            for d in dependencies._dependencies:
                if d[] in pages:
                    local_deps.add(d[])
            local_depends[p[]] = Dependencies(local_deps^)

        # Count dependencies for each page
        var in_degree = Dict[Int, Int]()
        for item in local_depends.items():
            in_degree[item[].key] = len(item[].value)

        # Start with pages that have no dependencies
        var queue = List[Int]()
        for p in pages:
            if in_degree[p[]] == 0:
                queue.append(p[])
        var result = List[Int]()

        while queue:
            page = queue.pop(0)
            result.append(page)

            # Update in-degrees by removing this page as a dependency
            for other_page in pages:
                if page in local_depends[other_page[]]:
                    in_degree[other_page[]] -= 1
                    if in_degree[other_page[]] == 0:
                        queue.append(other_page[])

        return result
