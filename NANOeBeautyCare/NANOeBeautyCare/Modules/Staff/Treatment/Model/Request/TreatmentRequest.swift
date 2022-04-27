//
//  TreatmentRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - TreatmentRequest
struct TreatmentRequest: Codable {
    var khachHangID: Int = Common.BRAND_USER_ID
    var ngayDieuTri: String = Date().getFormattedDate(format: "dd/MM/yyyy")
    var pageNum: Int = Int(kDefaultStartPage)
    var pageSize: Int = Int(kDefaultPageSize)
    var trangThai: Int = 0
    var timKiem: String = ""

    enum CodingKeys: String, CodingKey {
        case khachHangID = "KhachHangID"
        case ngayDieuTri = "NgayDieuTri"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case trangThai = "TrangThai"
        case timKiem = "TimKiem"
    }
}
