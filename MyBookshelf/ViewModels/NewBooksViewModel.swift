//
//  NewBooksViewModel.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/15/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import Foundation
import Signals

class NewBooksViewModel {
    let books = Signal<(data: [Book], error: Error)>(retainLastData: true)
    let inProgress: Signal<Bool> = Signal<Bool>(retainLastData: true)
    
    var progress = true
    
    func receivedData(receivedData: Book, error: Error) {
        self.inProgress.fire(false)
    }
    
    init() {
        self.inProgress.fire(progress)
        
        var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {[unowned self] _ in
            self.progress = !self.progress
            self.inProgress.fire(self.progress)
        }
    }
}
