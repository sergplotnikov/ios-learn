//
//  Meal.swift
//  FoodTracker2
//
//  Created by user165519 on 1/22/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding{
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meal")
    
    //MARK: Init
    init?(name: String, photo: UIImage?, rating: Int){
        
    /* if name.isEmpty || rating < 0
     {
            return nil
        }
      */
        guard !name.isEmpty else {
            return nil
        }
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
       
        self.name = name
        self.photo = photo
        self.rating = rating

    }
    
    //Mark: Types
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    //Mark: NSCoding
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to deocde the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        self.init(name: name, photo: photo, rating: rating)
    }
}

