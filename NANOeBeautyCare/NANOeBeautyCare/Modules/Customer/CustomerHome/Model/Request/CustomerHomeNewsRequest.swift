//
//  CustomerHomeNewsRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CustomerHomeNewsRequest
struct CustomerHomeNewsRequest: Codable {
    var idNews: Int?

    enum CodingKeys: String, CodingKey {
        case idNews = "IDNews"
    }
}
