import Foundation

let format = NSDateFormatter()
format.dateFormat = "yyyy/MM/dd"

let f = NSDateFormatter()
f.dateFormat = "yyyyMMdd"

// these are not always nil
let before = format.dateFromString("1964/10/10")!
let after =  format.dateFromString("2020/07/24")!

var d: NSDate = before
while after.compare(d) == .OrderedDescending { // d < after
	let dStr = String(Int(f.stringFromDate(d))!, radix: 2)
	let rStr = String(dStr.characters.reverse())
	if dStr == rStr {
		print(format.stringFromDate(d))
	}
	d = d.dateByAddingTimeInterval(60*60*24) // +1 day
}
