//
//  Book.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/14/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation

/**
 Book Details from Book API Endpoint
 
 ## Sample API Response:
 - "title": "The C# Programming Language, 4th Edition",
 - "subtitle": "",
 - "isbn13": "9780321741769",
 - "price": "$39.99",
 - "image": "https://itbook.store/img/books/9780321741769.png",
 - "url": "https://itbook.store/books/9780321741769"
 */

struct Book: Decodable, Equatable {
    let title: String
    let subTitle: String
    let isbnNumber: String
    let price: String
    let imageUrl: URL
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case title
        case subTitle = "subtitle"
        case isbnNumber = "isbn13"
        case price
        case imageUrl = "image"
        case url
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.title = try values.decode(String.self, forKey: .title)
        self.subTitle = try values.decode(String.self, forKey: .subTitle)
        self.isbnNumber = try values.decode(String.self, forKey: .isbnNumber)
        self.price = try values.decode(String.self, forKey: .price)
        self.imageUrl = try values.decode(URL.self, forKey: .imageUrl)
        self.url = try values.decode(URL.self, forKey: .url)
    }
}
