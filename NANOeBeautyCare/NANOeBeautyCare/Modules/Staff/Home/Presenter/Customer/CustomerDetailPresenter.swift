//
//  CustomerDetailPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerDetailVC: BaseView {
    func initData(data:CustomerDetailOptionalResponse)
    func reloadData()
}


class CustomerDetailPresenter: BasePresenter<CustomerDetailVC> {
    private let service = CustomerDetailService()
    
    // MARK - Private Function
    var dataContext: HomeOptionalResponse?
    var dataService: CustomerDetailOptionalResponse?

    var dataUpdateContext: CustomerDetailOptionalResponse?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.services(idx: data.id)
        }
    }
    
    func services(idx: Int?) {
        self.service.customerDetailService(model: CustomerDetailRequest(id: idx), callBack: { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CustomerDetailOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.dataService = data
                    self.viewController?.initData(data: data)
                }
            }) { (repo) in

            }
        })
    }

    func goToMore() {
        if let data = self.dataService {
            self.viewController?.openChildScreen(.CustomerDetailMoreViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext:data]))
        }
    }

    func goToHistory() {
        if let data = self.dataService {
            self.viewController?.openChildScreen(.CustomerDetailHistoryViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext:data]))
        }
    }

    func updateCustomer() {
        if let data = self.dataService {
            self.viewController?.openChildScreen(.CreateCustomerViewController, fromStoryboard: .Home, withContext: RouteContext([RVContext:data, "IsUpdate": true]))
        }
    }

    func updatePanData(context: RouteContext) {
        self.dataUpdateContext = context["UpdataData"]
        if let dataUpdate = self.dataUpdateContext {
            self.dataService?.ngaySinh = dataUpdate.ngaySinh?.setStringToDate(formatCurrent: "dd/MM/yyyy HH:mm:ss")?.getFormattedDate(format: "dd/MM/yyyy")
            self.dataService?.tenGioiTinh = dataUpdate.tenGioiTinh
            self.dataService?.anhKhachHang = dataUpdate.anhKhachHang
            self.dataService?.tenNguonDen = dataUpdate.tenNguonDen
            self.dataService?.hoTen = dataUpdate.hoTen
            self.dataService?.diaChi = dataUpdate.diaChi
            self.dataService?.ghiChu = dataUpdate.ghiChu
            self.dataService?.loaiKhachHang = dataUpdate.loaiKhachHang
            if let data = self.dataService {
                self.viewController?.initData(data: data)
            }
        }

    }

    
}
