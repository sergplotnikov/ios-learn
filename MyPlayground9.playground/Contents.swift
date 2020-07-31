import UIKit

 class c1 {
    var v1: String
    var v2: String
    init(_ v1: String = "0", _ v2: String = "0")
    {
        self.v1 = v1
        self.v2 = v2
    }
    
    func f1() {
        print("class c1 func f1")
    }
}

let c = c1("a1","b1")

class c2: c1 {
    init(_ v1: String){
        super.init(v1,"-1" )
    }
    override func f1() {
        print("class c2 func c1")
    }
    deinit{
        print("destroy class c2")
    }
}

let nc = c2("5555")

print("\(nc.v1) \(nc.v2)")
nc.f1()
let nc2 = nc
nc2.v1="-5"
print("\(nc.v1) \(nc.v2)")

struct s1 { var v1: String}
var st1 = s1(v1:"st1")
st1.v1 = "st1.v1"
print("\(st1.v1)")
var st2 = st1
print("\(st2.v1)")
st2.v1 = "st2.v1"
print("\(st2.v1) \(st1.v1)")
for x in 1...5 {
    let cl=c2("\(x)")
    print("\(cl.v1)")
}
