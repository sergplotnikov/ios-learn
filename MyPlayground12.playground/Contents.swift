import UIKit

var v1 : Int? = nil
v1 = 10
var v2: String? = nil
v2 = "test"

if let v3 = v2 {
    print("letter counts = \(v3.count)")
} else {
    print("nil")
}
//print(v3)

func greet (_ name: String?){
    guard let unw = name else {
        print("Provide a name!")
        return
    }
    print("Hello, \(unw)")
}

greet(nil)

var str: String
str = "5"
 
let num = Int(str)!
func f1 (_ p1: Int) -> String? {
    if p1 == 1 {
        return "one"
    }
    else {return nil}
}

let t1 = f1(10) ?? "zero"

let n1 = ["a","b","c","d"]
let n = [String]()
let str1 = n.first?.uppercased()

enum PError:Error  {
    case obvious
}

func chkp(_ pwd: String) throws -> Bool {
    if pwd == "1" {
        throw PError.obvious
    }
    return true
}

var res: Bool

do { try
    res=chkp("1")
    print("OK!")
    print(res)
} catch {
    print("FAIL!")
}

if let res = try? chkp("1"){
    print("res=\(res)")
} else {
    print("NOT OK")
}

try? chkp("1")
print("OK!!")


class cl1 {}
class cl2: cl1 {}
class cl3: cl1 {
    func f1() {
        print("it's class 3")
    }
}

let a = [cl2(), cl3(), cl2(), cl3(), cl2(), cl3()]

for b in a {
    if let c = b as? cl3 {
        c.f1();
    }
}

