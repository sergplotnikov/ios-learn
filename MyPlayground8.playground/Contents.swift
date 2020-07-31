import UIKit

var str = "Hello, playground"

struct s0 {
    var v1: String
    init() {
        v1 = "0000"
        print("createing s0")
    }
}

struct s1 {
    var v1: String
    static var n: Int = 0
    init(_ v1: String = "zzzzz") {
        self.v1 = v1
        s1.n+=1
    }
    lazy var v2 = s0()
}

var st1 = s1("test")
//st1.n=1
print(s1.n)
var st2 = s1()
print(s1.n)
print(st2.v2.v1)

struct Person {
    private var ssn: String
    init(_ ssn: String){
        self.ssn=ssn
    }
    func getssn() -> String {
        //print("ssn is \(ssn)")
        return ssn
    }
}

var p = Person("12345");
//print(p.ssn);
print(p.getssn())


