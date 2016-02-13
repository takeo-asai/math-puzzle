import Foundation

func digits(d: Double) -> [Int] {
	var digits: [Int] = []
	let str = String(d)
	for s in str.characters {
		if let n: Int = Int(String(s), radix: 10) {
			digits.append(n)
		}
	}
	return digits
}

func allExist(a: [Int], _ idx: Int = 0) -> Int? {
	var box: [Bool] = Array(count: 10, repeatedValue: false)
	for i in idx ..< a.count {
		box[a[i]] = true
		let isALLExist = box.reduce(true) { $0 && $1 }
		if isALLExist {
			return i
		}
	}
	return nil
}


var m: (v: Double, min: Int) = (0, 1000)
for n in 1 ..< 10000 {
	let digs = digits(sqrt(Double(n)))
	if let v = allExist(digs) {
		if v < m.min {
			m = (sqrt(Double(n)), v)
		}
	}
}
// 1362
print(m)



do {
	assert(allExist([0,1,2,3,4,5,6,7,8,8,9]) == 10)
	assert(allExist([0,1,2,3,4,5,6,7,8,9]) == 9)
	assert(allExist([0,1,2,3,4,5,6,8,9]) == nil)
}
