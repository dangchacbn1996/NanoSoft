//
//  UILabel+Ext.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

@IBDesignable extension UILabel {
    
    func setCharacterSpacing(_ characterSpacing: CGFloat = 0.0) {
        guard let labelText = text else { return }
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Character spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSMakeRange(0, attributedString.length))
        
        attributedText = attributedString
    }
    
    func setLineSpacing(_ lineSpacing: CGFloat = 0.0) {
        guard let labelText = text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Character spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        attributedText = attributedString
    }
    
    @IBInspectable public var kern_: CGFloat {
        set {
            self.setCharacterSpacing(newValue)
        }
        
        get {
            return 0
        }
    }
    
}

extension UILabel{
    
    convenience init(text : String = "", font : UIFont, color : UIColor = UIColor.black, breakable : Bool = false) {
        self.init(frame: CGRect.zero)
        self.textColor = color
        self.font = font
        self.accessibilityLabel = text
        if text != "" {
            self.text = text
        }
        if breakable {
            self.numberOfLines = 0
        }
    }
}
