//
//  CancelPaymentRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
// MARK: - CancelPaymentRequest
struct CancelPaymentRequest: Codable {
    var hoSoId: Int

    enum CodingKeys: String, CodingKey {
        case hoSoId = "HoSoID"
    }
}
