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
        self.image = #imageLiteral(resourceName: "defaultImage")
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String : String], let path = dict[url.absoluteString], let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
            self.image = UIImage(data: data)
        }
        Alamofire.request(url).responseImage { response in
            if let error = response.error {
                print(error)
            }
            
            guard let image = response.result.value else {
                print("unable to load image")
                return
            }
            self.storeImage(urlString: url.absoluteString, image: image)
            self.image = image
        }
    }
    
    func storeImage(urlString: String, image: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = image.pngData()
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String : String]
        if dict == nil {
            dict = [String: String]()
        }
        dict![urlString] = path
        UserDefaults.standard.set(dict, forKey: "ImageCache")
    }
}
