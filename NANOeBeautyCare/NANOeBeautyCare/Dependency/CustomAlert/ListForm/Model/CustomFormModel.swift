//
//  CustomFormModel.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/24/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

struct CustomFormModelElement: Codable {
    var selectedId: String?
    var selected: String?
    var rawItem: AnyObject?
    var isSelected: Bool = false
    var avartaUrl:String?

    enum CodingKeys: String, CodingKey {
        case selected = "selected"
    }
}

//typealias CustomFormModel = [CustomFormModelElement]
