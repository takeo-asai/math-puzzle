enum Expr {
	case Value(Int)
	case Plus
	case Minus
	case Multiply
	case Join
	init(_ v: Int) {
		self = .Value(v)
	}
	func function() -> ((a: Int, b: Int) -> Int) {
		switch self {
			case .Value(let x):return {(_, _) in x}
			case .Plus: return {(a, b) in a+b}
			case .Minus: return {(a, b) in b-a}
			case .Multiply: return {(a, b) in a*b}
			case .Join: return {(b, a) in a*10+b}
		}
	}
	func isEqualTo(expr: Expr) -> Bool {
		var s: Int
		var e: Int
		switch self {
			case .Value(_): s = 0
			case .Plus: s = 1
			case .Minus: s = 2
			case .Multiply: s = 3
			case .Join: s = 4
		}
		switch expr {
			case .Value(_): e = 0
			case .Plus: e = 1
			case .Minus: e = 2
			case .Multiply: e = 3
			case .Join: e = 4
		}
		return s == e
	}
	func isPriorTo(expr: Expr) -> Bool {
		switch expr {
		case .Value(_):
			return true
		case .Plus:
			return isEqualTo(.Multiply) || isEqualTo(.Join)
		case .Minus:
			return isEqualTo(.Multiply) || isEqualTo(.Join)
		case .Multiply:
			return isEqualTo(.Join)
		case .Join:
			return false
		}
	}
}
/**
	NSExpressionというのがあるが、独自に定義したもの(今回の**)はダメ
	しかもかなり使いづらいので、逆ポーランド記法の式を計算する
	- parameter expr: 逆ポーランド記法の式. reversePolishで求める
	- returns: [Expr] の計算結果
 */
func calc(expr: [Expr]) -> Int {
	var stack: [Int] = []
	for i in 0 ..< expr.count {
		switch expr[i] {
		case .Plus, .Minus, .Multiply, .Join:
			let a = stack.removeAtIndex(0)
			let b = stack.removeAtIndex(0)
			stack.insert(expr[i].function()(a:a, b:b), atIndex:0)
		case .Value(let v):
			stack.insert(v, atIndex:0)
		}
	}
	return stack[0]
}

func reversePolish(expr: [Expr]) -> [Expr] {
	var stack: [Expr] = []
	var polished: [Expr] = []
	for i in 0 ..< expr.count {
		switch expr[i] {
		case .Value(_):
			polished.append(expr[i])
		default:
			if stack.isEmpty {
				stack.insert(expr[i], atIndex:0)
			} else {
				if !expr[i].isPriorTo(stack[0]) {
					// stack[0]がpriorでなくなるまでappend. 後でrewrite
					while stack.count > 0 && !expr[i].isPriorTo(stack[0]) {
						let e = stack.removeAtIndex(0)
						polished.append(e)
					}
					stack.insert(expr[i], atIndex:0)

				} else {
					stack.insert(expr[i], atIndex:0)
				}
			}
		}
	}
	while stack.count > 0 {
		let e = stack.removeAtIndex(0)
		polished.append(e)
	}

	return polished
}



// TEST CASES
infix operator ** { associativity left precedence 160 } // * の優先度150
func ** (left: Int, right: Int) -> Int {
	return left*10 + right
}
func operate(left: Int)(_ right: Int) -> Int {
	return left ** right
}
do {
	assert(1 + 23 + 4 == 1 + 2 ** 3 + 4, "28")
	assert(1 + 23 * 4 == 1 + 2 ** 3 * 4, "93")
	assert(12 + 34 == 1 ** 2 + 3 ** 4, "46")
	assert(12 * 34 == 1 ** 2 * 3 ** 4, "408")
	assert(123 + 4 == 1 ** 2 ** 3 + 4, "127")
	assert(123 * 4 == 1 ** 2 ** 3 * 4, "492")
}
do {
	let a = reversePolish([Expr(1), .Plus, Expr(2), .Join, Expr(3), .Plus, Expr(4)])
	let b = reversePolish([Expr(1), .Plus, Expr(2), .Join, Expr(3), .Multiply, Expr(4)])
	let c = reversePolish([Expr(1), .Join, Expr(2), .Plus, Expr(3), .Join, Expr(4)])
	let d = reversePolish([Expr(1), .Join, Expr(2), .Multiply, Expr(3), .Join, Expr(4)])
	let e = reversePolish([Expr(1), .Join, Expr(2), .Join, Expr(3), .Plus, Expr(4)])
	let f = reversePolish([Expr(1), .Join, Expr(2), .Join, Expr(3), .Multiply, Expr(4)])
	assert(calc(a) == 1 + 23 + 4)
	assert(calc(b) == 1 + 23 * 4)
	assert(calc(c) == 12 + 34)
	assert(calc(d) == 12 * 34)
	assert(calc(e) == 123 + 4)
	assert(calc(f) == 123 * 4)
}
