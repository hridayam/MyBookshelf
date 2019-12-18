//
//  BaseBooksCollectionViewController.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/17/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit


// TODO: update this and use this viewController as base controller for both collectionViews
private let reuseIdentifier = "Cell"

protocol BaseBooksCollectionViewControllerDelegate {
    var collectionView: UICollectionView { get set }
}

class BaseBooksCollectionViewController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
