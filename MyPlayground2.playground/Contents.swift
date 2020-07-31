import UIKit

var count = 1...10
for n in count {
    print("Number is \(n)")
}

let ar1 = ["a1","a2","a3","a4","a5"]

for a in ar1 {
    print ("\(a)")
}
for _ in 1..<5 {
    print("test")
}
//-----------------------------------------------------------

var t = true
while t {
    print("while loop")
    t = false
}

var number = 1
repeat {
  print(number)
    number += 1
} while number <= 2

while t {
    print("while - t")
}
repeat {
    print("repeat while - t ")
} while t
//-------------------------------------------------------------

var n = 5
while n > 0 {
    print("count down: \(n)")
    if n <= 3 {
        print("exit from loop")
        break;
    }
    n -= 1
}

n = 5
mainloop: for i in 1...5 {
    for j in 1...5 {
        if j>1 {
            continue 
        }
        print("i=\(i) j=\(j)")
        if i > 2 {
            break mainloop
        }
    }
}

