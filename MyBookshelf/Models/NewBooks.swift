//
//  NewBooks.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/15/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation

struct NewBooks: Decodable {
    var books: [Book]
    var error: String
    var total: String
    var page: String?
}
