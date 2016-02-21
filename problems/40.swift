// cards.count must be >= 1
struct Cards: Hashable {
  var cards: [Int]
  init(_ cs: [Int]) {
    cards = cs
  }
  mutating func reverse() -> [Int] {
    let n = cards.first!
    cards = cards[0..<n].reverse() + cards[n..<cards.count]
    return cards
  }
  // 戻す. 1枚目がnだとreverse()するとn-1番目にnが来る
  func reReverse() -> [[Int]] {
    var re: [[Int]] = []
    for n in 2 ... cards.count {
      if n == cards[n-1] {
        re += [cards[0..<n].reverse() + cards[n..<cards.count]]
      }
    }
    return re
  }
  private func isNotGoal() -> Bool {
    return cards.first! != 1
  }
  mutating func count() -> Int {
    var count = 0
    while isNotGoal() {
      reverse()
      count = count + 1
    }
    return count
  }
  var hashValue: Int {
    get {
      return cards.description.hashValue
    }
  }
}
func == (lhs: Cards, rhs: Cards) -> Bool {
  return lhs.hashValue == rhs.hashValue
}
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
}
var cache: [Cards: Int] = [: ]
func searchAndCheck(presents: [[Int]], depth: Int) -> [[Int]] {
  var nexts: [[Int]] = []
  for p in presents {
    for re in Cards(p).reReverse() {
      let c = Cards(re)
      if let _ = cache[c] {
      } else {
        cache[c] = depth
        nexts += [re]
      }
    }
  }
  return nexts
}

let n = 9
var maxI: [Int] = []
var maxC = Cards([])
var max = 0
for p in Array((1 ... n)).permutation(n) {
    var c = Cards(p)
  var v = c.count()
  if max < v {
    max = v
    maxC = c
    maxI = p
  }
}
print(max)
print(maxC)
print(maxI)
