//
//  CustomerAppointmentPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerAppointmentVC: BaseView {
    func initData(data:ViewCustomerAppointment)
    func reloadData()
}


class CustomerAppointmentPresenter: BasePresenter<CustomerAppointmentVC> {
    private let service = CustomerAppointmentService()
    
    // MARK - Private Function
    

    func initDataPresent() {
        self.services()
    }
    
    func services() {
        // Loading.startAnimation()
        // self.service.getCustomerAppointment { (response, status, code) in
        //     Loading.stopAnimation()
        //     if status == true {
        //         guard let repo = response as? CustomerAppointmentResponse else {
        //             return
        //         }
        //         if repo.success == true {
        //             // BaseShareDataModel.shared.rawCommon = repo
        //         } else {
        //             // self.service.showError(message: repo.message ?? "")
        //         }
        //     } else {
        //         // self.service.showError(message: code.debugDescription)
        //     }
        // }
    }
}
