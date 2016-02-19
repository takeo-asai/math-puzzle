enum Piece {
  case 角
  case 飛
}

struct Board {
  let n: Int
  let 角: (x: Int, y: Int)
  let 飛: (x: Int, y: Int)
  var values: [[Bool]]
  init(n: Int, 角: (Int, Int), 飛:(Int, Int)) {
      self.n = n
      self.角 = 角
      self.飛 = 飛
      self.values = Array(count:n, repeatedValue: Array(count: n, repeatedValue: false))
      setRegion()
  }
  mutating func setValue(p: (x: Int, y: Int), _ v: Bool) {
    values[p.x][p.y] = v
  }
  func isValidRegion(p: (x: Int, y: Int), opponent: (x: Int, y: Int)) -> Bool {
    if p.x < 0 || p.x >= n || p.y < 0 || p.y >= n {
      return false
    }
    if opponent.x == p.x && opponent.y == p.y {
      return false
    }
    return true
  }
  mutating func setRegion(p: (x: Int, y: Int), _ d: (x: Int, y: Int), piece: Piece) {
    let opponent: (Int, Int)
    switch piece {
      case .角:
        opponent = 飛
      case .飛:
        opponent = 角
    }
    if !isValidRegion(p, opponent: opponent) {
      return
    }
    setValue((p.x, p.y), true)
    return setRegion((p.x+d.x, p.y+d.y), (d.x, d.y), piece: piece)
  }
  mutating func setRegion() {
    if 角.x == 飛.x && 飛.y == 角.y {
      return
    }
    let ds角: [(x: Int, y: Int)] = [(1, 1), (1, -1), (-1, 1), (-1, -1)]
    let ds飛: [(x: Int, y: Int)] = [(1, 0), (-1, 0), (0, 1), (0, -1)]
    for d in ds角 {
      setRegion((角.x+d.x, 角.y+d.y), (d.x, d.y), piece: .角)
    }
    for d in ds飛 {
      setRegion((飛.x+d.x, 飛.y+d.y), (d.x, d.y), piece: .飛)
    }
  }
  func count() -> Int {
    var count = 0
    for v in values {
      count += v.reduce(0) {$0 + ($1 ? 1 : 0)}
    }
    return count
  }
}

var count = 0
let n: Int = 9
for i in 0 ..< n {
  for j in 0 ..< n {
    for k in 0 ..< n {
      for l in 0 ..< n {
        count += Board(n: n, 角: (i, j), 飛: (k, l)).count()
      }
    }
  }
}
print(count)
