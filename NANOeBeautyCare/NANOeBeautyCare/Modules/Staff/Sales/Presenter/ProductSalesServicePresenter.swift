//
//  ProductSalesServicePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol ProductSalesServiceVC: BaseView {
    func initData(data:ViewProductSalesService)
    func reloadData()
    func updateCheckStatus(idSP: Int?, indexPath: IndexPath, data: CheckProductOptionalResponse?)
}


class ProductSalesServicePresenter: BasePresenter<ProductSalesServiceVC> {
    private let service = ProductSalesServiceService()
    private let group = DispatchGroup()
    // MARK - Private Function
    var model: ViewProductSalesService = ViewProductSalesService()
    var dataContext: [ViewCreateSale]?
    func initDataPresent() {
        self.dataContext = context?[RVContext]
        self.services()
        group.notify(queue: .main) {
            self.viewController?.initData(data: self.model)
            self.viewController?.reloadData()
        }
    }
    
    func services() {
        self.serviceProduct()
        self.catalogProduct()
        self.cardProduct()
    }
    
    func serviceCheckProduct(idSP: Int?, index: IndexPath) {
        self.service.checkProduct(requestData: CheckProductRequest(sanPhamID: idSP)) { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CheckProductOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.viewController?.updateCheckStatus(idSP: idSP, indexPath: index, data: repo.data)
                
            }) { (model) in
                
            }
        }
    }
    
    func serviceProduct(model: ServiceProductRequest = ServiceProductRequest()) {
        group.enter()
        self.service.serviceProduct(requestData: model) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [ServiceProductOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.model.serviceProduct = data
                    self.updateServiceProduct()
                }
                self.group.leave()
            }) { (model) in
                self.group.leave()
            }
        }
    }
    
    func catalogProduct(model: CatalogProductRequest = CatalogProductRequest()) {
        group.enter()
        self.service.catalogProduct(requestData: model) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [CatalogProductOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.model.catalogProduct = data
                    self.updateCatalogProduct()
                }
                self.group.leave()
            }) { (model) in
                self.group.leave()
            }
        }
    }
    
    func cardProduct(model: CardProductRequest = CardProductRequest()) {
        group.enter()
        self.service.cardProduct(requestData: model) { (response, status, code) in
            self.service.handleArrayStatus(modelOptionalResponse: [CardProductOptionalResponse].self, response: response, status, code, successBlock: { (repo) in
                if let data = repo.data {
                    self.model.cardProduct = data
                    self.updateCardProduct()
                }
                self.group.leave()
            }) { (model) in
                self.group.leave()
            }
        }
    }
    
    func updateServiceProduct() {
        //        DICH_VU
        if let datas = self.dataContext?[CreateSaleTableSectionEnum.Body.rawValue].items {
            for itemRoot in datas {
                if itemRoot.property?.model?.listService?.loai ==  "DICH_VU" {
                    if let items = self.model.serviceProduct {
                        for (index,item) in items.enumerated() {
                            if itemRoot.property?.model?.listService?.id == item.idDichVu {
                                let selected = self.model.serviceProduct?[index].isSelected ?? false
                                self.model.serviceProduct?[index].isSelected = !selected
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateCatalogProduct() {
        //
        if let datas = self.dataContext?[CreateSaleTableSectionEnum.Body.rawValue].items {
            for itemRoot in datas {
                if itemRoot.property?.model?.listService?.loai ==  "SAN_PHAM" {
                    if let items = self.model.catalogProduct {
                        for (index,item) in items.enumerated() {
                            if itemRoot.property?.model?.listService?.id == item.id {
                                let selected = self.model.catalogProduct?[index].isSelected ?? false
                                self.model.catalogProduct?[index].isSelected = !selected
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateCardProduct() {
        //        HO_SO
        if let datas = self.dataContext?[CreateSaleTableSectionEnum.Body.rawValue].items {
            for itemRoot in datas {
                if itemRoot.property?.model?.listService?.loai ==  "HO_SO" {
                    if let items = self.model.cardProduct {
                        for (index,item) in items.enumerated() {
                            if itemRoot.property?.model?.listService?.id == item.idTheDichVu {
                                let selected = self.model.cardProduct?[index].isSelected ?? false
                                self.model.cardProduct?[index].isSelected = !selected
                            }
                        }
                    }
                }
            }
        }
    }
    
}
