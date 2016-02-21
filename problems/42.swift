extension Array {
	//  ExSwift
	//
	//  Created by pNre on 03/06/14.
	//  Copyright (c) 2014 pNre. All rights reserved.
	//
	//	https://github.com/pNre/ExSwift/blob/master/ExSwift/Array.swift
	//	https://github.com/pNre/ExSwift/blob/master/LICENSE
	/**
        - parameter length: The length of each permutation
        - returns: All permutations of a given length within an array
    */
	func permutation (length: Int) -> [[Element]] {
        if length < 0 || length > self.count {
            return []
        } else if length == 0 {
            return [[]]
        } else {
            var permutations: [[Element]] = []
            let combinations = combination(length)
            for combination in combinations {
                var endArray: [[Element]] = []
                var mutableCombination = combination
                permutations += self.permutationHelper(length, array: &mutableCombination, endArray: &endArray)
            }
            return permutations
        }
    }
    private func permutationHelper(n: Int, inout array: [Element], inout endArray: [[Element]]) -> [[Element]] {
        if n == 1 {
            endArray += [array]
        }
        for var i = 0; i < n; i++ {
            permutationHelper(n - 1, array: &array, endArray: &endArray)
            let j = n % 2 == 0 ? i : 0
            let temp: Element = array[j]
            array[j] = array[n - 1]
            array[n - 1] = temp
        }
        return endArray
    }
    func combination (length: Int) -> [[Element]] {
        if length < 0 || length > self.count {
            return []
        }
        var indexes: [Int] = (0..<length).reduce([]) {$0 + [$1]}
        var combinations: [[Element]] = []
        let offset = self.count - indexes.count
        while true {
            var combination: [Element] = []
            for index in indexes {
                combination.append(self[index])
            }
            combinations.append(combination)
            var i = indexes.count - 1
            while i >= 0 && indexes[i] == i + offset {
                i--
            }
            if i < 0 {
                break
            }
            i++
            let start = indexes[i-1] + 1
            for j in (i-1)..<indexes.count {
                indexes[j] = start + j - i + 1
            }
        }
        return combinations
    }
    /**
		- parameter length: The length of each permutations
        - returns: All of the permutations of this array of a given length, allowing repeats
    */
    func repeatedPermutation(length: Int) -> [[Element]] {
        if length < 1 {
            return []
        }
        var indexes: [[Int]] = []
        indexes.repeatedPermutationHelper([], length: length, arrayLength: self.count, indexes: &indexes)
        return indexes.map({ $0.map({ i in self[i] }) })
    }
    private func repeatedPermutationHelper(seed: [Int], length: Int, arrayLength: Int, inout indexes: [[Int]]) {
        if seed.count == length {
            indexes.append(seed)
            return
        }
        for i in (0..<arrayLength) {
            var newSeed: [Int] = seed
            newSeed.append(i)
            self.repeatedPermutationHelper(newSeed, length: length, arrayLength: arrayLength, indexes: &indexes)
        }
    }
}


enum Expr {
  case Value(Int)
  case Plus
  case Minus
  case Multiply
  case Divide
  case Join
  func isPriorTo(expr: Expr) -> Bool {
    switch expr {
      case .Value(_):
        return true
      case .Plus:
        switch self {
          case .Value(_):
            return true
          default:
            return false
        }
      case .Minus:
        switch self {
          case .Value(_):
            return true
          default:
            return false
        }
      case .Multiply:
        switch self {
          case .Value(_), .Plus, .Minus:
            return true
          default:
            return false
        }
      case .Divide:
        switch self {
          case .Value(_), .Plus, .Minus:
            return true
          default:
            return false
        }
      case .Join:
        switch self {
          case .Value(_), .Plus, .Minus, .Multiply, .Divide:
            return true
          default:
            return false
        }
    }
  }
  func value() -> Int? {
    switch self {
      case .Value(let x):
        return x
      default:
        return nil
    }
  }
  func fun() -> (Int, Int) -> Int {
    switch self {
      case .Value(let x):
        return {_, _ in x}
      case .Plus:
        return {$0+$1}
      case .Minus:
        return {$0-$1}
      case .Multiply:
        return {$0*$1}
      case .Divide:
        return {
          if $1 == 0 {
            return 2147483647
          }
          return $0/$1
        }
      case .Join:
        return {$1*10+$0}
    }
  }
}

func calcReversePolish(var exprs: [Expr]) -> Int? {
  var stack: [Expr] = []
  while !exprs.isEmpty {
    let expr = exprs.removeAtIndex(0)
    switch expr {
      case .Value(_):
        stack.insert(expr, atIndex: 0)
      default:
        let b = calcReversePolish([stack.removeAtIndex(0)])!
        let a = calcReversePolish([stack.removeAtIndex(0)])!
        stack.insert(.Value(expr.fun()(a, b)), atIndex: 0)
    }
  }
  return stack[0].value()
}
func convertToReversePolish(var exprs: [Expr]) -> [Expr] {
  var stack: [Expr] = []
  var results: [Expr] = []
  while !exprs.isEmpty {
    let expr = exprs.removeAtIndex(0)
    switch expr {
      case .Value(_):
        results.append(expr)
      default:
        if stack.count > 0 {
          while stack.count > 0 && expr.isPriorTo(stack[0]) {
            let drop = stack.removeAtIndex(0)
            results.append(drop)
          }
          stack.insert(expr, atIndex: 0)
        } else {
          stack.append(expr)
        }
    }
  }
  while stack.count > 0 {
    let drop = stack.removeAtIndex(0)
    results.append(drop)
  }
  return results
}
/*
let exprs: [Expr] = [.Value(3), .Divide, .Value(5), .Plus, .Value(7)]
//let exprs: [Expr] = [.Value(3), .Plus, .Value(5), .Join, .Value(7)]
let reverse = convertToReversePolish(exprs)
let ans = calcReversePolish(reverse)

let exprs: [Expr] = [.Value(9), .Join, .Value(9), .Join, .Value(9), .Join, .Value(9), .Join, .Value(9)]
let reverse = convertToReversePolish(exprs)
let ans = calcReversePolish(reverse)
print("rev: \(reverse)")
print("ans: \(ans)")
*/

var n = 5
label: while true {
  for x in 0 ... 9 {
    let e: [Expr] = [.Plus, .Minus, .Multiply, .Divide, .Join]
    let xs = Array(count: n-1, repeatedValue: Expr.Value(x))
    for es in e.repeatedPermutation(n-1) {
      let expr = zip(es, xs).reduce([Expr.Value(x)]) {$0+[$1.0]+[$1.1]}
      let reverse = convertToReversePolish(expr)
      let ans = calcReversePolish(reverse)!
      if ans == 1234 {
        print("n = \(n), x = \(x), \(expr)")
        break label
      }
    }
  }
  print("n=\(n), not found")
  n = n + 1
}
