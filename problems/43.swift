struct Cards: Hashable {
  let cards: [Int]
  let n: Int
  init(_ n: Int, _ cards: [Int]) {
    self.n = n
    self.cards = cards
  }
  func isGoal() -> Bool {
    return self.cards == Array((1...2*n)).reverse()
  }
  func shuffle(i: Int) -> Cards {
    let shuffled: [Int] = Array(cards[i..<n+i] + cards[0..<i] + cards[n+i..<2*n])
    return Cards(n, shuffled)
  }
  var hashValue: Int {
    get {
      return self.cards.description.hashValue
    }
  }
}
func == (lhs: Cards, rhs: Cards) -> Bool {
  return lhs.hashValue == rhs.hashValue
}

let n = 5

var cache: [Cards: Int] = [Cards(n, Array((1...2*n))): 0]
func searchAndCheck(n: Int, cards: Cards, depth: Int) -> [Cards] {
  var nexts: [Cards] = []
  for i in 1 ... n {
    let next = cards.shuffle(i)
    if let _ = cache[next] {
    } else {
      cache[next] = depth
      nexts += [next]
    }
  }
  return nexts
}

var depth = 1
var presents = [Cards(n, Array((1...2*n)))]
loop: while !presents.isEmpty {
  var nexts: [Cards] = []
  for present in presents {
    if present.isGoal() {
      break loop
    }
    nexts += searchAndCheck(n, cards: present, depth: depth)
  }
  depth = depth + 1
  presents = nexts
}
print("depth: \(depth)")
