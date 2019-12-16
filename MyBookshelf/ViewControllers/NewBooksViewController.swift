//
//  NewBooksViewController.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/14/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class NewBooksViewController: UIViewController {
    private struct Constants {
        static let bookCollectionViewCellIdentifier = "BookCollectionViewCell"
    }
    
    private var itemsPerRow: CGFloat {
        return self.isCompact() ? 2 : 5
    }
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
    
    let viewModel: NewBooksViewModel = NewBooksViewModel()
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var loadingIndicatorView: LoadingIndicatorView = {
        let view = LoadingIndicatorView()
        
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupConstraints()
        self.setupSubscriptions()
        self.setupCollectionView()
    }
    
    func setupConstraints() {
        self.contentView.addSubview(self.loadingIndicatorView)
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.loadingIndicatorView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.loadingIndicatorView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.loadingIndicatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    func setupSubscriptions() {
        viewModel.inProgress.subscribePast(with: self) { (inProgress) in
            print(inProgress)
            if inProgress {
                self.loadingIndicatorView.isLoading = true
            } else {
                self.loadingIndicatorView.isLoading = false
            }
        }
    }
    
    func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        self.collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: Constants.bookCollectionViewCellIdentifier)
    }
}

extension NewBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.bookCollectionViewCellIdentifier, for: indexPath)
//        cell.backgroundColor = .black
        return cell
    }
}

extension NewBooksViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension NewBooksViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = self.sectionInsets.left * (self.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / self.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem * 1.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.left
    }
}
