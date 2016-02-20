let digitPatterns = [0: [1, 1, 1, 1, 1, 1, 0],
                    1: [0, 1, 1, 0, 0, 0, 0],
                    2: [1, 1, 0, 1, 1, 0, 1],
                    3: [1, 1, 1, 1, 0, 0, 1],
                    4: [0, 1, 1, 0, 0, 1, 1],
                    5: [1, 0, 1, 1, 0, 1, 1],
                    6: [1, 0, 1, 1, 1, 1, 1],
                    7: [1, 1, 1, 0, 0, 0, 0],
                    8: [1, 1, 1, 1, 1, 1, 1],
                    9: [1, 1, 1, 1, 0, 1, 1]]
let digits: [Int] = Array(digitPatterns.keys)
let INT_MAX = 99999

var distances: [[Int?]] = Array(count: digits.count, repeatedValue: Array(count: digits.count, repeatedValue: nil))
func countSwitches(i i: Int, j: Int) -> Int {
  if let v = distances[i][j] {
    return v
  }
  let comb = zip(digitPatterns[i]!, digitPatterns[j]!)
  distances[i][j] = comb.reduce(0) {$0! + abs($1.0-$1.1)}
  return distances[i][j]!
}

func - (lhs: [Int], rhs: [Int]) -> [Int] {
  var hs = lhs
  for v in rhs {
    if let idx = hs.indexOf(v) {
      hs.removeAtIndex(idx)
    }
  }
  return hs
}

func search(present: Int, log: [Int], limit: Int) -> Int {
  if limit < 0 {
    return INT_MAX
  }
  let rests = (digits - log)
  if rests.isEmpty {
    return 0
  }
  var min = limit
  for next in rests {
    let c = countSwitches(i: present, j: next)
    let v = c + search(next, log: log+[present], limit: min-c)
    if min > v {
      min = v
    }
  }

  return min
}

var min = INT_MAX
for first in digits {
  let v = search(first, log: [], limit: min)
  if min > v {
    min = v
  }
}
print(min)
