//
//  CommonStructModel.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/18/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

struct CommonStructModel<V: Codable>: Codable {
    var user: String = Common.BRAND_USER
    var sid: String = Common.BRAND_SID
    var group: String = ""
    var action: String = ""
    var cmd: String = ""
    var data: V?
    var checksum: String = ""

    enum CodingKeys: String, CodingKey {
        case user = "user"
        case sid = "sid"
        case group = "group"
        case action = "action"
        case cmd = "cmd"
        case data = "data"
        case checksum = "checksum"
    }

    init(group: String, action:String, cmd: String, data: V) {
        self.group = group
        self.action = action
        self.cmd = cmd
        self.data = data
    }
}

//struct CommonStructModel<V: Codable>: Codable {
//    var user: String = Common.BRAND_USER
//    var sid: String = Common.BRAND_SID
//    var group: String = ""
//    var action: String = ""
//    var cmd: String = ""
//    var data: V?
//    var checksum: String = ""
//
//    enum CodingKeys: String, CodingKey {
//        case user = "user"
//        case sid = "sid"
//        case group = "group"
//        case action = "action"
//        case cmd = "cmd"
//        case data = "data"
//        case checksum = "checksum"
//    }
//
//    init(group: String, action:String, cmd: String, data: V) {
//        self.group = group
//        self.action = action
//        self.cmd = cmd
//        self.data = data
//    }
//}

extension Common {
    func convert<ModelOptionalResponse: Codable, ModelResponse: Codable> (modelOptionalResponse: ModelBaseOptionalResponseService<ModelOptionalResponse>, data: ModelResponse) -> ModelBaseService<ModelResponse> {
        let modelResponse = ModelBaseService<ModelResponse>(code: modelOptionalResponse.code ?? 0, msg: modelOptionalResponse.msg ?? "", data: data)
        return modelResponse
    }
}

extension BaseService {
    //    func convert<ModelOptionalResponse: Codable, ModelResponse: Codable> (modelOptionalResponse: ModelBaseOptionalResponseService<ModelOptionalResponse>, data: ModelResponse) -> ModelBaseService<ModelResponse> {
    //        let modelResponse = ModelBaseService<ModelResponse>(code: modelOptionalResponse.code ?? 0, msg: modelOptionalResponse.msg ?? "", data: data)
    //        return modelResponse
    //    }

}
