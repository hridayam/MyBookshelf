//
//  UIViewController+extension.swift
//  MyBookshelf
//
//  Created by hridayam bakshi on 12/15/19.
//  Copyright © 2019 hridayam bakshi. All rights reserved.
//

import UIKit

extension UIViewController {
    func isCompact() -> Bool {
        return self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.compact
    }
    
    func isRegular() -> Bool {
        return self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular
    }
}
