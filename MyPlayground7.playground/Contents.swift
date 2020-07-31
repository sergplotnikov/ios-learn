import UIKit

var str = "Hello, playground"
print(str.count)
print(str.contains("play"))
print(str.uppercased())
print(str.sorted())

var ar1 = ["a1","a2"]
print(ar1.count)
print(ar1.capacity)
ar1.append("a3")
print(ar1.sorted())
print(ar1.firstIndex(of: "a") ?? -1 )


