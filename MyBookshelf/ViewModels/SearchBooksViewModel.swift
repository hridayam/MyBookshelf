//
//  SearchBooksViewModel.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/18/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation
import Alamofire
import Signals

class SearchBooksViewModel {
    // TODO: Make books.data optional
    let books = Signal<(data: [Book], error: Error?)>(retainLastData: true)
    let inProgress: Signal<Bool> = Signal<Bool>(retainLastData: true)
    
    private var query = ("", 1)
    
    func searchBook(query: String) {
        self.inProgress.fire(true)
        Alamofire.request(BookRequestManager.search(query, 1)).responseJSON { [weak self] response in
            guard let self = self else { return }

            print("Endpoint: Book:\n  \(response)")
            self.inProgress.fire(false)
            guard let data = response.data else {
                print("no response from server")
                return
            }
            do {
                let newBooks: NewBooks = try JSONDecoder().decode(NewBooks.self, from: data)
                self.books.fire((newBooks.books, nil))
                self.query.1 = (Int(newBooks.page ?? "0") ?? 0) + 1
            } catch {
                print(error)
            }
        }
    }
    
    func getNextPage() {
        Alamofire.request(BookRequestManager.search(self.query.0, self.query.1)).responseJSON { [weak self] response in
            guard let self = self else { return }

            print("Endpoint: Book:\n  \(response)")
            self.inProgress.fire(false)
            guard let data = response.data else {
                print("no response from server")
                return
            }
            do {
                let newBooks: NewBooks = try JSONDecoder().decode(NewBooks.self, from: data)
                if let books = self.books.lastDataFired?.data {
                    self.books.fire((books + newBooks.books, nil))
                } else {
                    self.books.fire((newBooks.books, nil))
                }
                
                self.query.1 = (Int(newBooks.page ?? "0") ?? 0) + 1
            } catch {
                print(error)
            }
        }
    }
}
