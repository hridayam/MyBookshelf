//
//  BookTests.swift
//  MyBookshelfTests
//
//  Created by hridayam bakshi on 12/19/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import XCTest
@testable import MyBookshelf

class BookTests: XCTestCase {
    
    private var book: Book!
    
    private var bookFromJSON: Book? {
        do {
            return try JSONDecoder().decode(Book.self, from: BookTests.bookJSON.data(using: .utf8)!)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    override func setUp() {
        super.setUp()
        self.book = self.bookFromJSON
    }
    
    override func tearDown() {
        self.book = nil
        super.tearDown()
    }
    
    func testDecodeBook() {
        guard let book = self.book else {
            XCTFail("Error: Book is nil")
            return
        }
        
        XCTAssertEqual(book.title, "Designing Across Senses")
        XCTAssertEqual(book.subTitle, "A Multimodal Approach to Product Design")
        XCTAssertEqual(book.isbnNumber, "9781491954249")
        XCTAssertEqual(book.price, "$27.59")
        XCTAssertEqual(book.imageUrl, URL(string: "https://itbook.store/img/books/9781491954249.png"))
        XCTAssertEqual(book.url, URL(string: "https://itbook.store/books/9781491954249"))
    }
    
    static let bookJSON = """
    {
        "title": "Designing Across Senses",
        "subtitle": "A Multimodal Approach to Product Design",
        "isbn13": "9781491954249",
        "price": "$27.59",
        "image": "https://itbook.store/img/books/9781491954249.png",
        "url": "https://itbook.store/books/9781491954249"
    }
    """
}
