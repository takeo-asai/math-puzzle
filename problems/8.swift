enum RobotMove {
	case Forward
	case Left
	case Right
	case Back
	func move() -> (x: Int, y: Int) {
		switch self {
		case .Forward:
			return (0, +1)
		case .Back:
			return (0, -1)
		case .Left:
			return (-1, 0)
		case .Right:
			return (+1, 0)
		}
	}
}
let Moves: [RobotMove] = [.Forward, .Back, .Left, .Right]

struct Robot {
	var n: Int
	var log: [[Bool]]
	var pos: (x: Int, y: Int)
	init(_ i: Int) {
		n = i
		log = Array(count:2*n+1, repeatedValue: Array(count: 2*n+1, repeatedValue: false))
		log[n][n] = true
		pos = (n, n)
	}
	init(count: Int, logs: [[Bool]], position: (Int, Int)) {
		n = count
		log = logs
		pos = position
	}
	func isStopped() -> Bool {
		return n <= 0
	}
	func isMovable(x: Int, _ y: Int) -> Bool {
		if isStopped() {
			return false
		}
		return !log[x][y]
	}
	func move(m: RobotMove) -> Robot? {
		let x = pos.x + m.move().x
		let y = pos.y + m.move().y
		var z = log
		var m = n
		if isMovable(x, y) {
			z[x][y] = true
			m--
			return Robot(count: m, logs: z, position: (x, y))
		}
		return nil
	}
}


func search(robot: Robot) -> [Robot] {
	if robot.isStopped() {
		return [robot]
	}

	var robots: [Robot] = []
	for m in Moves {
		if let r = robot.move(m) {
			robots += search(r)
		}
	}
	return robots
}

let n = 12
print(search(Robot(n)).count)
