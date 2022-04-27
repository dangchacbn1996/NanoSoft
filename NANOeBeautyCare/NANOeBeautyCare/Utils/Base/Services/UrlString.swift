//
//  UrlString.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

let kDefaultStartPage: UInt = 1
let kDefaultPageSize = 1000

enum UrlString: String {
    //Hot dev
    case Host = ""
    //Host Live
//    case Host = ""
    case urlUpdate = "urlUpdate"
    case AppService = "/api/AppService"
    case AppServiceCreateCustommer = "/api/AppService/ThemHoSoKhachHang"
    case AppServiceUpload = "/api/AppService/AppUpload"
    case Login = "/api/AppService/Login"
    case logout = "logout"
}

// MARK: - Common.
struct ResponseCommonArrayObject: Codable {
    let success: Bool?
    let message: String?
    let data: [ResponseCommonObjectElement]?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}

struct ResponseCommonObject: Codable {
    let success: Bool?
    let message: String?
    let data: ResponseCommonObjectElement?
    
    enum CodingKeys: String, CodingKey {
        case success
        case message
        case data
    }
}


// MARK: - Datum
struct ResponseCommonObjectElement: Codable {
}
