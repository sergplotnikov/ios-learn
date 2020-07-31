import UIKit

//var str = "Hello, playground"
let s1 =  "s1"
let s2 = "s2"
let s3 = "s3"
let s4 = "s4"

let s = [s1,s2,s3,s4]
s[3]
var str: [String] = []

str.append("test1")
str.append("test2")
str.append("test3")

str[1]
var r = [String]()
var r2 = Array<String>()


let set = Set([str,s])
var set2 = Set<String>()
set2.insert("z1")
set2.insert("z2")
set2.insert("z1")
set2

var name = (first: "Taylor", last: "Swift")

name.0
name.first



var d1 = ["d1": 1,
          "d2": 2,
          "d3": 3]
d1["d3"]

var d2 : [String: [Int]] = [:]
d2
d2["one"] = [1,1,1]
d2["two"]
d2["two", default:[0,0,0]]
var d3 = [String: [Int]]()
var d4 = Dictionary<String, [Int]>()
d4["test1"]=[1,1,1,1,1]
d4

// ----------------------- enum

enum ret {
    case ok
    case fail
}

ret.ok
ret.fail
enum ret2 {
    case ok(errorcode: Int)
    case fail(errorcode: Int)
}


let ret3 = ret2.ok(errorcode: 0)
ret3

enum ret4: Int {
    case ok = 100
    case fail = 200
}
ret4(rawValue: 100)
ret4(rawValue: 200)




