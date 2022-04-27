//
//  SalesRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

// MARK: - DataClass
struct SalesRequest: Codable {
    var denNgay: String = Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
    var hoTen: String = ""
    var maKhachHang: String = ""
    var pageNum: Int = Int(kDefaultStartPage)
    var pageSize: Int = kDefaultPageSize
    var trangThai: Int = -1
    var tuNgay: String = Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")

    enum CodingKeys: String, CodingKey {
        case denNgay = "DenNgay"
        case hoTen = "HoTen"
        case maKhachHang = "MaKhachHang"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case trangThai = "TrangThai"
        case tuNgay = "TuNgay"
    }
}
