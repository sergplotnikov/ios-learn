//
//  ViewController.swift
//  project7
//
//  Created by user165519 on 6/17/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    //var petitions = Array<String>()
    var petitions = [Petition]()
    var fltrPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //let CreaditBt=UIBarButtonItem( title: "?", style: .plain, target: self, action: #selector(showCredit))
        //let searchPtrn = UISearchBar();
        //navigationItem.titleView = searchPtrn
        
        //navigationItem.rightBarButtonItem =  CreaditBt

        

        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
       // search.accessibilityAttributedLabel.
 search.hidesNavigationBarDuringPresentation = true
//search.obscuresBackgroundDuringPresentation = false
//search.searchBar.placeholder = "Type something here..."
//search.searchBar.scopeButtonTitles = ["Title", "Genre", "Rating", "Actor"]
navigationItem.searchController = search
       // navigationItem.titleView = search.searchBar
        definesPresentationContext = true
        
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    //let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
    let urlString: String
        
    if navigationController?.tabBarItem.tag == 0 {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
    // urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        
   // DispatchQueue.global(qos: .userInitiated).async {
   //     if let url = URL(string: urlString) {
   //         if let data = try? Data(contentsOf: url) {
   //             self.parse(json: data)
   //             return
   //         }
   //     }
   //     self.showError()
   // }

    performSelector(inBackground: #selector(fetchJSON), with: nil)
        
        
    }
    
    
    @objc func fetchJSON() {
    let urlString: String

    if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
    } else {
        urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
    }

    if let url = URL(string: urlString) {
        if let data = try? Data(contentsOf: url) {
            parse(json: data)
            return
        }
    }

  //  performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
}
    
     
        
    
    @objc func showCredit() {
        let ac = UIAlertController(title: "Information", message: "the data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
           ac.addAction(UIAlertAction(title: "OK", style: .default))
           present(ac, animated: true)
    }
    
    func parse(json: Data) {
    let decoder = JSONDecoder()

    if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
        petitions = jsonPetitions.results
        fltrPetitions = petitions
        //DispatchQueue.main.async {
        //    self.tableView.reloadData()
       // }
        
        //tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
 
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        
        
     }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return fltrPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    //cell.textLabel?.text = "Title goes here"
    //cell.detailTextLabel?.text = "Subtitle goes here"
        let petition = fltrPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
    return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = DetailViewController()
    vc.detailItem = fltrPetitions[indexPath.row]
    navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func showError() {
    //DispatchQueue.main.async {
    let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(ac, animated: true)
    //}
    }
    
}

extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    // TODO
    guard let text = searchController.searchBar.text else { return }
    print(text)
    if text.isEmpty{
        fltrPetitions = petitions
    }
    else {
    fltrPetitions = petitions.filter { $0.title.contains(text) }
    }
    tableView.reloadData()
  }
}
