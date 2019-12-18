//
//  UIImageVeiw+Extension.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/18/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    func loadImage(url: URL) {
        Alamofire.request(url).responseImage { response in
            if let error = response.error {
                print(error)
            }
            
            guard let image = response.result.value else {
                print("unable to load image")
                return
            }
            
            self.image = image
        }
    }
}
