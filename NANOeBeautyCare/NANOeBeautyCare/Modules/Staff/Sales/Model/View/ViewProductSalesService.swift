//
//  ViewProductSalesService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - ViewProductSalesService
struct ViewProductSalesService: Codable {
    var serviceProduct: [ServiceProductOptionalResponse]?
    var catalogProduct: [CatalogProductOptionalResponse]?
    var cardProduct: [CardProductOptionalResponse]?

    enum CodingKeys: String, CodingKey {
        case serviceProduct = "serviceProduct"
        case catalogProduct = "CatalogProduct"
        case cardProduct = "CardProduct"
    }
}
