//
//  SplashViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController<SplashPresenter> {
    // MARK: - IBOutlet
    
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = SplashPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.Splash".localized
        self.presenter?.initDataPresent()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//            self.setRootScreen(.SignInViewController, isUseRootNavigation: true, fromStoryboard: .SignIn)
//        }
        self.presenter?.autoSignIn()
    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension SplashViewController: SplashVC {
    func initData(data: ViewSplash) {
    }
    
    func reloadData() {
    }
}


