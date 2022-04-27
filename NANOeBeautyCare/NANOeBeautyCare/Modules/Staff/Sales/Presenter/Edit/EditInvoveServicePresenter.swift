//
//  EditInvoveServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/15/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol EditInvoveServiceVC: BaseView {
    func initData(data:FooterService)
    func reloadData()
    func updateSeria(model: SeriaDiscountOptionalResponse)
    func updatePointMember(model: PointMemberOptionalResponse)
    func updateTransferPointMember(model: TransferPointMemberOptionalResponse)
}


class EditInvoveServicePresenter: BasePresenter<EditInvoveServiceVC> {
    private let service = EditInvoveServiceService()
    
    // MARK - Private Function
    var dataContext: FooterService?
    var dataCustomerContext: SearchCustomerAppointmentOptionalResponse?
    var modelRequest = SeriaDiscountRequest(id: 0, loai: "HO_SO", maKhuyenMai: "")
    var modelPointMember = PointMemberRequest(khachHangID: -1)
    var modelTransferPointMember = TransferPointMemberRequest(khachHangID: -1, soDiemQuyDoi: 0)
    
    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.viewController?.initData(data: data)
            self.listPromition(requestData: CheckProductExited(id: 0, loai: "HO_SO"))
        }
        self.dataCustomerContext = context?["RVCustomer"]
        if let data = self.dataCustomerContext {
            self.modelPointMember.khachHangID = data.id
            self.modelTransferPointMember.khachHangID = data.id
            self.pointMemberSerivceChecked()
        }
    }
    
    func services(model: FooterService) {
        self.viewController?.backToPrevScreen(with: RouteContext(["BackFooterServiceContext": model]))
    }
    
    func listPromition(requestData: CheckProductExited) {
        self.service.listPromotionService(requestData: requestData) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [PromotionProductOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                print("----12313123")
                UserDefaults.standard.df.store(repo.data, forKey: String(describing: [PromotionProductOptionalResponse].self))
            }) { (model) in
                
            }
        }
    }

    func seriaDiscountChecked() {
        self.service.seriaDiscountService(requestData: self.modelRequest) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: SeriaDiscountOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let model = repo.data {
                    self.viewController?.updateSeria(model: model)
                }
            }) { (model) in

            }
        }
    }

    func pointMemberSerivceChecked() {
        self.service.pointMemberSerivce(requestData: self.modelPointMember) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: PointMemberOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let model = repo.data {
                    self.viewController?.updatePointMember(model: model)
                }
            }) { (model) in

            }
        }
    }

    func pointTransferMemberSerivceChecked() {
        self.service.transferPointMemberSerivce(requestData: self.modelTransferPointMember) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: TransferPointMemberOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let model = repo.data {
                    self.viewController?.updateTransferPointMember(model: model)
                }
            }) { (model) in

            }
        }
    }
}
