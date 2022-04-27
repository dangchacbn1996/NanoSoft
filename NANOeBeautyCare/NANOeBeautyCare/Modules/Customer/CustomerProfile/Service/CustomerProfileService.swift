//
//  CustomerProfileService.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerProfileService: BaseService {
    struct HospitalNhacLichModel: Codable {
        var ID: Int?
        var IsNhacLichThongBao: Bool?
        var GioNhacLich: String?

        enum CodingKeys: String, CodingKey {
            case ID = "ID",
                 IsNhacLichThongBao = "IsNhacLichThongBao",
                 GioNhacLich = "GioNhacLich"
        }
    }
    
    func hospitalChangeRemindTime(requestData: HospitalNhacLichModel, callBack: @escaping (_ response: AnyObject, _ status: Bool, _ code: Int?) -> Void) {
        let request = CommonStructModel<HospitalNhacLichModel>(group: "DmKhachHang", action: "EDIT", cmd: "DmKhachHang.NhacLichKhaiBao", data: requestData)

        self.requestPOST(type: ModelBaseService<CustomerDetailOptionalResponse>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            callBack(respo, status,code)
        }
    }
    
    struct UpdateUserInfoReqquest: Codable {
        var AnhKhachHang: String?
        var CongTy: String?
        var DiaChi: String?
        var DienThoai: String?
        var Email: String?
        var FaceBook: String?
        var GhiChu: String?
        var HoTen: String?
        var ID: Int?
        var IDLoaiKH: Int?
        var IDNgheNghiep: Int?
        var IDNguonDen: Int?
        var IDNguonGioiThieu: Int?
        var IdGioiTinh: Int?
        var MaChiNhanh: String?
        var MaGioiTinh: String?
        var MaKhachHang: String?
        var MaQuanHuyen: String?
        var MaTinhThanh: String?
        var NgayCapNhat: String?
        var NgayDen: String?
        var NgaySinh: String?
        var NgayTao: String?
        var STT: Int?
        var SoDiDong: String?
    }
    
    func actChangeUserInfo(requestData: UpdateUserInfoReqquest, failed: @escaping (Int?, String?) -> Void, success: @escaping () -> Void) {
        let request = CommonStructModel<UpdateUserInfoReqquest>(group: "DmKhachHang", action: "EDIT", cmd: "DmKhachHang.EDIT", data: requestData)

        self.requestPOST(type: ModelBaseService<ResponseGetMS>.self, params: request.dictionary ?? [:], pathURL: .AppService) { (respo, status, code) in
            self.handleObjectStatus(modelOptionalResponse: ResponseGetMS.self, response: respo, status, code,
                                    successBlock: { (repo) in
                                        if let data = repo.data {
                                            if data.code == 1 {
                                                success()
                                                return
                                            }
                                        }
                                        failed(repo.code, repo.msg)
                                    })
            { (repo) in
                failed(repo.code, repo.msg)
            }
        }
    }
}

