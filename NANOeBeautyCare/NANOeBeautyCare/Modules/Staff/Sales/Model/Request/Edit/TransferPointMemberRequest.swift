//
//  TransferPointMemberRequest.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/20/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

// MARK: - TransferPointMemberRequest
struct TransferPointMemberRequest: Codable {
    var khachHangID: Int?
    var soDiemQuyDoi: Int?

    enum CodingKeys: String, CodingKey {
        case khachHangID = "KhachHangID"
        case soDiemQuyDoi = "SoDiemQuyDoi"
    }
}
