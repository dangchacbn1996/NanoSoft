//
//  AppointmentRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - DataClass
struct AppointmentRequest: Codable {
    var denNgay: String = Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
    var pageNum: Int = Int(kDefaultStartPage)
    var pageSize: Int = Int(kDefaultPageSize)
    var soDienThoai: String = ""
    var tenKhachHang: String = ""
    var trangThai: Int = -1
    var tuNgay: String = Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
    var khachHangID: Int = Common.BRAND_USER_ID

    enum CodingKeys: String, CodingKey {
        case denNgay = "DenNgay"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case soDienThoai = "SoDienThoai"
        case tenKhachHang = "TenKhachHang"
        case trangThai = "TrangThai"
        case tuNgay = "TuNgay"
        case khachHangID = "KhachHangID"
    }
}
