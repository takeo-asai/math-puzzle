enum Tap: String {
  case Plug2
  case Plug3
  case Other
}
let taps: [Tap] = [.Plug2, .Plug3, .Other]

func combination<T>(n: Int, _ array: [T]) -> [[T]] {
  if n == 1 {
    return array.map { e -> [T] in [e] }
  }
  if n == array.count {
    return [array]
  }
  var taps: [[T]] = []
  if let f = array.first {
    let drop = Array(array.dropFirst())
    taps += combination(n-1, drop).map {[f]+$0}
    taps += combination(n, drop)
  }
  return taps
}
func repeatedCombination<T>(n: Int, _ array: [T]) -> [[T]] {
  if n == 1 {
    return array.map { e -> [T] in [e] }
  }
  var taps: [[T]] = []
  if let f = array.first {
    let drop = Array(array.dropFirst())
    taps += repeatedCombination(n-1, array).map {[f]+$0}
    taps += repeatedCombination(n, drop)
  }
  return taps
}

func hash(n: Int, _ t: Tap) -> String {
  return String("\(n):\(t.rawValue)")
}
var memo: [String: Int] = Dictionary()
func depthSearch(n: Int, _ t: Tap) -> Int {
  if let m = memo[hash(n, t)] {
    return m
  }
  var count = 0
  switch t {
    case .Plug2:
      let comb = repeatedCombination(2, taps)
      for i in 1 ..< n {
        for c in comb {
          count += depthSearch(i, c[0]) * depthSearch(n-i, c[1])
        }
      }
    case .Plug3:
      let comb = repeatedCombination(3, taps)
      for i in 1 ..< n {
        for j in 1 ..< n-i {
          for c in comb {
            count += depthSearch(i, c[0]) * depthSearch(j, c[1]) * depthSearch(n-i-j, c[2])
          }
        }
      }
    case .Other:
      return n == 1 ? 1 : 0
  }
  memo[hash(n, t)] = count

  return count
}

let n = 4
let d2 = depthSearch(n, .Plug2)
let d3 = depthSearch(n, .Plug3)
print(d2+d3)


do {
  assert(true, "Test")
}
