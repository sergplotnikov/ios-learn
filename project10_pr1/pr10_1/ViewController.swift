//
//  ViewController.swift
//  pr1
//
//  Created by user165519 on 3/16/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit
//UITableViewDataSource, UITableViewDelegate
class TableViewController: UICollectionViewController {
     var pictures = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        //loadImages()
        performSelector(inBackground: #selector(loadImages), with: nil)
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
        collectionView.performSelector(onMainThread:  #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        //tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("called tableView.numberOfRows section=\(section) count=\(pictures.count)")
            return pictures.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print("called tableView.cellForRowAt index=\(indexPath)")
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? MyCell else {
        // we failed to get a PersonCell – bail out!
        fatalError("Unable to dequeue PersonCell.")
    }
        cell.filename.text = pictures[indexPath.row]+" ( " + "\(indexPath.row+1) of \(pictures.count) )"
    return cell
    }
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("called tableView.didSelectRowAt index=\(indexPath)")
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController{
            vc.selectedImage = pictures[indexPath.item]
            vc.numberOfPics = pictures.count
            vc.currentPicture = indexPath.item+1
            navigationController?.pushViewController(vc, animated: false)
        }

    }
    
}

