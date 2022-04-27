//
//  CustomerDetailRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - DataClass
struct CustomerDetailRequest: Codable {
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
    }
}
