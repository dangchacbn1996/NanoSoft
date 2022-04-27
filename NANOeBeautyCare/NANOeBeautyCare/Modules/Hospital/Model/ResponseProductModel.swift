//
//  ResponseProductModel.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

class ResponseProductModel: Codable {
//    {"IDLoaiDV":2,"MaLoaiDichVu":"YYY","TenLoaiDichVu":"GFGSDND","IDPhongBan":null,"Icon":""}
    var IDLoaiDV: Int?
    var MaLoaiDichVu: String?
    var TenLoaiDichVu: String?
    var IDPhongBan: Int?
    var Icon: String?
    
    enum CodingKeys: String, CodingKey {
        case IDLoaiDV = "IDLoaiDV"
        case MaLoaiDichVu = "MaLoaiDichVu"
        case TenLoaiDichVu = "TenLoaiDichVu"
        case IDPhongBan = "IDPhongBan"
        case Icon = "Icon"
    }
    
    static func demoData() -> (ResponseProductModel) {
        let result = ResponseProductModel()
        result.TenLoaiDichVu = "Dịch vụ"
        result.IDLoaiDV = 1
        return result
    }
}
