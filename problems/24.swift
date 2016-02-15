// 1 2 3
// 4 5 6
// 7 8 9
let targets = [1, 2, 3, 4, 5, 6, 7, 8, 9]
let neighbors: [Int: [Int?]] = 	[1: [2, 4, nil], 2: [1, 3, nil], 3: [2, 6, nil],
								4: [1, 7, nil], 5: [nil], 6: [3, 9, nil],
								7: [4, 8, nil], 8: [7, 9, nil], 9: [6, 8, nil]]
func - (lhs: [Int], rhs: [Int]) -> [Int] {
	var expr = lhs
	for e in rhs {
		if let idx = expr.indexOf(e) {
			expr.removeAtIndex(idx)
		}
	}
	return expr
}

func isStrikable(targets: [Int], neighbor: Int?) -> Bool {
	if let n = neighbor {
		return targets.contains(n)
	}
	return false
}
struct Status: Hashable {
	var values: [Int]
	init(_ v: [Int]) {
		values = v
	}
    var hashValue: Int {
        get {
            return values.description.hashValue
        }
    }
}
func == (lhs: Status, rhs: Status) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

var memo: [Status: Int] = Dictionary()
func depthSearch(targets: [Int]) -> Int {
	if let m = memo[Status(targets)] {
		return m
	}
	if targets.count == 0 {
		return 1
	}
	var count = 0
	for t in targets {
		for n in neighbors[t]! {
			if isStrikable(targets, neighbor: n) {
				count += depthSearch(targets - [n!] - [t])
			}
		}
		count += depthSearch(targets - [t])
	}
	memo[Status(targets)] = count
	return count
}

let t = depthSearch(targets)
print(t)
// 1507200 but answer is 798000
