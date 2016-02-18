enum Move {
  case Top
  case Down
  case Left
  case Right
}
let moves: [Move] = [.Top, .Down, .Left, .Right]
struct Position: Hashable {
  let x: Int
  let y: Int
  init(_ x: Int, _ y: Int) {
      self.x = x
      self.y = y
  }
  func isGoal() -> Bool {
    return x == 0 && y == 0
  }
  func isMidway(n: Int, m: Int) -> Bool {
    return x == n && y == m
  }
  func move(move: Move, _ n: Int, _ m: Int) -> Position? {
    var a = 0, b = 0
    switch move {
      case .Top:
        b = +1
      case .Down:
        b = -1
      case .Right:
        a = +1
      case .Left:
        a = -1
    }
    if x+a >= 0 && x+a <= n && y+b >= 0 && y+b <= m {
      return Position(x+a, y+b)
    }
    return nil
  }
  func description() -> String {
    return String("(\(x),\(y))")
  }
  var hashValue: Int {
    get {
      return description().hashValue
    }
  }
}
func == (lhs: Position, rhs: Position) -> Bool {
  return lhs.hashValue == rhs.hashValue
}
struct Edge: Hashable {
  let p0: Position
  let p1: Position
  init(_ p0: Position, _ p1: Position) {
    if p0.x != p1.x {
      self.p0 = p0.x > p1.x ? p0 : p1
      self.p1 = p0.x > p1.x ? p1 : p0
    } else {
      self.p0 = p0.y > p1.y ? p0 : p1
      self.p1 = p0.y > p1.y ? p1 : p0
    }
  }
  var hashValue: Int {
    get {
      return (p0.description() + p1.description()).hashValue
    }
  }
  func contains(p: Position) -> Bool {
    return (p.x == p0.x && p.y == p0.y) || (p.x == p1.x && p.y == p1.y)
  }
}
func == (lhs: Edge, rhs: Edge) -> Bool {
  return lhs.hashValue == rhs.hashValue
}


func depthSearch(present: Position, log: [Edge], n: Int, m: Int) -> Int {
  if log.count >= (n+m) {
    let e = log[m+n-1]
    if !e.contains(Position(n, m)) || log.count > 2*(m+n) { // half point
      return 0
    } else if present.isGoal() {
      return 1
    }
  }

  var count = 0
  for move in moves {
    if let next = present.move(move, n, m) {
      let e = Edge(present, next)
      if !log.contains(e) {
        count += depthSearch(next, log: log+[e], n: n, m: m)
      }
    }
  }
  return count
}

let n = 6
// 2, 2 => 10
// 6, 6 => 100360: 5311.536sec too slowly
let c = depthSearch(Position(0, 0), log: [], n: n, m: n)
print(c)
