//
//  CustomerHomeNewsFilterOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - CustomerHomeNewsFilterOptionalResponse
struct CustomerHomeNewsFilterOptionalResponse: Codable {
    var idNhomNews: Int?
    var idPhongBan: Int?
    var nguoiDungId: Int?
    var tenNhomNews: String?
    var trangThaiSuDung: Bool?
    var thuTu: Int?

    enum CodingKeys: String, CodingKey {
        case idNhomNews = "IDNhomNews"
        case idPhongBan = "IDPhongBan"
        case nguoiDungId = "NguoiDungID"
        case tenNhomNews = "TenNhomNews"
        case trangThaiSuDung = "TrangThaiSuDung"
        case thuTu = "ThuTu"
    }
}
