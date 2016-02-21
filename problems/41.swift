func addZeroBy(s: String, n: Int) -> String {
  var str = s
  while str.characters.count < n {
    str = "0" + str
  }
  return str
}
func divideInt(n: Int) -> [Int] {
  if n == 0 {
    return [0]
  }
  var x = n
  var ds: [Int] = []
  while x != 0 {
    ds += [x % 10]
    x = x / 10
  }
  return ds
}
func isUnique(array: [Int]) -> Bool {
  if let f = array.first {
    let drops = array.dropFirst()
    if drops.contains(f) {
      return false
    }
    return isUnique(Array(drops))
  }
  return true
}
func pairs(n: Int) -> (Int, Int)? {
  let str = addZeroBy(String(n, radix: 2), n: 8)
  let rev = Int(String(str.characters.reverse()), radix: 2) ?? 0
  if isUnique(divideInt(n) + divideInt(rev)) {
    return (n, rev)
  }
  return nil
}
func - (lhs: [Int], rhs: [Int]) -> [Int] {
  var hs = lhs
  for r in rhs {
    if let idx = hs.indexOf(r) {
      hs.removeAtIndex(idx)
    }
  }
  return hs
}
let numbers = Array((0 ... 9))
func IPPairs(pairs: [(Int, Int)]) -> [(Int, Int, Int, Int)] {
  var ps: [(Int, Int, Int, Int)] = []
  for (x0, y0) in pairs {
    for (x1, y1) in pairs {
      let divides: [Int] = divideInt(x0) + divideInt(y0) + divideInt(x1) + divideInt(y1)
      if numbers - divides == [] {
        ps += [(x0, x1, y1, y0)]
      }
    }
  }
  return ps
}

let ps = (0 ... 255).flatMap {pairs($0)}
let ans = IPPairs(ps)
print(ans)
