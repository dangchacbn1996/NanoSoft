//
//  CardProductOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CardProductOptionalResponse
struct CardProductOptionalResponse: Codable {
    var totalRow: Int?
    var idTheDichVu: Int?
    var idLoaiTheDichVu: Int?
    var idPhongBan: Int?
    var tenPhongBan: String?
    var hanSuDung: String?
    var soLuongCon: Int?
    var giaTriThe: Int?
    var donGiaBan: Double?
    var tenTheDichVu: String?
    var tenLoaiTheDichVu: String?
    var anhTheDichVu: String?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case totalRow = "TotalRow"
        case idTheDichVu = "IDTheDichVu"
        case idLoaiTheDichVu = "IDLoaiTheDichVu"
        case idPhongBan = "IDPhongBan"
        case tenPhongBan = "TenPhongBan"
        case hanSuDung = "HanSuDung"
        case soLuongCon = "SoLuongCon"
        case giaTriThe = "GiaTriThe"
        case donGiaBan = "DonGiaBan"
        case tenTheDichVu = "TenTheDichVu"
        case tenLoaiTheDichVu = "TenLoaiTheDichVu"
        case anhTheDichVu = "AnhTheDichVu"
    }
}
