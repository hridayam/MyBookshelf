//
//  BookDetailsViewModelTests.swift
//  MyBookshelfTests
//
//  Created by hridayam bakshi on 12/19/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import XCTest
import Hippolyte
@testable import MyBookshelf

class BookDetailsViewModelTests: XCTestCase {

    var viewModel: BookDetailsViewModel!
    
    private var request: StubRequest!
    private var response: StubResponse!
    
    override func setUp() {
        self.setupStubs()
        self.viewModel = BookDetailsViewModel(isbn: "9781617294136")
    }

    override func tearDown() {
        Hippolyte.shared.stop()
        self.request = nil
        self.response = nil
        self.viewModel = nil
        super.tearDown()
    }
    
    func setupStubs() {
        self.response = StubResponse.Builder()
        .stubResponse(withStatusCode: 201)
        .build()
        response.body = BookDetailsTests.bookDetailsJSON.data(using: .utf8)!
        
        self.request = StubRequest.Builder()
        .stubRequest(withMethod: .GET, url: URL(string: "https://api.itbook.store/1.0/books/9781617294136")!)
        .addResponse(response)
        .build()
        
        Hippolyte.shared.add(stubbedRequest: self.request)
        Hippolyte.shared.start()
    }

    func testBookDetailsViewModelInit() {
        let inProgressExpectation = expectation(description: "in progress expectation")
        let dataExpectation = expectation(description: "book details expectatation")
        
        self.viewModel.inProgress.subscribe(with: self, callback: { bool in
            XCTAssertEqual(bool, false)
            inProgressExpectation.fulfill()
        })
        XCTAssertNotNil(self.viewModel?.inProgress.lastDataFired)
        
        self.viewModel?.book.subscribe(with: self, callback: { (bookDetails, error) in
            guard let bookDetails = bookDetails, let book = try? JSONDecoder().decode(BookDetails.self, from: BookDetailsTests.bookDetailsJSON.data(using: .utf8)!) else {
                XCTFail("book details unable to decode nil")
                dataExpectation.fulfill()
                return
            }
            XCTAssertEqual(bookDetails, book)
            dataExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
