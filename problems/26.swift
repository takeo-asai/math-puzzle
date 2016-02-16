struct Status : Hashable {
	var car: (x: Int, y: Int)
	var space: (x: Int, y: Int)
	let iter: Int
	var limit: Int
	let n: Int
	let m: Int
	init(_ n: Int, _ m: Int, _ limit: Int , _ iter: Int = 0, _ car: (Int, Int) = (0,0), _ space: (Int, Int) = (-1, -1)) {
		self.n = n
		self.m = m
		self.iter = iter
		self.limit = limit
		self.car = car
		self.space = space.0 < 0 ? (n-1, m-1) : space
	}

	mutating func setLimit(l: Int) {
		self.limit = l
	}
	func neighbors(pos: (x: Int, y: Int)) -> [(Int, Int)] {
		let moves = [(1, 0), (-1, 0), (0, 1), (0, -1)]
		let neighbors = moves.map { (pos.x+$0.0, pos.y+$0.1) }
		return neighbors
	}
	func movables() -> [(Int, Int)] {
		return (neighbors(car) + neighbors(space)).filter { $0.0 >= 0 && $0.0 < n && $0.1 >= 0 && $0.1 < m }
	}
	func isSpace(s: (x: Int, y: Int)) -> Bool {
		return s.x == space.x && s.y == space.y
	}
	func isCar(c: (x: Int, y: Int)) -> Bool {
		return c.x == car.x && c.y == car.y
	}
	func isGoal() -> Bool {
		return car.x == n-1 && car.y == m-1
	}
	func move(pos: (Int, Int)) -> Status? {
		if iter >= limit {
			return nil
		}
		if isCar(pos) {
			return nil
		}
		if isSpace(pos) { // 空白なら車をそこへ移動
			return Status(n, m, limit, iter+1, space, car)
		}
		// 空白を移動. 
		for nei in neighbors(space) {
			if nei.0 == pos.0 && nei.1 == pos.1 {
				return Status(n, m, limit, iter+1, car, pos)
			}
		}
		return nil
	}
    var hashValue : Int {
        get {
            return "car(\(car.x),\(car.y)):space(\(space.x),\(space.y))".hashValue
        }
    }
}
func == (lhs: Status, rhs: Status) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
func == (lhs: (Int, Int), rhs: (Int, Int)) -> Bool {
    return lhs.0 == rhs.0 && lhs.1 == rhs.1
}

var memo: [Status: Int] = Dictionary()
func depthSearch(var s: Status) -> Int {
	if let m = memo[s] {
		return s.iter + m
	}
	if s.isGoal() {
		return s.iter
	}
	var min = s.limit
	for m in s.movables() {
		if let next = s.move(m) {
			let value = depthSearch(next)
			if value < min {
				min = value
			}
		}
		if min != s.limit {
			s.setLimit(min)
		}
	}
	return min
}

let n = 10
let m = 10
let s = Status(n, m, 100)
let c = depthSearch(s)
print(c)
