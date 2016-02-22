// 群論的
func q46(n: Int) -> Int {
  return n > 1 ? (n-1)*(1..<n).reduce(1, combine: *)+n*q46(n-1) : 0
}
print(q46(7))

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

func countExchange(var array: [Int]) -> Int {
  var count = 0
  for i in 1 ... array.count {
    let idx = array.indexOf(i)! // array must have 0 ... n-1
    if i-1 != idx {
      let tmp = array[idx]
      array[idx] = array[i-1]
      array[i-1] = tmp
      count += 1
    }
  }
  return count
}

var totalCount = 0
for a in Array((1 ... 7)).permutation(7) {
  totalCount += countExchange(a)
}
print(totalCount)
