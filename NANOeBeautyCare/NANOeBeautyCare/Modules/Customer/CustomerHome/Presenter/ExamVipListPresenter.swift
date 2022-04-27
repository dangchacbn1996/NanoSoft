//
//  ExamVipListPresenter.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 03/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

protocol ExamVipVC: BaseView {
    func initData(data:[ViewCustomerHome])
}


class ExamVipListPresenter: BasePresenter<ExamVipVC> {
    func initDataPresent() {
        
    }
}
