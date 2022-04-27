//
//  SplashResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct SplashResponse: Codable {
    let success: Bool
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
        case message = "message"
    }
}
