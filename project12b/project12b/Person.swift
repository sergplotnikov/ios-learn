//
//  Person.swift
//  project10
//
//  Created by user165519 on 7/10/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
    self.name = name
    self.image = image
    }
    
    
}
