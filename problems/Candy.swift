func * (lhs: [Int], var rhs: Int) -> [Int] {
  var next: [Int] = []
  while rhs > 0 {
    next += lhs
    rhs -= 1
  }
  return next
}

class Candy {
  var value: Int
  var R: Candy?
  var L: Candy?
  var count: Int

  init(_ v: Int) {
    self.value = v
    self.count = 1
  }
  func insert(n: Int) {
    if n < self.value {
      if let l = self.L {
        l.insert(n)
      } else {
        self.L = Candy(n)
      }
    } else if n == self.value {
      self.count += 1
    } else {
      if let r = self.R {
        r.insert(n)
      } else {
        self.R = Candy(n)
      }
    }
  }
  func contains(n: Int) -> Bool {
    if n < self.value {
      if let l = self.L {
        return l.contains(n)
      }
    } else if n == self.value {
      return true
    } else {
      if let r = self.R {
        return r.contains(n)
      }
    }
    return false
  }
  func list(n: Int) -> [Int] {
    let left = self.L != nil ? self.L!.list(n) : []
    if n > self.value {
      let right = self.R != nil ? self.R!.list(n) : []
      return left + ([self.value] * self.count) + right
    } else if n == self.value {
      return left + ([self.value] * self.count)
    } else {
      return left
    }
  }
  func remove(n: Int) {
    if self.contains(n) {

    }
  }
}

var c = Candy(10)
c.insert(16)
c.insert(19)
c.insert(16)
c.insert(6)


print(c.list(59))
print(c.list(17))
