let sqrts = (1 ... 125).map {Double($0*$0)}

func isCreatable(x2: Double, _ length: Int) -> Bool {
	for a in 1 ..< length/2 {
		let b = length/2 - a
		if a != b && Double(a * b) == x2 {
			return true
		}
	}
	return false
}

var count = 0
var list: [[Double]] = []
for length in 8 ... 500 {
	let c2 = Double(length/4) * Double(length/4)
	for a2 in sqrts.filter({$0 < c2}) {
		let b2 = c2 - a2
		if a2 < b2 && isCreatable(a2, length) && isCreatable(b2, length) && sqrts.contains(b2) {
			count++
			list += [[a2, b2, c2]]
		}
	}
}
print(list)
