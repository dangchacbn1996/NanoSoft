//
//  ServerSettingResponseDatum.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/3/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - Datum
struct ServerSettingResponseDatum: Codable {
    let maCongTy: String    
    let domain: String  
    let url: String 
    let tenCongTy: String   
    let tenThuongHieu: String   
    let keyGen: String  
    let diaChiCongTy: String    
    let mst: String 
    let email: String   
    let dienThoai: String   
    let fax: String 
    let logo: String    

    enum CodingKeys: String, CodingKey {
        case maCongTy = "MaCongTy"
        case domain = "Domain"
        case url = "URL"
        case tenCongTy = "TenCongTy"
        case tenThuongHieu = "TenThuongHieu"
        case keyGen = "KeyGen"
        case diaChiCongTy = "DiaChiCongTy"
        case mst = "MST"
        case email = "Email"
        case dienThoai = "DienThoai"
        case fax = "Fax"
        case logo = "Logo"
    }
}
