//
//  NewBooksViewController.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/14/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class NewBooksViewController: UIViewController {
    
    let viewModel: NewBooksViewModel = NewBooksViewModel()
    @IBOutlet weak var contentView: UIView!
    
    lazy var loadingIndicatorView: LoadingIndicatorView = {
        let view = LoadingIndicatorView()
        
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.addSubview(self.loadingIndicatorView)
        NSLayoutConstraint.activate([
            self.loadingIndicatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.loadingIndicatorView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.loadingIndicatorView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.loadingIndicatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        setupSubscriptions()
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
    
    
}
