//
//  Chapters.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/17/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation

struct Chapters: Decodable, Equatable {
    let chapter2: URL
    let chapter5: URL
    
    enum CodingKeys: String, CodingKey {
        case chapter2 = "Chapter 2"
        case chapter5 = "Chapter 5"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.chapter2 = try values.decode(URL.self, forKey: .chapter2)
        self.chapter5 = try values.decode(URL.self, forKey: .chapter5)
    }
}
