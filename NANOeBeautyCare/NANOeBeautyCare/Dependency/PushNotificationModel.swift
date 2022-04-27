//
//  PushNotificationModel.swift
//  NANOeBeautyCare
//
//  Created by Dom on 23/01/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

let kPushNotificationAppointment = "appointment"
let kPushNotificationTreatment = "treatment"
let kPushNotificationNews = "news"
let kPushNotificationOther = "other"

// MARK: - PushNotificationModel
struct PushNotificationModel: Codable {
    var type: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
}
