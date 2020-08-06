//
//  ViewController.swift
//  pr1
//
//  Created by user165519 on 3/16/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit
//UITableViewDataSource, UITableViewDelegate
class TableViewController: UITableViewController {
     var pictures = Array<String>()
    var watchedNumbers: [String: Int] = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        //loadImages()
        performSelector(inBackground: #selector(loadImages), with: nil)
        
             let defaults = UserDefaults.standard
        watchedNumbers = defaults.object(forKey:"watchedNumbers") as? [String: Int] ?? [String: Int]()
        
                

    }
    
    func save() {

             let defaults = UserDefaults.standard
             defaults.set(watchedNumbers, forKey: "watchedNumbers")

     }

    @objc func loadImages(){
        let fm = FileManager.default
              let path = Bundle.main.resourcePath!
              print("path=\(path)")
              let items = try! fm.contentsOfDirectory(atPath: path).sorted()
              print("items=\(items)")
              
              // let sortedItems = items.sorted()
              //var pictures = Array<String>()
              
              for item in items {
                  if item.hasPrefix("nssl"){
                      //picture to load
                      pictures.append(item)
                      
                  }
              }
              print(pictures)
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    override func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("called tableView.numberOfRows section=\(section)")
            return pictures.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("called tableView.cellForRowAt index=\(indexPath)")
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        var c = watchedNumbers[pictures[indexPath.row]] ?? 0
        cell.textLabel?.text = pictures[indexPath.row]+" ( " + "\(indexPath.row+1) of \(pictures.count) ) (watched:\(c))"
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("called tableView.didSelectRowAt index=\(indexPath)")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.row]
            vc.numberOfPics = pictures.count
            vc.currentPicture = indexPath.row+1
            var c = watchedNumbers[pictures[indexPath.row]] ?? 0
            c += 1
            watchedNumbers[pictures[indexPath.row]] = c
            save()
            navigationController?.pushViewController(vc, animated: false)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
}

