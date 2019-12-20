//
//  BookDetails.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/18/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation

struct BookDetails: Decodable, Equatable {
    let error: String
    let title: String
    let subtitle: String
    let authors: String
    let publisher: String
    let isbn13: String
    let isbn10: String
    let pages: String
    let year: String
    let rating: String
    let description: String
    let price: String
    let imageUrl: URL
    let bookUrl: URL
    let pdf: Chapters?
    
    enum CodingKeys: String, CodingKey {
        case error
        case title
        case subtitle
        case authors
        case publisher
        case isbn13
        case isbn10
        case pages
        case year
        case rating
        case description = "desc"
        case price
        case imageUrl = "image"
        case bookUrl = "url"
        case pdf
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.error = try values.decode(String.self, forKey: .error)
        self.title = try values.decode(String.self, forKey: .title)
        self.subtitle = try values.decode(String.self, forKey: .subtitle)
        self.authors = try values.decode (String.self, forKey: .authors)
        self.publisher = try values.decode(String.self, forKey: .publisher)
        self.isbn13 = try values.decode(String.self, forKey: .isbn13)
        self.isbn10 = try values.decode(String.self, forKey: .isbn10)
        self.pages = try values.decode(String.self, forKey: .pages)
        self.year = try values.decode(String.self, forKey: .year)
        self.rating = try values.decode(String.self, forKey: .rating)
        self.description = try values.decode(String.self, forKey: .description)
        self.price = try values.decode(String.self, forKey: .price)
        self.imageUrl = try values.decode(URL.self, forKey: .imageUrl)
        self.bookUrl = try values.decode(URL.self, forKey: .bookUrl)
        self.pdf = try values.decodeIfPresent(Chapters.self, forKey: .pdf)
    }
}
