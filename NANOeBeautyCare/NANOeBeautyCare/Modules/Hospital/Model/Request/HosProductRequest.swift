//
//  HosProductRequest.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

struct HosProductRequest: Codable {
    var TenLoaiDichVu: String?
    var Id: Int?
    var page_size: Int?
    var page_num: Int?
}

struct HosProductDetailRequest: Codable {
    var Id: Int?
    
    init(id: Int?) {
        self.Id = id
    }
}

struct HosProductListSubFuntionRequest: Codable {
    var page_num: Int?
    var page_size: Int?
    var TenDichVu: String?
    var MaLoaiDichVu: String?
}

struct HosProductSuperDetailRequest: Codable {
    var DichVuID: Int?
    
    init(id: Int?) {
        self.DichVuID = id
    }
}
