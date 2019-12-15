//
//  NewSearchViewController.swift
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
