import UIKit

func test() {
    let msg = """
test1
test2
test3
test4
"""
    print (msg)
}

test()
func test2(_ n: Int = 5)->Int{
    if n > 0 {
        for x in 1...n{
            print("\(x)")
        }
        return 0
    } else {
        return 1
    }
}

var res = test2(2)
res
res=test2()
print("a1","a2","a3","a4","a5")

func  test3(par: Int ...) -> String {
    var pos = 0
    for x in par{
        pos += 1;
        print("position \(pos) parameter=\(x)")
    }
    if pos == 0 {return "failure"} else {return "seccess"}
}

var res2 = test3(par: 1,2,3,4,5,6,7,8,9,0)

enum TestError: Error {
    case fuck, ok, good, fine
}

func test4(_ par: inout String) throws -> String {
    if par == "ok" {
        throw TestError.ok
    }
     if par == "good" {
           throw TestError.good
       }
    par += " !!!!"
    return par
}


var p = "1"
do {
var ret2 = try test4(&p)
    print(p)
    print(ret2)
}catch TestError.ok {
    print("catch throw ok in test4")
}catch TestError.good {
    print("catch throw good in test4")
}




 
