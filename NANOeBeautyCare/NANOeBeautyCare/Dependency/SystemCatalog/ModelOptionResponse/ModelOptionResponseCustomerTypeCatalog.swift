//
//  ModelOptionResponseCustomerTypeCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelOptionResponseCustomerTypeCatalog
struct ModelOptionResponseCustomerTypeCatalog: Codable {
    var code: Int?
    var msg: String?
    var data: [ModelOptionResponseCustomerTypeCatalogDatum]?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}

// MARK: - Datum
struct ModelOptionResponseCustomerTypeCatalogDatum: Codable {
    var idLoaiKH: Int?
    var loaiKhachHang: String?
    var trangThaiSuDung: Bool?
    var phongBanID: Int?
    var congTyID: String?

    enum CodingKeys: String, CodingKey {
        case idLoaiKH = "IDLoaiKH"
        case loaiKhachHang = "LoaiKhachHang"
        case trangThaiSuDung = "TrangThaiSuDung"
        case phongBanID = "PhongBanID"
        case congTyID = "CongTyID"
    }
}
