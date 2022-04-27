//
//  DetailTreatmentRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - DetailTreatmentRequest
struct DetailTreatmentRequest: Codable {
    var dichVuID: Int?
    var hoSoID: Int?

    enum CodingKeys: String, CodingKey {
        case dichVuID = "DichVuID"
        case hoSoID = "HoSoID"
    }
}
