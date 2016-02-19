struct Status {
  let n: Int
  let A: (x: Int, y: Int)
  let B: (x: Int, y: Int)
  let log: [Status]
  init(n: Int, A: (Int, Int), B: (Int, Int), log: [Status]) {
    self.n = n
    self.A = A
    self.B = B
    self.log = log
  }
  func isGoal() -> Bool {
    return B.x == 0 && B.y == 0 && A.x == n && A.y == n
  }
  func isFortune() -> Bool {
    let fValue: Int
    fValue = countFortune() + log.reduce(0) {$0 + $1.countFortune()}
    return fValue >= 2
  }
  func countFortune() -> Int {
    var count = 0
    count += A.x == B.x ? 1 : 0
    count += A.y == B.y ? 1 : 0
    return count
  }
  func isValidMove(m: (x: Int, y: Int)) -> Bool {
    return m.x >= 0 && m.x <= n && m.y >= 0 && m.y <= n
  }
  func move(moveA moveA: (x: Int, y: Int), moveB: (x: Int, y: Int)) -> Status? {
    let nextA: (x: Int, y: Int) = (A.x+moveA.x, A.y+moveA.y)
    let nextB: (x: Int, y: Int) = (B.x+moveB.x, B.y+moveB.y)
    if !isValidMove(nextA) || !isValidMove(nextB) {
      return nil
    }
    return Status(n: n, A: nextA, B: nextB, log: log+[self])
  }
}

let moveAs = [(1, 0), (0, 1)]
let moveBs = [(-1, 0), (0, -1)]
func depthSearch(s: Status) -> Int {
  if s.isGoal() && s.isFortune() {
    return 1
  }
  var count = 0
  for moveA in moveAs {
    for moveB in moveBs {
      if let next = s.move(moveA: moveA, moveB: moveB) {
        count += depthSearch(next)
      }
    }
  }
  return count
}

let n = 6
let s = Status(n: n, A: (0, 0), B: (n, n), log: [])
let c = depthSearch(s)
print(c)
// 527552
