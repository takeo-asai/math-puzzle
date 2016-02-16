/*

0 - 3
3 - 1 は交差する

0 - 3
1 - 3 はしない

i - j
i+a - j-b はする(a, b > 0)

start: 左上
end: 右上
*/
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



func isCrossed(x: (Int, Int), _ y: (Int, Int)) -> Bool {
	let a = x.0 > y.0 ? x : y
	let b = x.0 > y.0 ? y : x

	return a.0 > b.0 && a.1 < b.1
}
func edgesFromTour(tour: [Int]) -> [(Int, Int)] {
	var edges: [(Int, Int)] = []
	var rest = tour + [0]

	var present = 0
	while let next = rest.first {
		edges.append((present, next))
		present = next
		rest.removeAtIndex(0)
	}

	return edges
}
func countCrossed(edges: [(Int, Int)]) -> Int {
	var count = 0
	var e = edges
	while let e0 = e.first {
		e.removeAtIndex(0)
		for e1 in e {
			if isCrossed(e0, e1) {
				count++
			}
		}
	}
	return count
}

let n = 6
var positions: [Int] = []
positions += (1 ... n).map {$0}
positions += (1 ... n).map {$0}
// n = 5 ,45

var max = 0
var maxEdges: [(Int, Int)] = []
for tour in positions.permutation(positions.count) {
	let edges = edgesFromTour(tour)
	let count = countCrossed(edges)
	if max < count {
		max = count
		maxEdges = edges
	}
}
print(max)
print(maxEdges)

do {
	assert(true, "assert check")

	assert(isCrossed((1, 0), (0, 1)))
	assert(isCrossed((0, 1), (1, 0)))
	assert(!isCrossed((0, 1), (0, 4)))
	assert(isCrossed((1, 1), (0, 4)))
}
