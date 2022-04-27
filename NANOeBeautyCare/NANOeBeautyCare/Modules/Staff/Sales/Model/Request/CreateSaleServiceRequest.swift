//
//  CreateSaleServiceRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CreateSaleServiceRequest
struct CreateSaleServiceRequest: Codable {
    var idHoSo: Int?

    enum CodingKeys: String, CodingKey {
        case idHoSo = "IDHoSo"
    }
}
