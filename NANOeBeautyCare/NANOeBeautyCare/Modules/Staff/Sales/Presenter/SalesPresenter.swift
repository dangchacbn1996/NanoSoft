//
//  SalesPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol SalesVC: BaseView {
    func initData(data:[ViewSales])
    func reloadData()
    func resetData()
}


class SalesPresenter: BasePresenter<SalesVC> {
    private let service = SalesService()

    
    // MARK - Private Function
    var requestData = SalesRequest()
    var backContext: SalesRequest?
    var isReload: Bool?

    func initDataPresent() {
        self.services()
    }
    
    func services() {
        self.service.listSaleService(requestData: self.requestData) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [SalesOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                var dictFilter :[String: [SalesOptionalResponse]] = [:]
                if let items = repo.data {
                    for item in items {
                        if let createAt = item.ngayDen {
                            if dictFilter[createAt] == nil {
                                dictFilter[createAt] = [item]
                            } else {
                                dictFilter[createAt]?.append(item)
                            }
                        } else {
                            if dictFilter["Nothing"] == nil {
                                dictFilter["Nothing"] = [item]
                            } else {
                                dictFilter["Nothing"]?.append(item)
                            }
                        }
                    }
                }

                var datas: [ViewSales] = []
                var names = dictFilter.map { return $0.key }
                names.sort { (stringFirst, stringSen) -> Bool in
                    let dateFirst = stringFirst.setStringToDate(formatCurrent: "HH:mm dd/MM/yyyy")
                    let dateSe = stringSen.setStringToDate(formatCurrent: "HH:mm dd/MM/yyyy")
                    if let dF = dateFirst, let dS = dateSe {
                        return dF > dS
                    } else {
                        return false
                    }
                }
                for item in names {
                    if let data = dictFilter[item] {
                        var datass = data
                        let cellData = datass.map { (model) -> CellViewSales in
                            return CellViewSales((identifier: SalesTableViewCell.identfier, height: UITableView.automaticDimension, model: model))
                        }

                        datas.append(ViewSales((identifier: SalesTableViewHeaderFooterView.identfier, height: 50.0, model: HeaderCellDataViewAppointment(title: item)), nil, cellData))
                    }
                }

                self.viewController?.initData(data: datas)
                self.viewController?.reloadData()
            }) { (model) in

            }
        }
    }

    func createSales() {
        self.viewController?.openChildScreen(.CreateSaleServiceViewController, fromStoryboard: .Sales, withContext: RouteContext([:]))
    }

    func detail(item: SalesOptionalResponse) {
        self.viewController?.openChildScreen(.CreateSaleServiceViewController, fromStoryboard: .Sales, withContext: RouteContext(["IDService":item.idHoSo]))
    }


    func originalService() {
        requestData = SalesRequest()
        self.services()
    }

    func openFilter() {
        self.viewController?.openChildScreen(.SalesFilterViewController, fromStoryboard: .Sales, withContext: RouteContext([RVContext:self.requestData]))
    }

    func updateBackContextData(context: RouteContext) {
        self.backContext = context[RVBackContext]
        if let backModel = self.backContext {
            self.requestData = backModel
            self.viewController?.resetData()
            self.services()
        }

        self.isReload = context[RVIsReload]
        if let isReload = self.isReload {
            if isReload == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.viewController?.resetData()
                    self.originalService()
                }
            }
        }
    }
}
