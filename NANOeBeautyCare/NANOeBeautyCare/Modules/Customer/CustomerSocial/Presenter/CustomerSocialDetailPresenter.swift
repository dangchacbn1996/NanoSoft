//
//  CustomerSocialDetailPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerSocialDetailVC: BaseView {
    func initData(data: [ViewCustomerSocialDetail])
    func reloadData()
}


class CustomerSocialDetailPresenter: BasePresenter<CustomerSocialDetailVC> {
    private let service = CustomerSocialDetailService()
    
    // MARK - Private Function
    var dataContext: CustomerSocialOptionalResponse?
    var requestData = CustomerSocialDetailRequest()

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let model = self.dataContext {
            self.requestData.idCauHoi = model.idCauHoi
        }
        //        self.services()
        self.originCustomerService()
    }

    func originCustomerService() {
        self.requestData = CustomerSocialDetailRequest()
        if let model = self.dataContext {
            self.requestData.idCauHoi = model.idCauHoi
        }
        self.socialQuestionService()
    }
    func socialQuestionService() {
        self.service.catalogQuestionDetailService(requestData: self.requestData, callBack: { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CustomerSocialDetailOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                if let model = repo.data {
                    let firstCellModel = CustomerSocialDetailTableViewCell(idCauHoi: model.idCauHoi, idNhomChuDe: model.idNhomChuDe, noiDungCauHoi: model.noiDungCauHoi, khachHangId: model.khachHangId, tenPhongBan: model.tenPhongBan, maPhongBan: model.maPhongBan, ngayTao: model.ngayTao, hoTen: model.hoTen, dienThoai: model.dienThoai, email: model.email, cauTraLoi: nil)
                    let firstCell = CellViewCustomerSocialDetail((identifier: CustomerQuestionTableViewCell.identfier, height: UITableView.automaticDimension, model: firstCellModel))

                    var arrayDataCell:[CellViewCustomerSocialDetail] = []
                    arrayDataCell.append(firstCell)
                    
                    var arraySectionDataCell:[CellViewCustomerSocialDetail] = []

                    if let modelQuestion = model.cauTraLoi {
                        for item in modelQuestion {
                            arraySectionDataCell.append(CellViewCustomerSocialDetail((identifier: CustomerAnserTableViewCell.identfier, height:  UITableView.automaticDimension, model: CustomerSocialDetailTableViewCell(idCauHoi: model.idCauHoi, idNhomChuDe: model.idNhomChuDe, noiDungCauHoi: model.noiDungCauHoi, khachHangId: model.khachHangId, tenPhongBan: model.tenPhongBan, maPhongBan: model.maPhongBan, ngayTao: model.ngayTao, hoTen: model.hoTen, dienThoai: model.dienThoai, email: model.email, cauTraLoi: item))))

                        }
                    }
                    
                    self.viewController?.initData(data: [ViewCustomerSocialDetail(nil, nil, arrayDataCell), ViewCustomerSocialDetail(nil, nil, arraySectionDataCell)])
                    self.viewController?.reloadData()
                }
            }) { (repo) in

            }
        })
    }
}
