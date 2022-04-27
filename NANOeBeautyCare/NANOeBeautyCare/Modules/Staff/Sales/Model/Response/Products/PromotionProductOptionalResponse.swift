//
//  PromotionProductOptionalResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - PromotionProductOptionalResponse
struct PromotionProductOptionalResponse: Codable {
    var idChuongTrinhKM: Int?
    var phongBanID: Int?
    var tenChuongTrinhKM: String?
    var soLuong: Int?
    var tuNgay: String?
    var denNgay: String?
    var hinhThucKM: Int?
    var tienOrPhanTram: Bool?
    var giamTang: Double?

    enum CodingKeys: String, CodingKey {
        case idChuongTrinhKM = "IDChuongTrinhKM"
        case phongBanID = "PhongBanID"
        case tenChuongTrinhKM = "TenChuongTrinhKM"
        case soLuong = "SoLuong"
        case tuNgay = "TuNgay"
        case denNgay = "DenNgay"
        case hinhThucKM = "HinhThucKM"
        case tienOrPhanTram = "TienOrPhanTram"
        case giamTang = "Giam_Tang"
    }
}
