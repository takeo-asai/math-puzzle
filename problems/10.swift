let europians = [0, 32, 15, 19, 4, 21, 2, 25, 17, 34, 6, 27, 13, 36, 11, 30, 8, 23, 10, 5, 24, 16, 33, 1, 20, 14, 31, 9, 22, 18, 29, 7, 28, 12, 35, 3, 26]
let americans = [0, 28, 9, 26, 30, 11, 7, 20, 32, 17, 5, 22, 34, 15, 3, 24, 36, 13, 1, 00, 27, 10, 25, 29, 12, 8, 19, 31, 18, 6, 21, 33, 16, 4, 23, 35, 14, 2]

func max(a: [Int], n: Int) -> Int {
	var max: Int = 0
	for i in 0 ..< a.count {
		var s = 0
		for j in 0 ..< n {
			s += a[(i+j)%a.count]
		}

		if s > max {
			max = s
		}
	}
	return max
}

var count = 0
for n in 2 ... 36 {
	let euroMax = max(europians, n: n)
	let amerMax = max(americans, n: n)
	if euroMax < amerMax {
		count++
	}
}
print(count)
