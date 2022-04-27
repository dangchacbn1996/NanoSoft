//
//  CustomerProfilePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerProfileVC: BaseView {
    func initData(data:CustomerDetailOptionalResponse)
    func reloadData()
}


class CustomerProfilePresenter: BasePresenter<CustomerProfileVC> {
    private let service = CustomerProfileService()
    
    // MARK - Private Function
    var dataService: CustomerDetailOptionalResponse?
    var idx: Int = 0

    func initDataPresent() {
        if let idx = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)?.id {
            self.idx = idx
            self.services(idx: idx)
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
    
    func loadKhaiBao(isOn: Bool, time: String?, completion: @escaping () -> Void) {
        service.hospitalChangeRemindTime(requestData: CustomerProfileService.HospitalNhacLichModel(ID: idx, IsNhacLichThongBao: isOn, GioNhacLich: time))
        { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CustomerDetailOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.dataService = data
                    completion()
                }
            }) { (repo) in
                
            }
        }
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

}
