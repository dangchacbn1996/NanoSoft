//
//  SignInViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController<SignInPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var infomationLabel: UILabel!
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var nextButton: MyGradientButton!
    @IBOutlet weak var usernameTextfield: MyTextField!
    @IBOutlet weak var passwordTextfield: MyTextField!
//    @IBOutlet weak var vContainer = UIView()
    
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var btnSavePass: UIButton!
    var isRemember: Bool = false {
        didSet {
            btnSavePass.imageView?.tintColor = isRemember ? AppColors.primaryColor : UIColor.lightGray
        }
    }
    var keychain = "nanoKeyChain"
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = SignInPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.SignIn".localized
        self.presenter?.initDataPresent()
//        if let _ = UserDefaults.standard.value(forKey: UserDefaultEnum.SavePass) {
//            if let password = try? viewModel.existedKeychainItem?.readPassword() {
//                if password != nil && password != "" && password != "NULL" {
//                    passwordTextfield.text = password
//                    self.viewModel.isSavePassword = true
//                }
//            }
//        }
        
        if (UserDefaults.standard.object(forKey: keychain) != nil) {
            let userAcc = UserDefaults.standard.string(forKey: keychain)
            usernameTextfield.text = userAcc!
            presenter?.modelRequest.user = userAcc!
            loadPasswordFromKeychainAuthenticateUser(userName: userAcc!) { (pass) in
                if (pass != nil && pass != "") {
                    self.passwordTextfield.text = pass
                    self.presenter?.modelRequest.password = pass ?? ""
                    self.isRemember = true
//                    DefaultValues.instancePass = pass!
//                    if (UserDefaults.standard.value(forKey: UserDefaultKey.session.rawValue) != nil) {
//                        DataManager.instance.userInfo = CheckLoginModelItem()
//                        DataManager.instance.userInfo.user = UserDefaults.standard.string(forKey: UserDefaultKey.user.rawValue)
//                        DataManager.instance.userInfo.sid = UserDefaults.standard.string(forKey: UserDefaultKey.session.rawValue)
//                        DataManager.instance.userInfo.name = UserDefaults.standard.string(forKey: UserDefaultKey.username.rawValue)
//                        DataManager.instance.userInfo.key = UserDefaults.standard.string(forKey: UserDefaultKey.key.rawValue)
//                        DataManager.instance.userInfo.defaultAcc = UserDefaults.standard.string(forKey: UserDefaultKey.defaultaccount.rawValue)
//                    }
                } else {
                    self.isRemember = false
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) { // As soon as vc appears
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        if Common.BRAND_NAME.count > 0 && Common.BRAND_LOGO.count > 0 {
            self.avartaImageview.pictureLogoImageView(url: Common.BRAND_LOGO)
            self.infomationLabel.text = Common.BRAND_NAME
        } else {
            self.avartaImageview.image = UIImage(named: "ic-logo-app")
            self.infomationLabel.text = "SignIn.Slogan".localize()
        }
        self.infomationLabel.text = "SignIn.Slogan".localize()
//        presenter?.goToCustomerHome()
//        return
        
        if Common.HOST.count == 0 {
            self.openChildScreen(.ServerSettingViewController, fromStoryboard: .SignIn)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewSignIn) {
        
    }
    
    // MARK: - Action Button
    @IBAction func nextButton(_ sender: Any) {
//        presenter?.goToCustomerHome()
//        return
        if Common.HOST.count > 0 {
            if validateTextfieldEmpty(titleTextfield: "SignIn.Username".localize(), textfieldValidate: self.usernameTextfield) && validateTextfieldEmpty(titleTextfield: "SignIn.Password".localize(), textfieldValidate: self.passwordTextfield) {
                let account = usernameTextfield.text!
                var lastAccess = "lastAccess"
                if (isRemember) {
                    saveAccountToKeychain(userName: account, keyUser: keychain, password: passwordTextfield.text!, finished: nil)
                    //Check tai khoan Luu mat khau va van tay co giong nhau
                    if (UserDefaults.standard.object(forKey: lastAccess) != nil) {
                        if (UserDefaults.standard.string(forKey: lastAccess) == account) {
                            //Trung ten tai khoan -> check trung password
                            loadPasswordFromKeychainAuthenticateUser(userName: account) { (pass) in
                                if (pass != self.passwordTextfield.text!) {
                                    //Khac mat khau -> Remove trong van tay
                                    UserDefaults.standard.removeObject(forKey: lastAccess)
                                }
                            }
                        } else {
                            //Khac ten tai khoan -> Remove trong van tay
                            UserDefaults.standard.removeObject(forKey: lastAccess)
                        }
                    }
                } else {
                    if (UserDefaults.standard.object(forKey: lastAccess) != nil) {
                        if (UserDefaults.standard.string(forKey: lastAccess) != account) {
                            UserDefaults.standard.removeObject(forKey: lastAccess)
                        }
                    }
                    saveAccountToKeychain(userName: account, keyUser: keychain, password: "", finished: nil)
                }
                self.presenter?.signInService()
            }
        } else {
            self.openChildScreen(.ServerSettingViewController, fromStoryboard: .SignIn)
        }
    }
    @IBAction func settingButton(_ sender: Any) {
        self.openChildScreen(.ServerSettingViewController, fromStoryboard: .SignIn)
    }
    
    @IBAction func guestButtonAction(_ sender: Any) {
        self.presenter?.signInWithGuest()
        
    }
    
    @IBAction func tapRemember() {
        self.isRemember = !isRemember
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        self.openChildScreen(.ForgotPasswordViewController, fromStoryboard: .SignIn)
    }
    
    @IBAction func actRegister() {
//        self.openChildScreen(RegisterViewController())
        self.openChildScreen(.CustomerSignUpViewController, fromStoryboard: .CustomerHome)
    }
    
}

// MARK: - Protocol of Presenter
extension SignInViewController: SignInVC {
    func initData(data: ViewSignIn) {
    }
    
    func reloadData() {
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.usernameTextfield {
            self.presenter?.modelRequest.user = textField.text ?? ""
        } else if textField == self.passwordTextfield {
            self.presenter?.modelRequest.password = textField.text ?? ""
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

