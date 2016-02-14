enum Game {
	case Win
	case Lose
}
// (Int, Int)はDictionaryに使えない. 一度何かしら変換が必要
struct Status: Hashable {
	let coin: Int
	let game: Int
	init(_ c: Int, _ g: Int) {
		coin = c
		game = g
	}
	var hashValue: Int {
		return String("\(coin),\(game)").hashValue
	}
}
func == (lhs: Status, rhs: Status) -> Bool {
	return lhs.coin == rhs.coin && lhs.game == rhs.game
}

let games: [Game] = [.Win, .Lose]
var memo: [Status: Int] = Dictionary()
func blackjack(coin: Int, _ game: Int) -> Int {
	if let m = memo[Status(coin, game)] {
		return m
	}
	if game == 0 {
		return 1
	}
	if coin == 0 {
		return 0
	}
	var count = 0
	for g in games {
		switch g {
		case .Win:
			count += blackjack(coin+1, game-1)
		case .Lose:
			count += blackjack(coin-1, game-1)
		}
	}
	memo[Status(coin, game)] = count
	return count
}

let c = blackjack(10, 24)

print(c)
