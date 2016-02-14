struct Stick {
	let length: Int
	init(_ l: Int) {
		length = l
	}
	func cut() -> [Stick] {
		if isCutable() {
			return [Stick(length/2), Stick(length/2 + length%2)]
		}
		return [self]
	}
	func isCutable() -> Bool {
		return length != 1
	}
}

let n = 100
let m = 5
var sticks: [Stick] = [Stick(n)]

var t = 0
while true {
	// terminate if cut is done
	let cutable: Bool = sticks.map() { $0.isCutable() }.reduce(false) { $0 || $1 }
	if !cutable {
		break
	}
	// cut
	var tmps: [Stick] = []
	for _ in 0 ..< m {
		if sticks.count > 0 {
			let stick = sticks.removeAtIndex(0)
			tmps += stick.cut()
		}
	}
	sticks += tmps

	sticks = sticks.sort { (s0: Stick, s1: Stick) -> Bool in s0.length > s1.length }

	t++
}

print("times: \(t)")
