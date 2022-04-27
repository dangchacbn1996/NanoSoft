//
//  TreatmentEditDetailRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - TreatmentEditDetailRequest
struct TreatmentEditDetailRequest: Codable {
    var ghiChu: String?
    var idLieuTrinhDieuTriDv: Int?
    var idPhongDichVu: Int?
    var listIdNhanVien: String?
    var ngayThucHien: String?
    var trangThaiLieuTrinh: Int?

    enum CodingKeys: String, CodingKey {
        case ghiChu = "GhiChu"
        case idLieuTrinhDieuTriDv = "IDLieuTrinhDieuTriDV"
        case idPhongDichVu = "IDPhongDichVu"
        case listIdNhanVien = "ListIDNhanVien"
        case ngayThucHien = "NgayThucHien"
        case trangThaiLieuTrinh = "TrangThaiLieuTrinh"
    }
}
