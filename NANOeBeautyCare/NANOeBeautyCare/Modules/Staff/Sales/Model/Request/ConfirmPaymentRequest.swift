//
//  ConfirmPaymentRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/21/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ConfirmPaymentRequest
struct ConfirmPaymentRequest: Codable {
    var hoSoId: Int
    var trangThai: Int

    enum CodingKeys: String, CodingKey {
        case hoSoId = "HoSoID"
        case trangThai = "TrangThai"
    }
}
