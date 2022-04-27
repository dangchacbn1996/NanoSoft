//
//  SignInPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit
import Default

protocol SignInVC: BaseView {
    func initData(data:ViewSignIn)
    func reloadData()
}


class SignInPresenter: BasePresenter<SignInVC> {
    private let service = SignInService()
    
    // MARK - Private Function
    var modelRequest = SignInRequest(domain: "", loaiTaiKhoan: "", maCongTy: "", password: "", user: "")
    
    func initDataPresent() {
        self.services()
    }
    
    func services() {
        
    }
    
    func signInWithGuest() {
        self.goToCustomerHome()
        let data = GuestModel(isGuest: true)
        UserDefaults.standard.df.store(data, forKey: String(describing: GuestModel.self))
    }
    
    func signInService() {
        let data = GuestModel(isGuest: false)
        UserDefaults.standard.df.store(data, forKey: String(describing: GuestModel.self))
        
        let brandType = Common.BRAND_TYPE
        self.modelRequest.domain = Common.BRAND_DOMAIN
        self.modelRequest.loaiTaiKhoan = Common.BRAND_TYPE
        self.modelRequest.maCongTy = Common.BRAND_NUMBER
        Loading.startAnimation()
        if brandType == BrandTypeEnum.Staff.rawValue {
            self.service.postSignInStaffService (request: self.modelRequest){ (response, status, code) in
                Loading.stopAnimation()
                if status == true {
                    guard let repo = response as? SignInOptionalResponse else {
                        return
                    }
                    if repo.code == 1 {
                        let model = transformationSignInResponse(model: repo)
                        DispatchQueue.main.async {
                            UserDefaults.standard.df.store(model.data, forKey: String(describing: SignInResponseDataClass.self))
                            UserDefaults.standard.df.store(self.modelRequest, forKey: String(describing: SignInRequest.self))
                            self.service.loginMoreService(requestData: MoreWebViewRequest(), callBack: { (response, status, code) in
                                self.service.handleObjectStatus(modelOptionalResponse: MoreWebViewOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                    //                    self.viewController?.alertVC(title: repo.msg ?? "")
                                }) { (repo) in

                                }
                            })
                            self.goToHome()
                        }
                    } else {
                        self.service.showErrorString(text: repo.msg ?? "", action: {
                            
                        })
                    }
                } else {
                    self.service.showError(response: response)
                }
            }
        } else {
            self.service.postSignInCustomerService (request: self.modelRequest){ (response, status, code) in
                Loading.stopAnimation()
                if status == true {
                    guard let repo = response as? ModelBaseService<CustomerProfileOptionalResponse> else {
                        return
                    }
                    if repo.code == 1 {
                        SessionManager.shared.userInfo = repo.data
                        UserDefaults.standard.df.store(repo.data, forKey: String(describing: CustomerProfileOptionalResponse.self))
                        UserDefaults.standard.df.store(self.modelRequest, forKey: String(describing: SignInRequest.self))
                        self.service.loginMoreService(requestData: MoreWebViewRequest(), callBack: { (response, status, code) in
                            self.service.handleObjectStatus(modelOptionalResponse: MoreWebViewOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                //                    self.viewController?.alertVC(title: repo.msg ?? "")
                            }) { (repo) in

                            }
                        })
                        self.goToCustomerHome()
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
    
    func goToHome() {
        self.viewController?.setRootScreen(.MyTabBarViewController, isUseRootNavigation: false, fromStoryboard: .Home, withContext: RouteContext([:]))
    }

    func goToCustomerHome() {
            if let hostCurren = Common.HostCurrent {
                Common.Domain = hostCurren
            }
    //        self.viewController?.setRootScreen(.CustomerTabBarViewController, isUseRootNavigation: false, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
            self.viewController?.setRootScreen(HospitalMainTabbarViewController(), isUseRootNavigation: false, withContext: RouteContext([:]))

    }
}
