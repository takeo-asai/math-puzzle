import Foundation

let countries: [String] = [	"Brazil", "Croatia", "Mexico", "Cameroon", "Spain", "Netherlands", "Chile", "Australia",
						"Colombia", "Greece", "Cote d'lvoire", "Japan", "Uruguay", "Costa Rica", "England",
						"Italy", "Switzerland", "Ecuador", "France", "Honduras", "Argentina", "Bosnia and Herzegovina",
						"Iran", "Negeria", "Germany", "Portugal", "Ghana", "USA", "Belgium", "Algeria", "Russia", "Korea Republic"].map {$0.uppercaseString}

func wordChainGraph(words: [String]) -> [String: [String]] {
	var graph: [String: [String]] = Dictionary<String, [String]>()
	for w in words {
		let last = w.characters.last
		var edges: [String] = []
		for z in words {
			if w != z {
				let first = z.characters.first
				if first == last {
					edges.append(z)
				}
			}
		}
		graph[w] = edges
	}
	return graph
}

func depthSearch(present: String, log: [String], graph: [String: [String]]) -> [[String]] {
	guard let e = graph[present] else {
		return [log]
	}
	var chain: [[String]] = []
	for next in e {
		if !log.contains(next) {
			chain += depthSearch(next, log: log+[present], graph: graph)
		}
	}
	return chain.count > 0 ? chain : [log+[present]]
}

var max = 0
var chain: [String] = []
let g = wordChainGraph(countries)
for s in countries {
	let c = depthSearch(s, log: [], graph: g).map { ($0, $0.count) }.sort { $0.1 > $1.1 }.first!
	if c.1 > max {
		max = c.1
		chain = c.0
	}
}
print(chain)
