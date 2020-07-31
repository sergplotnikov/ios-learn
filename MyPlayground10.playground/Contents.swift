import UIKit

protocol pr1 {
    var id: String {get set}
    func show()
}
struct ex1: pr1 {
    var id: String
    func show() { print("is = \(id)") }
    
}

func displ(_ p1: pr1){
    //print("id is \(p1.id)")
    p1.show();
}

var v = ex1(id:"test")

displ(v)


