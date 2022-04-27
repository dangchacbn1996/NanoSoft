//
//  ChangePasswordViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 20/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ChangePasswordViewController: BaseViewController<ChangePasswordPresenter> {
    // MARK: - IBOutlet
    
    @IBOutlet weak var currentPasswordTextfield: MyTextField!
    
    @IBOutlet weak var newPasswordTextfield: MyTextField!
    
    @IBOutlet weak var nextButton: MyGradientButton!
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = ChangePasswordPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Đổi mật khẩu"
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewChangePassword) {

    }
    
    // MARK: - Action Button
    
    @IBAction func nextButtonAction(_ sender: Any) {
        self.presenter?.request.matKhau = self.currentPasswordTextfield.text
        self.presenter?.request.matKhauMoi = self.newPasswordTextfield.text
        self.presenter?.services()
    }
}

// MARK: - Protocol of Presenter
extension ChangePasswordViewController: ChangePasswordVC {
    func alertVC(title: String) {
        self.alertOneActionButton(title: "Đăng xuất", description: title) {
            UserDefaults.standard.removeObject(forKey: "CustomerProfileOptionalResponse")
            guard let rootVC = UIStoryboard.init(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
                return
            }
            let navigationController = UINavigationController(rootViewController: rootVC)

            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    func initData(data: ViewChangePassword) {
    }
    
    func reloadData() {
    }
}


