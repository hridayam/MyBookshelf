//
//  LoadingIndicatorView.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/15/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {
    
    var isLoading: Bool = false {
        didSet {
            if self.isLoading {
                self.isHidden = false
                self.loadingIndicator.startAnimating()
            } else {
                self.isHidden = true
                self.loadingIndicator.stopAnimating()
            }
        }
    }
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.prominent)
        let view = UIVisualEffectView(effect: blurEffect)
        
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return view
    }()
    
    override func layoutSubviews() {
        self.backgroundColor = self.superview?.backgroundColor?.withAlphaComponent(0.7)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    convenience required init?(coder: NSCoder) {
        self.init(frame: .zero)
    }
    
    private func setupUI() {
        self.addSubview(blurEffectView)
        self.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
}
