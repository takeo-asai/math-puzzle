enum Direction {
	case Right
	case Left
	case Top
	case Down
	case ERROR
}

struct Status: Hashable {
	let log: [(Int, Int)]
	let present: (x: Int, y: Int)
	let map: (n: Int, m: Int)
	init(_ p: (Int, Int), _ m: (Int, Int), _ l: [(Int, Int)] = []) {
		log = l
		present = p
		map = m
	}
	func isGoal() -> Bool {
		return present.x == map.n && present.y == map.m
	}
	func move(m: (Int, Int)) -> Status {
		return Status(m, map, log + [present])
	}
	func movables() -> [(Int, Int)] {
		var ms: [(Int, Int)] = []
		switch direction() {
		case .Top:
			ms += [(present.x, present.y+1), (present.x-1, present.y)]
		case .Down:
			ms += [(present.x, present.y-1), (present.x+1, present.y)]
		case .Right:
			ms += [(present.x+1, present.y), (present.x, present.y+1)]
		case .Left:
			ms += [(present.x-1, present.y), (present.x, present.y-1)]
		case .ERROR:
			ms = []
		}
		ms = ms.filter { (x: Int, y: Int) -> Bool in x >= 0 && x <= map.n && y >= 0 && y <= map.m }

		// containsはtupleでは==出来ないので働かないためベタ比較する
		if log.count > 1 {
			var mms: [(Int, Int)] = []
			for next in ms {
				var t = true
				for i in 0 ..< log.count - 1 {
					let (x, y) = log[i]
					let (nx, ny) = log[i+1]
					if x == present.x && y == present.y && nx == next.0 && ny == next.1 {
						t = false
					}
					if nx == present.x && ny == present.y && x == next.0 && y == next.1 {
						t = false
					}
				}
				if t {
					mms.append(next)
				}
			}
			ms = mms
		}
		//print("p: \(present), log: \(log), dir: \(direction())")
		return ms
	}
	func direction() -> Direction {
		guard let last: (x: Int, y: Int) = log.last else {
			return .Right // 最初は右向き
		}
		let dx = present.x - last.x
		let dy = present.y - last.y
		switch (dx, dy) {
		case (1, 0):
			return .Right
		case (-1, 0):
			return .Left
		case (0, 1):
			return .Top
		case (0, -1):
			return .Down
		default:
			return .ERROR
		}
	}
    var hashValue: Int {
        get {
            return (log.description + "(\(present.x),\(present.y))").hashValue
        }
    }
}
func == (lhs: Status, rhs: Status) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

func depthSearch(s: Status) -> (Int, [[(Int, Int)]]) {
	if s.isGoal() {
		return (1, [s.log + [s.present]])
	}
	var count = 0
	var list: [[(Int, Int)]] = []
	for m in s.movables() {
		let (a, b) = depthSearch(s.move(m))
		count += a
		list += b
	}
	return (count, list)
}

let s = Status((0, 0), (6, 4))
let (c, a) = depthSearch(s)
print("count: \(c)")
for x in a {
	//print(x)
}
