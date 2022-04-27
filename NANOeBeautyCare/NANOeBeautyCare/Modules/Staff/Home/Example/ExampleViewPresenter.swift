//
//  ExampleViewPresenter.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 26/03/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

protocol BaseExampleView {
    func initData(_ data: CustomerDetailOptionalResponse)
}

class ExampleViewPresenter: BasePresenter<BaseExampleView> {
      
}
