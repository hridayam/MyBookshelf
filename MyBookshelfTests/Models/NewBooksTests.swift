//
//  NewBooksTests.swift
//  MyBookshelfTests
//
//  Created by hridayam bakshi on 12/19/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import XCTest
@testable import MyBookshelf

class NewBooksTests: XCTestCase {
    
    private var newBooks: NewBooks!
    
    private var newBooksFromJSON: NewBooks? {
        do {
            return try JSONDecoder().decode(NewBooks.self, from: NewBooksTests.newBooksJSON.data(using: .utf8)!)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
            return nil
        }
    }

    override func setUp() {
        super.setUp()
        self.newBooks = self.newBooksFromJSON
    }

    override func tearDown() {
        super.tearDown()
        self.newBooks = nil
    }

    func testDecodeNewBooks() {
        guard let newBooks = self.newBooks, let book = try? JSONDecoder().decode(Book.self, from: BookTests.bookJSON.data(using: .utf8)!) else {
            XCTFail("newbooks or book is nil")
            return
        }
        
        XCTAssertEqual(newBooks.error, "0")
        XCTAssertEqual(newBooks.books, [book, book, book])
        XCTAssertEqual(newBooks.page, "1")
        XCTAssertEqual(newBooks.total, "3")
        XCTAssertEqual(newBooks.books.count, 3)
    }
    
    static let newBooksJSON: String = """
    {
        "error": "0",
        "total": "3",
        "page": "1",
        "books": [
            \(BookTests.bookJSON),
            \(BookTests.bookJSON),
            \(BookTests.bookJSON)
        ]
    }
    """
}
