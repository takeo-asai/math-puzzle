var memo: [Int: Int] = Dictionary()
func partition(n: Int) -> Int {
	if n%2 != 0 {
		return 0
	} else if n == 0 {
		return 1
	}
	var count = 0
	for k in 1 ... n-1 {
		let x = partition(k-1)
		let y = partition(n-k-1)
		count += x * y
		memo[k-1] = x
		memo[n-k-1] = y
	}
	return count
}

let n = 16
let p = partition(n)

print(p)
