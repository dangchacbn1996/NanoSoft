//
//  ResponseMajorModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class ResponseMajorModel: Codable {
    var Id: Int?
    var Ma: String?
    var Ten: String?

    enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Ma = "Ma"
        case Ten = "Ten"
    }
}
