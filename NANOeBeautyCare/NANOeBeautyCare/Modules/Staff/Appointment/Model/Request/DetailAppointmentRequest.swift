//
//  DetailAppointmentRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/28/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - DetailAppointmentRequest
struct DetailAppointmentRequest: Codable {
    var idLichHen: Int?

    enum CodingKeys: String, CodingKey {
        case idLichHen = "IDLichHen"
    }
}
