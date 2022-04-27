//
//  AgencyCustomerRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - AgencyCustomerRequest
struct AgencyCustomerRequest: Codable {
    var isChiNhanh: Int = 1
    var maCongTy: String = Common.BRAND_NUMBER

    enum CodingKeys: String, CodingKey {
        case isChiNhanh = "IsChiNhanh"
        case maCongTy = "MaCongTy"
    }
}
