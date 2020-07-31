import UIKit

let str = { (var1: String)-> String in
    print("\(var1)")
    return "->"+var1+"<-"
}

let str2 = {
    print("Str2")
}
var t = str("Sup")
t

func ttt(_ pr: (String)-> String,_ arg1: String) -> String
{
return pr(arg1)
}

var t2 = ttt(str,"test")
print("t2=\(t2)")

func ttt2(_ action: () -> Void)
{   print("begin: ")
    action()
}

ttt2 { print("1111") }

func ttt3(_ arg1: String, _ action: (String) -> String) -> String {
    print("ttt3: \(arg1)")
    return action(arg1)
}
var res = ttt3("test33") {var1 in
    print("closure: \(var1)")
    return "!!!"+var1+"!!!"
}
print("res=\(res)")

 res = ttt3("test333") {
     print("closure: \($0)")
     return "!!!"+$0+"!!!"
}
print("res=\(res)")

let mp = { (var1: String, var2: Int) -> String in
    print("var1=\(var1) var2=\(var2)")
    return ">>>"+var1+" \(var2)"+"<<<"
}

mp("test",1)

func retcl () -> (String) -> Void {
    var count = 0
    return { count+=1
        print("closure data is \($0), count=\(count)")
    }
}
let retclres = retcl()
retclres("for test1")
retclres("for test2")
retclres("for test3")

retcl()("direct call")
retclres("for test4")

