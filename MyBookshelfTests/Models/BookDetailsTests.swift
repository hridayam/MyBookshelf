//
//  BookDetailsTests.swift
//  MyBookshelfTests
//
//  Created by hridayam bakshi on 12/19/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import XCTest
@testable import MyBookshelf

class BookDetailsTests: XCTestCase {
    
    private var bookDetails: BookDetails!
    
    private var bookDetailsFromJSON: BookDetails? {
        do {
            return try JSONDecoder().decode(BookDetails.self, from: BookDetailsTests.bookDetailsJSON.data(using: .utf8)!)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
            return nil
        }
    }

    override func setUp() {
        super.setUp()
        self.bookDetails = self.bookDetailsFromJSON
    }

    override func tearDown() {
        self.bookDetails = nil
        super.tearDown()
    }

    func testDecodeBookDetails() {
        guard let bookDetails = self.bookDetails, let pdf = try? JSONDecoder().decode(Chapters.self, from: ChaptersTests.pdfJSON.data(using: .utf8)!) else {
            XCTFail("bookDetails or chapters is nil")
            return
        }
        
        XCTAssertEqual(bookDetails.error, "0")
        XCTAssertEqual(bookDetails.title, "Securing DevOps")
        XCTAssertEqual(bookDetails.subtitle, "Security in the Cloud")
        XCTAssertEqual(bookDetails.authors, "Julien Vehent")
        XCTAssertEqual(bookDetails.publisher, "Manning")
        XCTAssertEqual(bookDetails.isbn10, "1617294136")
        XCTAssertEqual(bookDetails.isbn13, "9781617294136")
        XCTAssertEqual(bookDetails.pages, "384")
        XCTAssertEqual(bookDetails.year, "2018")
        XCTAssertEqual(bookDetails.rating, "5")
        XCTAssertEqual(bookDetails.description, "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud ...")
        XCTAssertEqual(bookDetails.price, "$26.98")
        XCTAssertEqual(bookDetails.imageUrl, URL(string: "https://itbook.store/img/books/9781617294136.png"))
        XCTAssertEqual(bookDetails.bookUrl, URL(string: "https://itbook.store/books/9781617294136"))
        XCTAssertEqual(bookDetails.pdf, pdf)
    }
    
    static let bookDetailsJSON = """
    {
        "error": "0",
        "title": "Securing DevOps",
        "subtitle": "Security in the Cloud",
        "authors": "Julien Vehent",
        "publisher": "Manning",
        "isbn10": "1617294136",
        "isbn13": "9781617294136",
        "pages": "384",
        "year": "2018",
        "rating": "5",
        "desc": "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team's highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your cloud ...",
        "price": "$26.98",
        "image": "https://itbook.store/img/books/9781617294136.png",
        "url": "https://itbook.store/books/9781617294136",
        "pdf": \(ChaptersTests.pdfJSON)
    }
    """
}
