//
//  ViewController.swift
//  test1
//
//  Created by user165519 on 6/19/20.
//  Copyright © 2020 user165519. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
          let search = UISearchController(searchResultsController: nil)
                //search.searchResultsUpdater = self
                search.obscuresBackgroundDuringPresentation = false
                search.searchBar.placeholder = "Search"
                
               // search.accessibilityAttributedLabel.
         search.hidesNavigationBarDuringPresentation = true
        //search.obscuresBackgroundDuringPresentation = false
        //search.searchBar.placeholder = "Type something here..."
        //search.searchBar.scopeButtonTitles = ["Title", "Genre", "Rating", "Actor"]
        navigationItem.searchController = search
               // navigationItem.titleView = search.searchBar
                definesPresentationContext = true

    }


}

