func - (lhs: [Int], rhs: [Int]) -> [Int] {
	var ret = lhs
	for x in rhs {
		if let i = ret.indexOf(x) {
			ret.removeAtIndex(i)
		}
	}
	return ret
}
func union(lhs: [Int], _ rhs: [Int]) -> [Int] {
	var ret: [Int] = []
	for x in rhs {
		if lhs.contains(x) {
			ret += [x]
		}
	}
	return ret
}

func isCutable(n: Int, present: Int, rest: [Int], strawberries: [Int]) -> (Bool, [Int]?) {
	let sqs = (2 ... n).map {$0*$0}
	if rest.count > 0 {
		let unions = union(sqs.map({$0-present}), rest)
		if unions.count == 0 {
			return (false, nil)
		}
		for x in unions {
			let ret = isCutable(n, present: x, rest: rest - [x], strawberries: strawberries + [x])
			if ret.0 {
				return ret
			}
		}
		return (false, nil)
	}
	// 最初と最後でもチェック
	if sqs.contains(strawberries[0] + strawberries[strawberries.count-1]) {
		return (true, .Some(strawberries))
	}
	return (false, nil)
}

var n = 10
let b = isCutable(n, present: 1, rest: (2 ... n).map {$0}, strawberries: [1])
while !isCutable(n, present: 1, rest: (2 ... n).map {$0}, strawberries: [1]).0 {
	n++
}
print(n)
print(isCutable(n, present: 1, rest: (2 ... n).map {$0}, strawberries: [1]))
