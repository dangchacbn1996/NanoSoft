//
//  CustomerTreatmentPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerTreatmentVC: BaseView {
    func initData(data:ViewCustomerTreatment)
    func reloadData()
}


class CustomerTreatmentPresenter: BasePresenter<CustomerTreatmentVC> {
    private let service = CustomerTreatmentService()
    
    // MARK - Private Function
    

    func initDataPresent() {
        self.services()
    }
    
    func services() {
        // Loading.startAnimation()
        // self.service.getCustomerTreatment { (response, status, code) in
        //     Loading.stopAnimation()
        //     if status == true {
        //         guard let repo = response as? CustomerTreatmentResponse else {
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
