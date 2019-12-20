//
//  ChaptersTests.swift
//  MyBookshelfTests
//
//  Created by hridayam bakshi on 12/19/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import XCTest
@testable import MyBookshelf

class ChaptersTests: XCTestCase {

    private var pdf: Chapters!
    
    private var pdfFromJSON: Chapters? {
        do {
            return try JSONDecoder().decode(Chapters.self, from: ChaptersTests.pdfJSON.data(using: .utf8)!)
        } catch {
            XCTFail("Error: \(error.localizedDescription)")
            return nil
        }
    }
    
    override func setUp() {
        super.setUp()
        self.pdf = self.pdfFromJSON
    }
    
    override func tearDown() {
        super.tearDown()
        self.pdf = nil
    }
    
    func testDecodeChapters() {
        guard let pdf = self.pdf else {
            XCTFail("Error: pdf is nil")
            return
        }
        
        XCTAssertEqual(pdf.chapter2, URL(string: "https://itbook.store/files/9781617294136/chapter2.pdf"))
        XCTAssertEqual(pdf.chapter5, URL(string: "https://itbook.store/files/9781617294136/chapter5.pdf"))
    }
    
    static let pdfJSON = """
    {
        "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
        "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
    }
    """
}
