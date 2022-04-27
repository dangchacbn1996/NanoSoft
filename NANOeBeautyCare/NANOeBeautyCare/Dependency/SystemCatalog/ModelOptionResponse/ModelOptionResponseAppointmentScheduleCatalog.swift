//
//  ModelOptionResponseAppointmentScheduleCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/11/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseAppointmentScheduleCatalog
struct ModelOptionResponseAppointmentScheduleCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseAppointmentScheduleCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseAppointmentScheduleCatalogDatum: Codable {
    var idPhongBan: Int?
    var tenPhongDichVu: String?
    var diaChi: String?
    var idPhongBan1: Int?
    var loaiPhong: Int?

    enum CodingKeys: String, CodingKey {
        case idPhongBan = "IDPhongBan"
        case tenPhongDichVu = "TenPhongDichVu"
        case diaChi = "DiaChi"
        case idPhongBan1 = "IDPhongBan1"
        case loaiPhong = "LoaiPhong"
    }
}
