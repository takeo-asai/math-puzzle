struct Container {
  var currentValue: Int
  let maximumValue: Int
  init(current: Int, max: Int) {
    self.currentValue = current
    self.maximumValue = max
  }
  mutating func pour(inout cont: Container) {
    let x = cont.currentValue + self.currentValue
    if x > cont.maximumValue {
      self.currentValue = self.currentValue - (cont.maximumValue - cont.currentValue)
      cont.currentValue = cont.maximumValue
    } else {
      self.currentValue = 0
      cont.currentValue = x
    }
  }
}
struct Status: Hashable {
  let containers: [Container]
  init(_ g:(a: Int, b: Int, c: Int)) {
    self.containers = [Container(current: g.a, max: g.a), Container(current: 0, max: g.b), Container(current: 0, max: g.c)]
  }
  init(containers: [Container]) {
    self.containers = containers
  }
  func pour(from from: Int, to: Int) -> Status {
    var conts = self.containers
    conts[from].pour(&conts[to])
    return Status(containers: conts)
  }
  func isFinished() -> Bool {
    return containers[0].currentValue == containers[0].maximumValue / 2
  }
  func depth() -> Int? {
    func searchAndCheck(s: Status, depth: Int, inout cache: [Status: Int]) -> [Status] {
      var statuses: [Status] = []
      let cases: [(Int, Int)] = [(0, 1), (0, 2), (1, 0), (1, 2), (2, 0), (2, 1)]
      for c in cases {
        let next: Status = s.pour(from: c.0, to: c.1)
        if let _ = cache[next] {
        } else {
          cache[next] = depth+1
          statuses += [next]
        }
      }
      return statuses
    }
    var d = 0
    var cache: [Status: Int] = [self: 0]
    var presents: [Status] = [self]
    while !presents.isEmpty {
      var nexts: [Status] = []
      for p in presents {
        if p.isFinished() {
          return d
        }
        nexts += searchAndCheck(p, depth: d, cache: &cache)
      }
      d += 1
      presents = nexts
    }
    return nil
  }
  var hashValue: Int {
    get {
      return containers.description.hashValue
    }
  }
}
func == (lhs: Status, rhs: Status) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

func primeGroups(a: Int) -> [(Int, Int, Int)] {
  func gcd(a: Int, _ b: Int) -> Int {
    let x = a > b ? a : b
    let y = a > b ? b : a
    return x%y == 0 ? y : gcd(y, x%y)
  }
  var groups: [(Int, Int, Int)] = []
  for c in 1 ..< a/2 {
    let b = a - c
    if gcd(b, c) == 1 {
      groups += [(a, b, c)]
    }
  }
  return groups
}

var count = 0
for n in 10/2 ... 100/2 {
  for g in primeGroups(2*n) {
    if let _ = Status(g).depth() {
      count += 1
    }
  }
}
print("count: \(count)")
