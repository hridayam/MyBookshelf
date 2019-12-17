//
//  NewBooksViewController.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/14/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class NewBooksViewController: UIViewController {
    private struct Constant {
        static let bookCollectionViewCellIdentifier = "BookCollectionCellIdentifier"
    }
    
    private var itemsPerRow: CGFloat {
        return self.isCompact() ? 1 : 4
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
        viewModel.inProgress.subscribePast(with: self) { [weak self] inProgress in
            guard let self = self else { return }
            print(inProgress)
            if inProgress {
                self.loadingIndicatorView.isLoading = true
            } else {
                self.loadingIndicatorView.isLoading = false
            }
        }
        
        viewModel.books.subscribe(with: self) { [weak self] (books, error) in
            guard let self = self else { return }
            if let error = error {
                print ("error fetching data: \(error)")
                return
            }
            
            self.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
        
        let nib = UINib(nibName: "BookCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: Constant.bookCollectionViewCellIdentifier)
//        self.collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: Constant.bookCollectionViewCellIdentifier)
    }
}

extension NewBooksViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.books.lastDataFired?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = self.viewModel.books.lastDataFired?.data[indexPath.row], let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.bookCollectionViewCellIdentifier, for: indexPath) as? BookCollectionViewCell else {
            print("error setting cell")
            return BookCollectionViewCell()
        }
        
        cell.costLabel.text = data.price
        cell.descriptionLabel.text = data.subTitle
        cell.titleLabel.text = data.title
        cell.isbnLabel.text = data.isbnNumber
        Alamofire.request(data.imageUrl).responseImage { response in
            if let error = response.error {
                print(error)
            }
            
            guard let image = response.result.value else {
                print("unable to load image")
                return
            }
            
            cell.image.image = image
        }
        
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
