//
//  CustomerSocialDetailRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct CustomerSocialDetailRequest: Codable {
    var idCauHoi: Int?

    enum CodingKeys: String, CodingKey {
        case idCauHoi = "IDCauHoi"
    }
}
