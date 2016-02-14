// 10x + 50y + 100z + 500w = 1000
// x + y + z + w + s == 15
// s >= 0 (s: slack variable)

var combinations: [(Int, Int, Int, Int)] = []

for w in 0 ... 2 {
	for z in 0 ... 10 {
		for y in 0 ... 15 { // 20
			let x = 100 - 50*w - 10*z - 5*y
			if x <= 15 - y - z - w && x >= 0 {
				combinations += [(x, y, z, w)]
			}
		}
	}
}

print(combinations.count)
