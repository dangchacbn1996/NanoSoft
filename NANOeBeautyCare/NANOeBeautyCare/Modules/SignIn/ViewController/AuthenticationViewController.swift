//
//  ViewController.swift
//  TouchIDTutorial
//
//  Created by Frederik Jacques on 30/09/15.
//  Copyright © 2015 Frederik Jacques. All rights reserved.
//

import UIKit
import LocalAuthentication
import AppleGenericKeychain

//class Authentication

protocol AuthenticationDelegate {
    func getViewController() -> (UIViewController)
}

extension SignInViewController {
    
    /**
        This method gets called when the users clicks on the
        login button in the user interface.
    
        - parameter sender: a reference to the button that has been touched
    */
//    func loginUseFingerPrint() {
//        loginUseFingerPrint(keyUser: UserDefaultAccount.baseLastUserFingerPrint.rawValue, keyPass: UserDefaultAccount.baseLastPassFingerPrint.rawValue)
//    }
    
//    func loginUseFingerPrint(keyUser : String, keyPass : String) {
//        // 1. Create a authentication context
//        let authenticationContext = LAContext()
//        var error:NSError?
//
//        // 2. Check if the device has a fingerprint sensor
//        // If not, show the user an alert view and bail out!
//        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
//
//            //            showAlertViewIfNoBiometricSensorHasBeenDetected()
//            return
//
//        }
//
//
//        // 3. Check the fingerprint
//        authenticationContext.evaluatePolicy(
//            .deviceOwnerAuthentication,
//            localizedReason: "Đăng nhập SmartPro bằng vân tay/nhận dạng khuôn mặt",
//            reply: { [unowned self] (success, error) -> Void in
//
//                if( success ) {
//                    let newFinger = authenticationContext.evaluatedPolicyDomainState
//
//                    let lastUser = UserDefaults.standard.string(forKey: keyUser)
//                    let pass = UserDefaults.standard.string(forKey: keyPass)
////                    DispatchQueue.main.async {
//                    self.
//                        self.presenter.checkLogin(username: lastUser!, pass: pass!)
////                    }
//                } else {
//
//                    // Check if there is an error
//                    if let error = error {
//
//                        let message = self.errorMessageForLAErrorCode(errorCode: error._code)
//                        self.showAlertViewAfterEvaluatingPolicyWithMessage(message: message)
//
//                    }
//
//                }
//
//        })
//    }

    func loginUseSavePassword(keyUser : String){
        let lastUser = UserDefaults.standard.string(forKey: keyUser)
        // Fingerprint recognized
        self.loadPasswordFromKeychainAuthenticateUser(userName: lastUser!, finished: { (password) in
            DispatchQueue.main.async {
                let message = (nil == password) ? "An error occurred, login fail" : "Login success with pass: \(password!)"
                print(message)
                if (nil != password) {
                    if (self.isRemember) {
                        self.saveAccountToKeychain(userName: lastUser!, keyUser: keyUser, password: password!, finished: nil)
                    } else {
                        self.saveAccountToKeychain(userName: lastUser!, keyUser: keyUser, password: "", finished: nil)
                    }
                    self.presenter?.modelRequest.user = lastUser!
                    self.presenter?.modelRequest.password = password!
                    self.presenter?.signInService()
//                    self.presenter.checkLogin(username: lastUser!, pass: password!)
                }
            }
        })
    }
    /**
        This method will present an UIAlertViewController to inform the user that the device has not a TouchID sensor.
    */
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle(title: "Error", message: "This device does not have a TouchID sensor.")
        
    }
    
    /**
        This method will present an UIAlertViewController to inform the user that there was a problem with the TouchID sensor.
    
        - parameter error: the error message
    
    */
    func showAlertViewAfterEvaluatingPolicyWithMessage( message:String ){
        
        showAlertWithTitle(title: "Error", message: message)
        
    }

    /**
        This method presents an UIAlertViewController to the user.
        
        - parameter title:  The title for the UIAlertViewController.
        - parameter message:The message for the UIAlertViewController.
    
    */
    func showAlertWithTitle( title:String, message:String ) {
     
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)

        DispatchQueue.main.async(execute: { () -> Void in
            self.present(alertVC, animated: true, completion: nil)
        })
    }
    
    func saveAccountToKeychain(userName: String?, keyUser : String, password: String?, finished: (() -> ())?) {
        guard let userName = userName?.trimmingCharacters(in: .whitespaces), !userName.isEmpty else {
            // show error
            return
        }
        guard let password = password?.trimmingCharacters(in: .whitespaces) else {
            return
        }
        // Lưu username vào UserDefaults
        UserDefaults.standard.set(userName, forKey: keyUser)
        // Khởi tạo Keychain
        let passwordItem = KeychainPasswordItem(
            service: KeychainConfiguration.serviceName,
            account: userName,
            accessGroup: KeychainConfiguration.accessGroup
        )
        do {
            // thực hiện lưu vào keychain
            try passwordItem.savePassword(password)
            finished?()
        } catch {
            // khi có lỗi
            print("Error saving password")
        }
    }
    
//    func saveAccountToKeychainCKAo(userName: String?, password: String?, finished: (() -> ())?) {
//        guard let userName = userName?.trimmingCharacters(in: .whitespaces), !userName.isEmpty else {
//            // show error
//            return
//        }
//        guard let password = password?.trimmingCharacters(in: .whitespaces) else {
//            return
//        }
//        // Lưu username vào UserDefaults
//        UserDefaults.standard.set(userName, forKey: lastAccessedUserNameCKAo)
//        // Khởi tạo Keychain
//        let passwordItem = KeychainPasswordItem(
//            service: KeychainConfiguration.serviceName,
//            account: userName,
//            accessGroup: KeychainConfiguration.accessGroup
//        )
//        do {
//            // thực hiện lưu vào keychain
//            try passwordItem.savePassword(password)
//            finished?()
//        } catch {
//            // khi có lỗi
//            print("Error saving password")
//        }
//    }
    
    func loadPasswordFromKeychainAuthenticateUser(userName: String, finished:((_ password: String?) -> ())?) {
        let passwordItem = KeychainPasswordItem(
            service: KeychainConfiguration.serviceName,
            account: userName,
            accessGroup: KeychainConfiguration.accessGroup
        )
        do {
            let storedPassword = try passwordItem.readPassword()
            finished?(storedPassword)
        } catch {
            finished?(nil)
        }
    }
    
    func checkPasswordFromKeychainAuthenticateUser(userName: String, password: String, finished:((_ password: String?) -> ())?) {
        let passwordItem = KeychainPasswordItem(
            service: KeychainConfiguration.serviceName,
            account: userName,
            accessGroup: KeychainConfiguration.accessGroup
        )
        do {
            _ = try passwordItem.readPassword()
            
        } catch {
            finished?(nil)
        }
    }
    
    /**
    This method will return an error message string for the provided error code.
    The method check the error code against all cases described in the `LAError` enum.
    If the error code can't be found, a default message is returned.
    
    - parameter errorCode: the error code
    - returns: the error message
    */
    func errorMessageForLAErrorCode( errorCode:Int ) -> String{
        
        var message = ""
        
        switch errorCode {
            
        case LAError.appCancel.rawValue:
            message = "Authentication was cancelled by application"
            
        case LAError.authenticationFailed.rawValue:
            message = "Vân tay/nhận dạng khuôn mặt không hợp lệ"
            
        case LAError.invalidContext.rawValue:
            message = "The context is invalid"
            
        case LAError.passcodeNotSet.rawValue:
            message = "Passcode is not set on the device"
            
        case LAError.systemCancel.rawValue:
            message = "Authentication was cancelled by the system"
            
        case LAError.touchIDLockout.rawValue:
            message = "Chú ý đăng nhập sai nhiều lần"
            
        case LAError.touchIDNotAvailable.rawValue:
            message = "TouchID is not available on the device"
            
        case LAError.userCancel.rawValue:
            message = "The user did cancel"
            
        case LAError.userFallback.rawValue:
            message = "The user chose to use the fallback"
            
        default:
            message = "Did not find error code on LAError object"
            
        }
        
        return message
    }
}

