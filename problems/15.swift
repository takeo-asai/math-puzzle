// A: 0
// B: n
struct Status: Hashable {
	let pos: (a: Int, b: Int)
	init(_ x: Int, _ y: Int) {
		pos = (x, y)
	}
	func move(x: Int, _ y: Int) -> Status {
		return Status(pos.a+x, pos.b+y)
	}
	func isDone() -> Bool {
		return pos.a >= pos.b
	}
	func isSuccess() -> Bool {
		return pos.a == pos.b
	}
	var hashValue: Int {
        get {
            return String("\(pos.a),\(pos.b)").hashValue // error
        }
    }
}
func == (lhs: Status, rhs: Status) -> Bool {
    return lhs.pos.a == rhs.pos.a && lhs.pos.b == rhs.pos.b
}

let moves = [1, 2, 3, 4]
var memo: [Status: [[Status]]] = Dictionary()

func depthSearch(present: Status, log: [Status]) -> [[Status]] {
	if let m = memo[present] {
		return m
	}
	if present.isDone() {
		if present.isSuccess() {
			return [log + [present]]
		}
		return []
	}

	var s: [[Status]] = []
	for x in moves {
		for y in moves {
			let tours = depthSearch(present.move(x, -y), log: log + [present])
			s += tours
			memo[present.move(x, -y)] = tours
		}
	}
	return s
}

let n = 20
let c = depthSearch(Status(0, n), log: [])
print(c.count)
