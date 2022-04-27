//
//  DetailSalePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol DetailSaleVC: BaseView {
    func initData(data:ViewDetailSale)
    func reloadData()
}


class DetailSalePresenter: BasePresenter<DetailSaleVC> {
    private let service = DetailSaleService()
    
    // MARK - Private Function
    

    func initDataPresent() {
        self.services()
    }
    
    func services() {
       
    }
}
