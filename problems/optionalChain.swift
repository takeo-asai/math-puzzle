class List<Element> {
  var v: Element?
  var next: List<Element>?
  init(_ v: Element, next: List? = nil) {
    self.v = v
    self.next = next
  }
  var value: Element? {
    get {
      return self.v
    }
    set(x) {
      print("setter called")
      self.v = x
    }
  }
}

let c = List(2)
let b = List(1, next: c)
let a = List(0, next: b)

a.value = 33

print(a.value)
print(b.value)
print(c.value)

c.next?.value = 200
// => c.next?.setValue(200)

print(a.value)
print(b.value)
print(c.value)
print(c.next?.value)
