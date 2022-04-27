//
//  ModelRequestProductAndSearchCatalog.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/12/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - ModelRequestProductAndSearchCatalog
struct ModelRequestProductAndSearchCatalog: Codable {
    var user: String?
    var sid: String?
    var group: String?
    var action: String?
    var cmd: String?
    var data: ModelRequestProductAndSearchCatalogDataClass?
    var checksum: String?

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case sid = "sid"
        case group = "group"
        case action = "action"
        case cmd = "cmd"
        case data = "data"
        case checksum = "checksum"
    }
}

// MARK: - DataClass
struct ModelRequestProductAndSearchCatalogDataClass: Codable {
    var tenSanPham: String?
    var nhomSanPhamID: Int?
    var loaiSanPhamID: Int?
    var hangSanXuatID: Int?
    var pageSize: Int?
    var pageNum: Int?

    enum CodingKeys: String, CodingKey {
        case tenSanPham = "TenSanPham"
        case nhomSanPhamID = "NhomSanPhamID"
        case loaiSanPhamID = "LoaiSanPhamID"
        case hangSanXuatID = "HangSanXuatID"
        case pageSize = "page_size"
        case pageNum = "page_num"
    }
}
