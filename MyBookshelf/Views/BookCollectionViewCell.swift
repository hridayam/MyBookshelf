//
//  BookCollectionViewCell.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/15/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!

    func setup(book: Book) {
        self.costLabel.text = book.price
        self.descriptionLabel.text = book.subTitle
        self.titleLabel.text = book.title
        self.isbnLabel.text = book.isbnNumber
        self.image.loadImage(url: book.imageUrl)
        self.layoutIfNeeded()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = #imageLiteral(resourceName: "defaultImage")
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.costLabel.text = ""
        self.isbnLabel.text = ""
    }
}
