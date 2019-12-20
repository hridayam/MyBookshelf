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
    let book = Signal<(data: BookDetails?, error: Error?)>(retainLastData: true)
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
                let book: BookDetails = try JSONDecoder().decode(BookDetails.self, from: data)
                self.book.fire((book, nil))
            } catch {
                self.book.fire((data: nil, error: error))
                print(error)
            }
        }
    }
}
