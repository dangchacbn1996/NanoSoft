//
//  CreateCustomerPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CreateCustomerVC: BaseView {
    func initData(data:ViewCreateCustomer)
    func fillToViewWith(data: CustomerDetailOptionalResponse)
    func reloadData()

    func alertCreateMessage(text: String, data: HomeOptionalResponse?)
    func alertUpdateMessage(text: String, data: CustomerDetailOptionalResponse?)
}


class CreateCustomerPresenter: BasePresenter<CreateCustomerVC> {
    private let service = CreateCustomerService()
    
    // MARK - Private Function
    var createRequestModel = HomeCreateRequestDataClass(id: 0, maKhachHang: "", maChiNhanh: "", hoTen: "", ngaySinh: "", maGioiTinh: "", dienThoai: "", diaChi: "", maTinhThanh: "", maQuanHuyen: "", idLoaiKH: 0, idNgheNghiep: 0, idNguonDen: 0, idNguonGioiThieu: 0, email: "", faceBook: "", congTy: "", ghiChu: "", ngayTao: "", ngayCapNhat: "", ngayDen: "", anhKhachHang: "", stt: 0, idGioiTinh: 0, soDiDong: "")
    
    var dataContext: CustomerDetailOptionalResponse?
    
    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.createRequestModel = HomeCreateRequestDataClass(id: data.id ?? 0, maKhachHang: data.maKhachHang, maChiNhanh: data.maChiNhanh, hoTen: data.hoTen, ngaySinh: data.ngaySinh, maGioiTinh: data.maGioiTinh, dienThoai: data.dienThoai, diaChi: data.diaChi, maTinhThanh: data.maTinhThanh, maQuanHuyen: data.maQuanHuyen, idLoaiKH: data.idLoaiKH, idNgheNghiep: data.idNgheNghiep, idNguonDen: data.idNguonDen, idNguonGioiThieu: data.idNguonGioiThieu, email: data.email, faceBook: data.faceBook, congTy: data.congTy, ghiChu: data.ghiChu, ngayTao: data.ngayTao, ngayCapNhat: data.ngayCapNhat, ngayDen: data.ngayDen, anhKhachHang: data.anhKhachHang, stt: data.stt, idGioiTinh: data.idGioiTinh, soDiDong: data.soDiDong)
            self.viewController?.fillToViewWith(data: data)
        }
    }
    
    
    func district(idx: String, callBack: @escaping (_ status: Bool) -> Void) {
        self.service.provinceCodeCatalog(maTinhThanh: idx, callBack: callBack)
    }
    
    func services() {
        if let data = self.dataContext {
            self.updateServices()
        } else {
            self.createService()
        }
    }
    
    func createService() {
        self.service.createCustomerService(requestData: createRequestModel) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: HomeOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertCreateMessage(text: repo.msg ?? "", data: repo.data)
            }) { (repo) in
                
            }
        }
    }
    
    func updateServices() {
        self.service.updateCustomerService(requestData: createRequestModel) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CustomerDetailOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.alertUpdateMessage(text: repo.msg ?? "", data: repo.data)
            }) { (repo) in
                
            }
        }
    }
    
    func uploadImage(image: UIImage) {
        self.service.postUploadImage(request: UploadFile(fileType: .Image, fileName: "khach_hang.jpg", withName: "khach_hang", mimeType: "image/jpeg", image: image), callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [UploadResponseDatum].self, response: response, status, code, successBlock: { (repo) in
                print("SUCCEESS")
                self.createRequestModel.anhKhachHang = repo.data?.first?.url ?? ""
            }, failureBlock: { (repo) in
                print("FAILURE")
            }, isShowErrorMessage: false)
        }) { (progress) in
            print("uploadImage_progress")
            print(progress)
        }
    }
}
