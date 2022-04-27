//
//  SplashPresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

protocol SplashVC: BaseView {
    func initData(data:ViewSplash)
    func reloadData()
}


class SplashPresenter: BasePresenter<SplashVC> {
    private let service = SplashService()
    
    // MARK - Private Function
    
    
    func initDataPresent() {

    }
    
    func services() {
        //        Loading.startAnimation()
        //        self.service.getSplash { (response, status, code) in
        //            Loading.stopAnimation()
        //            if status == true {
        //                guard let repo = response as? SplashResponse else {
        //                    return
        //                }
        //                if repo.success == true {
        //                    // BaseShareDataModel.shared.rawCommon = repo
        //                } else {
        //                    // self.service.showError(message: repo.message ?? "")
        //                }
        //            } else {
        //                // self.service.showError(message: code.debugDescription)
        //            }
        //        }
    }
    func signInWithGuest() {
        let brandType = Common.BRAND_TYPE
        if brandType == BrandTypeEnum.Staff.rawValue {
            self.goToHome()
        } else {
            self.goToCustomerHome()
        }
    }
    
    func autoSignIn() {
//        if Common.IS_GUEST == true {
//            self.signInWithGuest()
//        } else {
            let brandType = Common.BRAND_TYPE
            if brandType == BrandTypeEnum.Staff.rawValue {
                if let modelRequest =  UserDefaults.standard.df.fetch(forKey: String(describing: SignInRequest.self), type: SignInRequest.self) {
                    Loading.startAnimation()
                    self.service.postSignInStaffService (request: modelRequest){ (response, status, code) in
                        Loading.stopAnimation()
                        if status == true {
                            guard let repo = response as? SignInOptionalResponse else {
                                return
                            }
                            if repo.code == 1 {
                                let model = transformationSignInResponse(model: repo)
                                //                            UserDefaults.standard.df.store(model.data.sid, forKey: UserDefaultEnum.BRAND_SID.rawValue)
                                //                            UserDefaults.standard.df.store(model.data.username, forKey: UserDefaultEnum.BRAND_USER.rawValue)
                                UserDefaults.standard.df.store(model.data, forKey: String(describing: SignInResponseDataClass.self))
                                self.goToHome()
                            } else {
                                self.goToSignIn()
                            }
                        } else {
                            self.goToSignIn()
                        }
                    }
                } else {
                    self.goToSignIn()
                }
            } else {
                if let modelRequest =  UserDefaults.standard.df.fetch(forKey: String(describing: SignInRequest.self), type: SignInRequest.self) {
                    self.service.postSignInCustomerService (request: modelRequest){ (response, status, code) in
                        Loading.stopAnimation()
                        if status == true {
                            guard let repo = response as? ModelBaseService<CustomerProfileOptionalResponse> else {
                                return
                            }
                            if repo.code == 1 {
                                UserDefaults.standard.df.store(repo.data, forKey: String(describing: CustomerProfileOptionalResponse.self))
                                SessionManager.shared.userInfo = repo.data
                                self.goToCustomerHome()
                            } else {
                                self.goToSignIn()
                            }
                        } else {
                            self.goToSignIn()
                        }
                    }
                } else {
                    self.goToSignIn()
                }
            }
//        }
    }
    
    func goToSignIn() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewController?.setRootScreen(.SignInViewController, isUseRootNavigation: true, fromStoryboard: .SignIn, withContext: RouteContext([:]))
        }
    }
    
    func goToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.viewController?.setRootScreen(.MyTabBarViewController, isUseRootNavigation: false, fromStoryboard: .Home, withContext: RouteContext([:]))
        }
    }

    func goToCustomerHome() {
//        self.viewController?.setRootScreen(.CustomerTabBarViewController, isUseRootNavigation: false, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
        self.viewController?.setRootScreen(HospitalMainTabbarViewController(), isUseRootNavigation: false, withContext: RouteContext([:]))
    }
}
