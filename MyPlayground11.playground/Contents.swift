import UIKit

extension Int {
    func sqr() -> Int {
        return self * self;
    }
    
    func mod5() -> Int {
        return self % 5
    }
}

let n  = 9

n.sqr()
n.mod5()

let col1 = ["a1","a2","a3","a4","a5","a5"]
let col2 = Set(["b1","b2","b3","b3"])

extension Collection {
    func prtcnt() {
        print("there are \(count) in collection")
        for name in self {
            print(name)
        }
    }
}

col1.prtcnt()
col2.prtcnt()

protocol pr1 {
    var id: String {get set}
    func identify()
}

extension pr1 {
    func identify() {
        print("id is \(id)")
    }
}

struct strc: pr1 {
    var id: String
}

let s1 = strc(id: "test")

s1.identify()

