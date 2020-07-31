//
//  ViewController.swift
//  pr1-3
//
//  Created by user165519 on 4/17/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    
    var pictures = Dictionary<String,String>()
    var arrName = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "World flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
                let path = Bundle.main.resourcePath!
                //print("path=\(path)")
                let items = try! fm.contentsOfDirectory(atPath: path).sorted()
               // print("items=\(items)")
        for x in (items){
            if x.contains("@3x"){
                let index = x.firstIndex(of: "@") ?? x.endIndex
                let name = String(x[..<index])
                print("name=\(name) fn=\(x)")
                pictures[name] = x
                arrName.append(name)
            }
        }
        print("pictures=\(pictures)")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        	 print("called tableView.cellForRowAt index=\(indexPath)")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as? Flag else{    fatalError("can't dequeue Cell")        }
               
                   //cell.textLabel?.text = arrName[indexPath.row] //+" ( " + "\(indexPath.row+1) of \(arrName.count) )"
        cell.cntrName.text = arrName[indexPath.row]
        //cell.cntrFlag.image = UIImage(named: pictures[cell.cntrName.text])
        if let imageToLoad =  pictures[arrName[indexPath.row]] {
        cell.cntrFlag.image = UIImage(named: imageToLoad)
            cell.cntrFlag.layer.borderWidth = 1
            cell.cntrFlag.layer.borderColor = UIColor.lightGray.cgColor
        }
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("called tableView.didSelectRowAt index=\(indexPath)")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailView{
            vc.selectedFlag = arrName[indexPath.row]
            vc.fileName = pictures[arrName[indexPath.row]]
            navigationController?.pushViewController(vc, animated: false)
        }
    }

}

