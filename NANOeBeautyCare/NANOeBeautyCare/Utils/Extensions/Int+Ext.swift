//
//  Int+Ext.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

extension Int {
    func declination(worlds: [String]) -> String {
        let cases = [2, 0, 1, 1, 1, 2]
        return worlds[(self % 100 > 4 && self % 100 < 20) ? 2 : cases[(self % 10 < 5) ? self % 10 : 5]]
    }
}

extension Int {
    func toString() -> String {
        return "\(self)"
    }
}
