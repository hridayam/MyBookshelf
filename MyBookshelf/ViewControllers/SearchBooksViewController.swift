//
//  SearchBooksViewController.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/14/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class SearchBooksViewController: UIViewController {
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Books"
        
        return searchController
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        // Do any additional setup after loading the view.
    }
}
