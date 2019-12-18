//
//  BookDetailsViewModel.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/17/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation

import Foundation
import Signals
import Alamofire

class BookDetailsViewModel {
    let book = Signal<(data: Book?, error: Error?)>(retainLastData: true)
    let inProgress: Signal<Bool> = Signal<Bool>(retainLastData: true)
    
    init(isbn: String) {
        self.inProgress.fire(true)
        Alamofire.request(BookRequestManager.bookDetails(isbn)).responseJSON { [weak self] response in
            guard let self = self else { return }

            self.inProgress.fire(false)
            print("Endpoint: BookDetails:\n  \(response)")
            if let error = response.error {
                self.book.fire((data: nil, error: error))
            }
            
            guard let data = response.data else {
                print("no response from server")
                return
            }
            do {
                let book: Book = try JSONDecoder().decode(Book.self, from: data)
                self.book.fire((book, nil))
            } catch {
                self.book.fire((data: nil, error: error))
                print(error)
            }
        }
        
//        Alamofire.request(BookRequestManager.search("hello", 1)).responseJSON { [weak self] response in
//            guard let self = self else { return }
//
//            print("Endpoint: Book:\n  \(response)")
//            self.inProgress.fire(false)
//            guard let data = response.data else {
//                print("no response from server")
//                return
//            }
//            do {
//                let newBooks: NewBooks = try JSONDecoder().decode(NewBooks.self, from: data)
//                self.books.fire((newBooks.books, nil))
//            } catch {
//                print(error)
//            }
//        }
    }
}