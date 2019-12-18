//
//  BookDetailsViewController.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/17/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {
    
    var viewModel: BookDetailsViewModel? {
        didSet {
            self.viewModel?.inProgress.subscribePast(with: self) { [weak self] inProgress in
                guard let self = self else { return }
                print("EventFired: inProgress, status: \(inProgress)")
                if inProgress {
                    self.loadingIndicatorView.isLoading = true
                } else {
                    self.loadingIndicatorView.isLoading = false
                }
            }
            
            self.viewModel?.book.subscribe(with: self) { [weak self] (book, error) in
                guard let self = self else { return }
                if let error = error {
                    print ("error fetching data: \(error)")
                    return
                }
                
                self.bookDetailsView.setupView(book: book)
            }
        }
    }
    
    @IBOutlet weak var bookDetailsView: BookDetailsView!
    lazy var loadingIndicatorView: LoadingIndicatorView = {
        let view = LoadingIndicatorView()
        
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupLoadingIndicatorView()
    }
    
    func setupSubscriptions() {
        
    }
        
    func setupLoadingIndicatorView() {
        self.bookDetailsView.addSubview(self.loadingIndicatorView)
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.leadingAnchor.constraint(equalTo: self.bookDetailsView.leadingAnchor),
            self.loadingIndicatorView.trailingAnchor.constraint(equalTo: self.bookDetailsView.trailingAnchor),
            self.loadingIndicatorView.topAnchor.constraint(equalTo: self.bookDetailsView.topAnchor),
            self.loadingIndicatorView.bottomAnchor.constraint(equalTo: self.bookDetailsView.bottomAnchor)
        ])
    }

}
