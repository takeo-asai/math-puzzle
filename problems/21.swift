// n段目はn個
// a[n+1][i+1] = a[n][i] xor a[n][i+1] i <= n-1

var memo: [Int:[Bool]] = Dictionary()
func pyramid(n: Int) -> [Bool] {
	func pyramidx(n: Int, _ before: [Bool]) -> [Bool] {
		if let m = memo[n] {
			return m
		}
		var after: [Bool] = [true]
		for i in 0 ..< n - 1 {
			after.append(before[i] != before[i+1])
		}
		after.append(true)
		memo[n] = after
		return after
	}
	if n <= 1 {
		return [true]
	} else if n <= 2 {
		return [true, true]
	}
	var before = [true, true]
	for i in before.count ... n-1 {
		before = pyramidx(i, before)
	}
	return before
}

var n = 0
var count = 0
while count < 2014 {
	n++
	count += pyramid(n).reduce(0) { $0 + ($1 ? 0 : 1) }
}
print(n)
