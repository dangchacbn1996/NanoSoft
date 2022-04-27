//
//  MoreWebViewRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import OneSignal

struct MoreWebViewRequest: Codable {
    var appid: String = OneSignal.getDeviceState()?.userId ?? ""
    var type: String = Common.BRAND_TYPE
    var username: String = Common.BRAND_PHONE_NUMBER.removeWhitespace()

    enum CodingKeys: String, CodingKey {
        case appid = "appid"
        case type = "type"
        case username = "username"
    }
}
