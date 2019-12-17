//
//  NewBooksViewModel.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/15/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation
import Signals
import Alamofire

class NewBooksViewModel {
    let books = Signal<(data: [Book], error: Error?)>(retainLastData: true)
    let inProgress: Signal<Bool> = Signal<Bool>(retainLastData: true)
    
    var progress = true
    
    func receivedData(receivedData: Book, error: Error) {
        self.inProgress.fire(false)
    }
    
    init() {
        self.inProgress.fire(true)
        Alamofire.request(BookRequestManager.newBooks).responseJSON { [weak self] response in
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
            } catch {
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
