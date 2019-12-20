//
//  SearchBooksViewControllerTests.swift
//  MyBookshelfTests
//
//  Created by hridayam bakshi on 12/19/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import XCTest
import Hippolyte
@testable import MyBookshelf

class SearchBooksViewControllerTests: XCTestCase {
    private var viewController: SearchBooksViewController?
    
    private var response: StubResponse!
    private var request: StubRequest!
    
    override func setUp() {
        super.setUp()
        self.setupStubs()
        self.viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: SearchBooksViewController.self)) as? SearchBooksViewController
        _ = self.viewController?.view
    }

    override func tearDown() {
        Hippolyte.shared.stop()
        self.viewController = nil
        self.request = nil
        self.response = nil
        super.tearDown()
    }
    
    func setupStubs() {
        self.response = StubResponse.Builder()
        .stubResponse(withStatusCode: 201)
        .build()
        response.body = NewBooksTests.newBooksJSON.data(using: .utf8)!
        
        self.request = StubRequest.Builder()
        .stubRequest(withMethod: .GET, url: URL(string: "https://api.itbook.store/1.0/search/devops/1")!)
        .addResponse(response)
        .build()
        
        Hippolyte.shared.add(stubbedRequest: self.request)
        Hippolyte.shared.start()
    }

    func testLoadResults() {
        guard let viewController = self.viewController else {
            XCTFail()
            return
        }
        
        viewController.viewModel.searchBook(query: "devops")
        let dataLoadExpectation = expectation(description: "load search data")
        
        viewController.viewModel.books.subscribe(with: self) { (books, error) in
            XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), books.count)
            dataLoadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // MARK:- Collection View tests
    func testCells() {
        guard let viewController = self.viewController else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(viewController.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(viewController.responds(to: #selector(viewController.collectionView(_:cellForItemAt:))))
    }
    
    
    // MARK:- Search Controller tests
    func testHasSearchBar() {
        XCTAssertNotNil(viewController?.searchController.searchBar)
    }
    
    func testSearchBar() {
        guard let viewController = self.viewController else {
            XCTFail()
            return
        }
        
        viewController.searchController.searchBar.text = "devops"
        viewController.searchBarTextDidEndEditing(viewController.searchController.searchBar)
        let dataLoadExpectation = expectation(description: "load search data")
        
        viewController.viewModel.books.subscribe(with: self) { (books, error) in
            XCTAssertEqual(viewController.collectionView.numberOfItems(inSection: 0), books.count)
            dataLoadExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }

}
