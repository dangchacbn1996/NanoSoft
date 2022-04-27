//
//  UITextField+Ext.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 03/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    convenience init(text : String = "", placeholder : String = "", font : UIFont, color : UIColor = UIColor.black) {
        self.init(frame: CGRect.zero)
        self.textColor = color
        self.font = font
        self.accessibilityLabel = placeholder
        if placeholder != "" {
            self.placeholder = placeholder
        }
        self.text = text
    }
}

