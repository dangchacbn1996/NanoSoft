//
//  ServerSettingPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/3/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol ServerSettingVC: BaseView {
    func initData(data:[ServerSettingResponseDatum])
    func reloadData()
}


class ServerSettingPresenter: BasePresenter<ServerSettingVC> {
    private let service = ServerSettingService()
    
    // MARK - Private Function
    

    func initDataPresent() {
        self.services()
    }
    
    func services() {
        Loading.startAnimation()
        self.service.postAppServiceService { (response, status, code) in
            Loading.stopAnimation()
            if status == true {
                guard let repo = response as? ServerSettingOptionalResponse else {
                    return
                }
                if repo.code == 1 {
                    let model = transformationServerSettingResponse(model: repo)
                    
                    self.viewController?.initData(data: model.data)
                    UserDefaults.standard.df.store(model, forKey: String(describing: ServerSettingResponse.self))
                } else {
                    self.service.showErrorString(text: repo.msg ?? "", action: {
                        
                    })
                }
            } else {
                self.service.showError(response: response)
            }
        }
    }
}
