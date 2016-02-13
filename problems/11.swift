// 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144 ...
func fib(n: Int) -> Int {
	func fibx(n: Int, log: [Int]) -> Int {
		if n <= 2 {
			return 1
		}
		if n == log.count {
			return log[0]
		}
		let a2 = log[0]
		let a1 = log[1]
		return fibx(n, log: [a1+a2]+log)
	}
	if n >= 3 {
		return fibx(n, log: [1, 1])
	}
	return 1
}

func sumDigits(a: Int) -> Int {
	var sum = 0
	var x = a
	while x > 0 {
		sum += x % 10
		x = x / 10
	}
	return sum
}

var n = 13 // fib > 144
var list: [Int] = []
while list.count < 5 {
	let f = fib(n)
	if f % sumDigits(f) == 0 {
		list.append(f)
	}
	n++
}
print(list)
