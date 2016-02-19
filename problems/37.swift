func reverseDices(dices: [Int]) -> [Int] {
  func reverseDice(n: Int) -> Int {
    return 7 - n
  }
  let n = dices.first!
  return dices[n ..< dices.count] + dices[0 ..< n].map {reverseDice($0)}
}

func depthSearch(dices: [Int], log: [[Int]]) -> Bool {
  if let f = log.first {
    if dices == f {
      return true
    }
    for l in log {
      if dices == l {
        return false
      }
    }
  }
  return depthSearch(reverseDices(dices), log: log+[dices])
}

func permutation<T>(array: [T], n: Int) -> [[T]] {
  if n == 1 {
    return array.map {[$0]}
  }
  var perm: [[T]] = []
  for x in array {
    perm += permutation(array, n: n-1).map {$0 + [x]}
  }
  return perm
}

var count = 0
let dices = [1, 2, 3, 4, 5, 6]
for d in permutation(dices, n: 6) {
  if !depthSearch(d, log: []) {
    count++
  }
}
print(count)
