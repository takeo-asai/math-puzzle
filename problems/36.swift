func isPalindrome(n: Int) -> Bool {
  let str = String(n)
  return str == String(str.characters.reverse())
}
let array = (1 ... 1000).map {Int(String($0, radix: 2))!*7}

var palindromes: [(Int, Int)] = []
for i in 1 ... 50 {
  if i%2 != 0 && i%5 != 0 {
    for x in array {
      if x%i == 0 {
        if isPalindrome(x) {
          palindromes += [(i, x)]
        }
        break
      }
    }
  }
}
print(palindromes)
