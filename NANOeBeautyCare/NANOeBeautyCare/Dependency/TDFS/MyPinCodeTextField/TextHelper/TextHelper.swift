//
//  TextHelper.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class TextHelper {
    let text: String?
    let placeholderText: String?
    let isSecureTextEntry: Bool
    
    init(text: String?, placeholder: String?, isSecure: Bool = false) {
        self.text = text
        self.placeholderText = placeholder
        self.isSecureTextEntry = isSecure
    }
    
    func character(atIndex i: Int) -> Character? {
        let inputTextCount = text?.count ?? 0
        let placeholderTextLength = placeholderText?.count ?? 0
        let character: Character?
        if i < inputTextCount {
            let string = text ?? ""
            character = isSecureTextEntry ? "•" : string[string.index(string.startIndex, offsetBy: i)]
        }
        else if i < placeholderTextLength {
            let string = placeholderText ?? ""
            character = string[string.index(string.startIndex, offsetBy: i)]
        }
        else {
            character = nil
        }
        return character
    }
}
