//
//  HospitalNotifiItemModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 06/08/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class HospitalNotifiItemModel: Codable {
    var code: Int?
    var msg: String?
    var data: [HospitalNotifiItem]?
}

class HospitalNotifiItem: Codable {
    var TotalCount: Int?
    var NotificationID: Int?
    var TieuDe: String?
    var NoiDung: String?
    var IsView: Bool?
    var data_type: String?
    var NgayTao: String?
}
