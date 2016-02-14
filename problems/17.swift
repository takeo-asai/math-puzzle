// this is fib

// a_n; n人並んでいて右端が男
// b_n: n人並んでいて右端が女
// a_n+1 = a_n + b_n
// b_n+1 = a_n
// a_n+2 = a_n+1 + a_n

func fib(n: Int) -> Int {
	if n == 2 {
		return 2
	}
	if n == 1 {
		return 1
	}
	return fib(n-1) + fib(n-2)
}

let n = 30

print(fib(n) + fib(n-1))
