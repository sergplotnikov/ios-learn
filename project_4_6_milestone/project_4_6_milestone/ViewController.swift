//
//  ViewController.swift
//  project_4_6_milestone
//
//  Created by user165519 on 6/15/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shopListArr = [String]()
      var shopListArrLc = [String]()
    var selectedItem: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let addItem=UIBarButtonItem( barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(askForNewItem))
        let delItem=UIBarButtonItem( title: "—", style: .plain, target: self, action: #selector(delSelItem))
        navigationItem.rightBarButtonItems = [addItem,delItem]
        
        let delLstItem=UIBarButtonItem( title: "—", style: .plain, target: self, action: #selector(delLastItem))
        let newList=UIBarButtonItem( barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(setNewList))
           navigationItem.leftBarButtonItems = [newList,delLstItem]

    }
    @objc func delSelItem(){
        print("del index=\(String(describing: selectedItem?.row))")
        if let row = selectedItem?.row {
        shopListArr.remove( at: row)
            shopListArrLc.remove(at: row)
        //let indexPath = IndexPath(row: 0, section: 0)
        tableView.deleteRows(at: [selectedItem!], with: .automatic)
        }
    }
    @objc func delLastItem(){
        if let selIt = selectedItem { tableView.deselectRow(at: selIt, animated: true); selectedItem = nil}
        shopListArr.remove( at: 0)
            shopListArrLc.remove(at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
    
    @objc func setNewList(){
        shopListArr.removeAll(keepingCapacity: false)
        shopListArrLc.removeAll(keepingCapacity: false)
        tableView.reloadData()
    }


    @objc func askForNewItem(){
        let ac = UIAlertController(title: "Enter name of new item", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)

    }
    
    func submit(_ item: String) {
        if (checkItem(item)){
            if(!item.isEmpty){
                let regex = try? NSRegularExpression(pattern: "[A-Za-z0-9]")
                let range = NSRange(location: 0, length: item.utf16.count)
                if(regex?.firstMatch(in: item, options: [], range: range) != nil){
                    shopListArr.insert(item, at: 0)
                    shopListArrLc.insert(item.lowercased(), at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
      }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shopListArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "shopLst", for: indexPath)
    cell.textLabel?.text = shopListArr[indexPath.row]
    return cell
    }

    func checkItem(_ item: String) -> Bool {
        return !shopListArrLc.contains(item.lowercased())
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("called tableView.didSelectRowAt index=\(indexPath)")
        selectedItem = indexPath
    }

    
}

