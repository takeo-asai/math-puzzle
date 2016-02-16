struct Club: Hashable {
	let name: String
	let space: Int
	let n: Int
	init(name: String, space: Int, n: Int) {
		self.name = name
		self.space = space
		self.n = n
	}
	var hashValue: Int {
        get {
            return "\(name),\(space),\(n)".hashValue
        }
    }
}
func == (lhs: Club, rhs: Club) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

let clubs = [Club(name: "野球", space: 11000, n: 40),
			Club(name: "サッカー", space: 8000, n: 30),
			Club(name: "バレーボール", space: 400, n: 24),
			Club(name: "バスケットボール", space: 800, n: 20),
			Club(name: "テニス", space: 900, n: 14),
			Club(name: "陸上", space: 1800, n: 16),
			Club(name: "ハンドボール", space: 1000, n: 15),
			Club(name: "ラグビー", space: 7000, n: 40),
			Club(name: "卓球", space: 100, n: 10),
			Club(name: "バドミントン", space: 300, n: 12)]

func sumN(clubs: [Club]) -> Int {
	return clubs.reduce(0) {$0+$1.n}
}
func sumSpace(clubs: [Club]) -> Int {
	return clubs.reduce(0) {$0+$1.space}
}


var dp: [Int: [Club]] = [0: []]
for club in clubs {
	for key in dp.keys {
		if let a = dp[key+club.n] {
			if sumSpace(a) < sumSpace(dp[key]! + [club]) {
				dp[key+club.n] = dp[key]! + [club]
			}
		} else {
			dp[key+club.n] = dp[key]! + [club]
		}
	}
}

var max = 0
var cs: [Club] = []
let filtered = dp.filter { (key: Int, value: [Club]) -> Bool in key <= 150}
for d in filtered {
	if max < sumSpace(d.1) {
		max = sumSpace(d.1)
		cs = d.1
	}
}
print(max)
print(cs)
