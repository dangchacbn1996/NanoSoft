//
//  ReportPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol ReportVC: BaseView {
    func initData(data:ViewReport)
    func reloadData()
}


class ReportPresenter: BasePresenter<ReportVC> {
    private let service = ReportService()
    
    // MARK - Private Function
    

    func initDataPresent() {
        self.services()
    }
    
    func services() {
        // Loading.startAnimation()
        // self.service.getReport { (response, status, code) in
        //     Loading.stopAnimation()
        //     if status == true {
        //         guard let repo = response as? ReportResponse else {
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
