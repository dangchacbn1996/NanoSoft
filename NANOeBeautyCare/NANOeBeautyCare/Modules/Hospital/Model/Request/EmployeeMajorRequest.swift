//
//  EmployeeMajorRequest.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

struct EmployeeMajorRequest: Codable {
//    var idNhomDichVu: Int = 0
//    var pageSize: Int = Int(kDefaultPageSize)
//    var pageNum: Int = Int(kDefaultStartPage)
//    var tenDichVu: String = ""
    var TenNhanVien: String?
    var MaNhom: String = "BAC_SY"
    var IdKhoa: Int?

    enum CodingKeys: String, CodingKey {
        case TenNhanVien = "TenNhanVien"
        case MaNhom = "MaNhom"
        case IdKhoa = "IdKhoa"
    }
}
