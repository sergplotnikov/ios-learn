//
//  ViewController.swift
//  project12_littletest
//
//  Created by user165519 on 7/31/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func callStoreButton(_ sender: Any) {
        print("store data")
        let defaults = UserDefaults.standard
        
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Paul Hudson", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        let array = ["Hello1", "World1"]
        defaults.set(array, forKey: "SavedArray")

        let dict = ["Name": "Paul1", "Country": "UK1"]
        defaults.set(dict, forKey: "SavedDict")
    }
    
    
    @IBAction func callReadButton(_ sender: Any) {
        print("read data")
            let defaults = UserDefaults.standard
            
        let array = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
        print("SavedArray=\(array)")
        
        let dic = defaults.object(forKey: "SavedDict") as? [String:String] ?? [String:String]()
        print("SavedDict=\(dic)")
            
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    
    

}

