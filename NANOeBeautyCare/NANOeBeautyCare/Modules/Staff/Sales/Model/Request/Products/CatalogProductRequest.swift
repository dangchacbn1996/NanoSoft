//
//  CatalogProductRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/2/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - CatalogProductRequest
struct CatalogProductRequest: Codable {
    var hangSanXuatID: Int = 0
    var loaiSanPhamID: Int = 0
    var nhomSanPhamID: Int = 0
    var pageNum: Int = Int(kDefaultStartPage)
    var pageSize: Int = Int(kDefaultPageSize)
    var tenSanPham: String = ""

    enum CodingKeys: String, CodingKey {
        case hangSanXuatID = "HangSanXuatID"
        case loaiSanPhamID = "LoaiSanPhamID"
        case nhomSanPhamID = "NhomSanPhamID"
        case pageNum = "page_num"
        case pageSize = "page_size"
        case tenSanPham = "TenSanPham"
    }
}
