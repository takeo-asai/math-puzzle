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

import Foundation

// READ + WRITE + TALK = SKILL
enum Blank {
	case R
	case E
	case A
	case D
	case W
	case I
	case T
	case L
	case K
	case S
}

var count = 0
for a in Array((0 ... 9)).permutation(10) {
	let dict: [Blank: Int] = [.R: a[0], .E: a[1], .A: a[2], .D: a[3], .W: a[4], .I: a[5], .T: a[6], .L: a[7], .K: a[8], .S: a[9]]
	if dict[.R] != 0 && dict[.W] != 0 && dict[.T] != 0 && dict[.S] != 0 {
		var READ = dict[.R]!*1000
		READ += dict[.E]!*100
		READ += dict[.A]!*10
		READ += dict[.D]!
		var WRITE = dict[.W]!*10000
		WRITE += dict[.R]!*1000
		WRITE += dict[.I]!*100
		WRITE += dict[.T]!*10
		WRITE += dict[.E]!
		var TALK = dict[.T]!*1000
		TALK += dict[.A]!*100
		TALK += dict[.L]!*10
		TALK += dict[.K]!
		var SKILL = dict[.S]!*10000
		SKILL += dict[.K]!*1000
		SKILL += dict[.I]!*100
		SKILL += dict[.L]!*11
		if READ + WRITE + TALK == SKILL {
			count++
		}
	}
}
print(count)


