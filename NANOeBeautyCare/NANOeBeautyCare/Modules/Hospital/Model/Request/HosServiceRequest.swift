//
//  HosServiceRequest.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 18/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

struct HosServiceRequest: Codable {
    var TenGoi: String?
    var Id: Int?
    var page_size: Int?
    var page_num: Int?
}

struct HosServiceDetailRequest: Codable {
    var Id: Int?
    var TenDichVu: String?
}
