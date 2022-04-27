//
//  CheckProductExited.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct CheckProductExited: Codable {
    var id: Int?
    var loai: String?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case loai = "Loai"
    }
}
