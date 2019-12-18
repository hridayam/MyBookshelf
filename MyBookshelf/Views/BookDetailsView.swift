//
//  BookDetailsView.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/17/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class BookDetailsView: UIView {
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
        self.pagesLabel.text = book?.pages ?? ""
        self.ratingsLabel.text = book?.rating ?? ""
        self.priceLabel.text = book?.price ?? ""
        self.descriptionLabel.text = book?.description ?? ""
        
        if let book = book {
            self.bookImageView.loadImage(url: book.imageUrl)
        }
    }
}
