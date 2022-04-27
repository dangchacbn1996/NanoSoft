//
//  CustomerHomeNewsPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/10/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol CustomerHomeNewsVC: BaseView {
    func initData(data:[ViewCustomerHomeNews])
    func reloadData()
}


class CustomerHomeNewsPresenter: BasePresenter<CustomerHomeNewsVC> {
    private let service = CustomerHomeNewsService()
    
    // MARK - Private Function
    var dataContext: NewCustomerHomeOptionalResponse?
    var dataDetailContext: DanhSachTinTucLienQuan?
    var data: [ViewCustomerHomeNews] = []

    func initDataPresent() {
        self.dataContext = context?[RVContext]
        self.dataDetailContext = context?["RVContextDetail"]
        if let dataContext = self.dataContext {
            self.services(idNews: dataContext.idNews ?? -1)
        } else {
            if let dataDetail = self.dataDetailContext {
                self.services(idNews: dataDetail.idNews ?? -1)
            }
        }
    }
    
    func services(idNews: Int) {
        self.service.newsCustomerDetailService(requestData: CustomerHomeNewsRequest(idNews: idNews), callBack: { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CustomerHomeNewsOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                self.data.removeAll()

                let firstCell = CellViewCustomerHomeNews((identifier: TextCustomerHomeNewsDetailTableViewCell.identfier, height: UITableView.automaticDimension, model: CellDataCustomerHomeNews(model: repo.data, newsRe: nil)))

                self.data.append(ViewCustomerHomeNews(nil, nil, [firstCell]))

                var dataNewsArray: [CellViewCustomerHomeNews] = []
                if let dataNews = repo.data?.danhSachTinTucLienQuan {
                    for item in dataNews {
                        let newsCell = CellViewCustomerHomeNews((identifier: ListCustomerHomeNewsDetailTableViewCell.identfier, height: 150.0, model: CellDataCustomerHomeNews(model: repo.data, newsRe: item)))
                        dataNewsArray.append(newsCell)
                    }
                    self.data.append(ViewCustomerHomeNews(nil, nil, dataNewsArray))
                }

                self.viewController?.initData(data: self.data)
                self.viewController?.reloadData()

            }) { (repo) in
            }
        })
    }
}
