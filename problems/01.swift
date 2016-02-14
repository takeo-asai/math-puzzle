struct Question1 {
	let value: Int
	let bases = [2, 8, 10]
	init(_ v: Int) {
		value = v
	}
	func radix(n: Int) -> String {
		return String(value, radix: n)
	}
	func isPalindrome(n: Int) -> Bool {
		return String(radix(n).characters.reverse()) == radix(n)
	}
	func palindromes() -> [Int] {
		var pals: [Int] = []
		for n in bases {
			if isPalindrome(n) {
				pals.append(n)
			}
		}
		return pals
	}
	func palindromedALL() -> Bool {
		return palindromes().count == bases.count
	}
}

for i in 10 ..< 1000 {
	if Question1(i).palindromedALL() {
		print("- \(i):")
		print("\t \(Question1(i).radix(2))[2]")
		print("\t \(Question1(i).radix(8))[8]")
	}
}
