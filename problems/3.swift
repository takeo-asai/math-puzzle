struct Card {
	var status: Bool
	var index: Int?
	init() {
		status = false
	}
	mutating func reverse() -> Void {
		status = !status
	}
}

var cards: [Card] = Array(count: 100, repeatedValue: Card())
cards = cards.enumerate().map {(i, var card) in
	card.index = i
	return card
}
for n in 2 ... cards.count {
	cards = cards.enumerate().map { (i, var card) in
		if i % n == n - 1 {
			card.reverse()
		}
		return card
	}
}

cards = cards.filter { card in !card.status }
print(cards.flatMap{$0.index})

// i*n -1
