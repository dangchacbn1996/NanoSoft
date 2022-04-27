//
//  ForgotPasswordViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: BaseViewController<ForgotPasswordPresenter> {
    // MARK: - IBOutlet
    
    @IBOutlet weak var phoneTextfield: MyTextField!
    @IBOutlet weak var nextButton: MyGradientButton!
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = ForgotPasswordPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.ForgotPassword".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        
        let gradient = CAGradientLayer()
        var bounds = self.navigationController?.navigationBar.bounds
        bounds?.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds ?? CGRect.zero
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            self.navigationController?.navigationBar.shouldRemoveShadow(true)
            self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
            self.navigationController?.navigationBar.layoutIfNeeded()
            
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewForgotPassword) {

    }
    
    // MARK: - Action Button
    @IBAction func nextButtonAction(_ sender: Any) {
        self.presenter?.request.taiKhoan = self.phoneTextfield.text
        self.presenter?.services()
    }
    
}

// MARK: - Protocol of Presenter
extension ForgotPasswordViewController: ForgotPasswordVC {
    func alertVC(title: String) {
        self.alertOneActionButton(title: "Đóng", description: title) {
            self.backToPrevScreen()
        }
    }
    
    func initData(data: ViewForgotPassword) {
    }
    
    func reloadData() {
    }
}


