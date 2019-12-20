//
//  NewBooksViewModelTests.swift
//  MyBookshelfTests
//
//  Created by hridayam bakshi on 12/20/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import XCTest
import Hippolyte
@testable import MyBookshelf

class NewBooksViewModelTests: XCTestCase {
    
    var viewModel: NewBooksViewModel!
    
    private var request: StubRequest!
    private var response: StubResponse!
    
    override func setUp() {
        self.setupStubs()
        self.viewModel = NewBooksViewModel()
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
        response.body = NewBooksTests.newBooksJSON.data(using: .utf8)!
        
        self.request = StubRequest.Builder()
        .stubRequest(withMethod: .GET, url: URL(string: "https://api.itbook.store/1.0/new")!)
        .addResponse(response)
        .build()
        
        Hippolyte.shared.add(stubbedRequest: self.request)
        Hippolyte.shared.start()
    }

    func testInit() {
        let inProgressExpectation = expectation(description: "in progress expectation")
        let dataExpectation = expectation(description: "book details expectatation")
        
        self.viewModel.inProgress.subscribe(with: self, callback: { bool in
            XCTAssertEqual(bool, false)
            inProgressExpectation.fulfill()
        })
        XCTAssertNotNil(self.viewModel?.inProgress.lastDataFired)
        
        self.viewModel?.books.subscribe(with: self, callback: { (newBooks, error) in
            guard let books = try? JSONDecoder().decode(NewBooks.self, from: NewBooksTests.newBooksJSON.data(using: .utf8)!) else {
                XCTFail("book details unable to decode nil")
                dataExpectation.fulfill()
                return
            }
            XCTAssertEqual(newBooks, books.books)
            dataExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
