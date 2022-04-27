//
//  ServerSettingResponse.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/3/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

func transformationServerSettingResponse(model: ServerSettingOptionalResponse?) -> ServerSettingResponse {
    var arrayData: [ServerSettingResponseDatum] = []
    var dataSave = model?.data

    if let datas =  model?.data {
        for item in datas {
            arrayData.append(ServerSettingResponseDatum(maCongTy: item.maCongTy ?? "", domain: item.domain ?? "", url: item.url ?? "", tenCongTy: item.tenCongTy ?? "", tenThuongHieu: item.tenThuongHieu ?? "", keyGen: item.keyGen ?? "", diaChiCongTy: item.diaChiCongTy ?? "", mst: item.mst ?? "", email: item.email ?? "", dienThoai: item.dienThoai ?? "", fax: item.fax ?? "", logo: "\(item.url ?? "")\(item.logo ?? "")"))
        }
    }
    
    return ServerSettingResponse(code: model?.code ?? 0, msg: model?.msg ?? "", data: arrayData)
}


// MARK: - ServerSettingResponse
struct ServerSettingResponse: Codable {
    let code: Int
    let msg: String
    let data: [ServerSettingResponseDatum]

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case msg = "msg"
        case data = "data"
    }
}
