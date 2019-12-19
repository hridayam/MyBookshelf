//
//  BookDetailsView.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/17/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class BookDetailsView: UIView {
    
    private struct Constant {
        static let buttonCornerRadius: CGFloat = 5
    }
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var yearPublishedLabel: UILabel!
    @IBOutlet weak var isbn10Label: UILabel!
    @IBOutlet weak var isbn13Label: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var chapter3Button: UIButton!
    @IBOutlet weak var chapter5Button: UIButton!
    @IBOutlet weak var buttonStack: UIStackView!
    @IBOutlet weak var websiteButtonBottomConstraintToSuperView: NSLayoutConstraint!
    
    var openWebsite: (() -> Void)?
    var openChapter2: (() -> Void)?
    var openChapter5: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.websiteButton.layer.cornerRadius = Constant.buttonCornerRadius
        self.chapter5Button.layer.cornerRadius = Constant.buttonCornerRadius
        self.chapter3Button.layer.cornerRadius = Constant.buttonCornerRadius
        
        self.setupView(book: nil)
    }
    
    func setupView(book: BookDetails?) {
        self.titleLabel.text = book?.title ?? ""
        self.subtitleLabel.text = book?.subtitle ?? ""
        self.authorsLabel.text = book?.authors ?? ""
        self.publisherLabel.text = book?.publisher ?? ""
        self.yearPublishedLabel.text = book?.year ?? ""
        self.isbn10Label.text = book?.isbn10 ?? ""
        self.isbn13Label.text = book?.isbn13 ?? ""
        self.pagesLabel.text = "\(String(describing: book?.pages ?? "0")) pages"
        self.ratingsLabel.text = "Rated \(String(describing: book?.rating ?? "0"))/5"
        self.priceLabel.text = book?.price ?? ""
        self.descriptionLabel.text = book?.description ?? ""
        
        if let book = book {
            self.bookImageView.loadImage(url: book.imageUrl)
            
            if book.pdf == nil {
                self.buttonStack.removeFromSuperview()
                self.websiteButtonBottomConstraintToSuperView.priority = UILayoutPriority.defaultHigh
            }
        }
    }
    
    @IBAction func websiteButtonAction(_ sender: Any) {
        self.openWebsite?()
    }
    
    @IBAction func chapter5ButtonAction(_ sender: Any) {
        self.openChapter5?()
    }
    
    @IBAction func chapter2ButtonActoin(_ sender: Any) {
        self.openChapter2?()
    }
}
