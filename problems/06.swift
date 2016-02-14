// 2m-1: 3n+1
// 2m: n/2
// 初期値はともに3n+1する

func collatzx(n: Int) -> (Int, [Int]) {
	func collatz(n: Int, _ history: [Int]) -> (Int, [Int]) {
		let m: Int = n % 2 == 0 ? n/2 : 3*n + 1
		if history.contains(m) {
			return (m, history+[m])
		}
		return collatz(m, history+[m])
	}
	return collatz(3*n+1, [n, 3*n+1])
}

var count = 0
for i in 1 ... 5000 {
	if collatzx(2*i).0 == 2*i {
		count++
	}
}

print("Count: \(count)")
