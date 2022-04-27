//
//  AppointmentPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol AppointmentVC: BaseView {
    func initData(data:[ViewAppointment])
    func reloadData()
    func resetData()
}


class AppointmentPresenter: BasePresenter<AppointmentVC> {
    private let service = AppointmentService()
    
    // MARK - Private Function
    var requestData = AppointmentRequest()
    var backContext: AppointmentRequest?
    
    var isReload: Bool?
    func initDataPresent() {
        self.appointmentScheduleService()
    }
    
    func originalAppointment() {
        self.requestData = AppointmentRequest()
        self.appointmentScheduleService()
    }
    
    func appointmentScheduleService() {
        self.service.appointmentScheduleService(requestData: self.requestData, callBack: { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [AppointmentOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                var dictFilter :[String: [AppointmentOptionalResponse]] = [:]
                if let items = repo.data {
                    for item in items {
                        if let createAt = item.ngayTao {
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
                
                var datas: [ViewAppointment] = []
                var names = dictFilter.map { return $0.key }
                names.sort { (stringFirst, stringSen) -> Bool in
                    let dateFirst = stringFirst.setStringToDate(formatCurrent: "dd/MM/yyyy")
                    let dateSe = stringSen.setStringToDate(formatCurrent: "dd/MM/yyyy")
                    if let dF = dateFirst, let dS = dateSe {
                        return dF > dS
                    } else {
                        return false
                    }
                }
                for item in names {
                    if let data = dictFilter[item] {
                        var datass = data
                        //                            datass.sort { (stringFirst, stringSen) -> Bool in
                        //                                let dateFirst = stringFirst.ngayTao?.setStringToDate(formatCurrent: "dd/MM/yyyy")
                        //                                let dateSe = stringSen.ngayTao?.setStringToDate(formatCurrent: "dd/MM/yyyy")
                        //                                if let dF = dateFirst, let dS = dateSe {
                        //                                    return dF < dS
                        //                                } else {
                        //                                    return true
                        //                                }
                        //                            }
                        let cellData = datass.map { (model) -> CellViewAppointment in
                            return CellViewAppointment((identifier: AppointmentTableViewCell.identfier, height: UITableView.automaticDimension, model: model))
                        }
                        
                        datas.append(ViewAppointment((identifier: AppointmentTableViewHeaderFooterView.identfier, height: 50.0, model: HeaderCellDataViewAppointment(title: item)), nil, cellData))
                    }
                }
                
                self.viewController?.initData(data: datas)
                self.viewController?.reloadData()
            }) { (repo) in
                
            }
        })
    }
    
    func createButton() {
        self.viewController?.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext([:]))
    }
    
    func detailAppointment(item: AppointmentOptionalResponse) {
        self.viewController?.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext([RVContext:item]))
    }

    func openFilter() {
        self.viewController?.openChildScreen(.AppointmentFilterViewController, fromStoryboard: .Appointment, withContext: RouteContext([RVContext:self.requestData]))
    }
    
    func updateBackContextData(context: RouteContext) {
        self.backContext = context[RVBackContext]
        if let backModel = self.backContext {
            self.requestData = backModel
            self.viewController?.resetData()
            self.appointmentScheduleService()
        }
        
        self.isReload = context[RVIsReload]
        if let isR = self.isReload {
            if isR == true {
                self.viewController?.resetData()
                self.appointmentScheduleService()
            }
        }
    }
}
