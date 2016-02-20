let N = 4
let INT_MAX = 99999
struct Board: Hashable {
  // 4x4
  var values: [[Bool]] = Array(count: N, repeatedValue: Array(count: N, repeatedValue: false))
  init(_ vs: [[Bool]]? = nil) {
    if let ws = vs {
      values = ws
    }
  }
  func isValidPosition(p: (x: Int, y: Int)) -> Bool {
    return p.x >= 0 && p.x < N && p.y >= 0 && p.y < N
  }
  private mutating func reversePosition(p: (x: Int, y: Int)) {
    values[p.x][p.y] = !values[p.x][p.y]
  }
  private mutating func reverseLine(p: (x: Int, y: Int), d: (x: Int, y: Int)) {
    if isValidPosition(p) {
      reversePosition(p)
      return reverseLine((p.x+d.x, p.y+d.y), d: d)
    }
  }
  mutating func reverse(p: (x: Int, y: Int)) {
    let ds: [(x: Int, y: Int)] = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    for d in ds {
      reverseLine((p.x+d.x, p.y+d.y), d: d)
    }
    reversePosition(p)
  }
  func isGoal() -> Bool {
    for xs in values {
      for x in xs {
        if !x {
          return false
        }
      }
    }
    return true
  }
  var hashValue: Int {
    get {
      return values.description.hashValue
    }
  }
}
func == (lhs: Board, rhs: Board) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

var memo: [Board: Int] = [: ]
func searchAndCheck(b: Board, depth: Int) -> [Board] {
  var nexts: [Board] = []
  for x in 0 ..< N {
    for y in 0 ..< N {
      var nextB = b
      nextB.reverse((x, y))
      if let _ = memo[nextB] {
      } else {
        memo[nextB] = depth
        nexts += [nextB]
      }
    }
  }
  return nexts
}

let b = Board([[true, true, true, true],
  [true, true, true, true],
  [true, true, true, true],
  [true, true, true, true]])

var depth = 0
var presents = searchAndCheck(b, depth: 0)
while !presents.isEmpty {
  var nexts: [Board] = []
  depth = depth + 1
  for p in presents {
    nexts += searchAndCheck(p, depth: depth)
  }
  presents = nexts
}
print(depth)
