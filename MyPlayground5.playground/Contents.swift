import UIKit

struct struct1 {
    var fld1: String = "no value"
    var flag: Bool = false
    var res: String {
        if flag {
            return "flag is \(flag) for fld1=\(fld1)"
        }
        else {
            return "as opposit, flag is \(flag) for fld1=\(fld1)"
        }
    }
    var amount: Int = 0 {
    didSet {
        print("amount has changed: now it's \(amount)")
           }
    }
    mutating func increaseAmount() -> Int {
        amount+=110
        return amount
    }
}

var s = struct1(fld1: "one")
print(s.fld1)
print(s.res)

s.fld1="one 1"
print(s.fld1)
print(s.res)
s.flag=true
print(s.fld1)
print(s.res)
var s2 = struct1()
print(s2.fld1)
s2.amount=10
print(s2.amount)
s2.increaseAmount()


