func * (lhs: [Int], var rhs: Int) -> [Int] {
  var next: [Int] = []
  while rhs > 0 {
    next += lhs
    rhs -= 1
  }
  return next
}

class BinaryTree {
  var value: Int
  var R: BinaryTree?
  var L: BinaryTree?
  var parent: BinaryTree?
  var count: Int

  init(_ v: Int, _ p: BinaryTree? = nil) {
    self.value = v
    self.count = 1
    self.parent = p
  }
  func insert(n: Int) {
    if n < self.value {
      if let l = self.L {
        l.insert(n)
      } else {
        self.L = BinaryTree(n, self)
      }
    } else if n == self.value {
      self.count += 1
    } else {
      if let r = self.R {
        r.insert(n)
      } else {
        self.R = BinaryTree(n, self)
      }
    }
  }
  func contains(n: Int) -> Bool {
    if n < self.value {
      if let l = self.L {
        return l.contains(n)
      }
    } else if n == self.value {
      return self.count > 0
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
  func maximum() -> BinaryTree {
    if let r = self.R {
      return r.maximum()
    }
    return self
  }
  func replace(tree: BinaryTree, with: BinaryTree?) {
    if tree.value == self.R?.value {
      self.R = with
      with?.parent = self.R
    } else if tree.value == self.L?.value {
      self.L = with
      with?.parent = self.L
    }
    tree.parent = nil
  }
  func remove(n: Int) {
    if n < self.value {
      if let l = self.L {
        l.remove(n)
      }
    } else if n == self.value {
      self.count -= 1
      if self.count == 0 {
        if let l = self.L, _ = self.R { // both
          let maxValue = l.maximum().value
          self.value = maxValue
          self.count = 1
          l.remove(maxValue)
        } else if let l = self.L { // L only
          self.parent?.replace(self, with: l)
        } else if let r = self.R { // R only
          self.parent?.replace(self, with: r)
        } else {
          self.parent?.replace(self, with: nil)
        }
      }
    } else {
      if let r = self.R {
        r.remove(n)
      }
    }
  }
}
