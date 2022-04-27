//
//  DetailTreatmentPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol DetailTreatmentVC: BaseView {
    func initData(data:[DetailTreatmentOptionalResponse])
    func updateHeaderData(data: TreatmentOptionalResponse)
    func reloadData()
}


class DetailTreatmentPresenter: BasePresenter<DetailTreatmentVC> {
    private let service = DetailTreatmentService()
    
    // MARK - Private Function
    var dataContext: TreatmentOptionalResponse?

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        if let data = self.dataContext {
            self.viewController?.updateHeaderData(data: data)
            self.callService()
        }
    }

    func callService() {
        if let data = self.dataContext {
            self.services(request: DetailTreatmentRequest(dichVuID: data.idDichVu, hoSoID: data.hoSoID))
        }
    }
    func services(request: DetailTreatmentRequest, page: UInt = kDefaultStartPage) {
        self.service.currentTreatmentService(requestData: request) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [DetailTreatmentOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.viewController?.initData(data: data)
                    self.viewController?.reloadData()
                }
                self.viewController?.reloadData()
            }) { (repo) in

            }
        }
    }
}
