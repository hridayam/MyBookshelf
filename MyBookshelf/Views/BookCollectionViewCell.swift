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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

}
