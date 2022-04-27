//
//  AppDelegatePresenter.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Localize
import IQKeyboardManagerSwift
import OneSignal

let USER_DEFAULT = UserDefaults.standard
let OneSignalSchema = Bundle.main.infoDictionary?["One_Signal_ID"] as? String ?? ""

protocol ProtocolAppdelegate {
    func allInOne(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    func setupLocalize()
    func setupKeyboard()
    func setupAutoUpdateVersion()
    func rootViewController()
    func setupNavigationbar()
}

extension AppDelegate: ProtocolAppdelegate {
    
    func setupAutoUpdateVersion() {
        //        Siren.shared.wail()
    }
    
    func allInOne(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.setupKeyboard()
        self.setupLocalize()
        self.rootViewController()
        self.setupNavigationbar()
        self.setupAutoUpdateVersion()
        self.setNotification(launchOptions: launchOptions)
    }
    
    func setupLocalize() {
        let localize = Localize.shared
        // Set your localize provider.
        localize.update(provider: .json)
        // Set your default languaje.
        localize.update(defaultLanguage: "vi")
        localize.update(language: "vi")
    }
    
    func setupKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 0
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Xong";
        IQKeyboardManager.shared.enableAutoToolbar = false
    }
    
    func rootViewController() {
        //        let rootVC = UIStoryboard(name:"Splash", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        //        //        let nav = UINavigationController(rootViewController: rootVC)
        //        UIApplication.shared.windows.first?.rootViewController = rootVC
        //        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func setupNavigationbar() {
        //        let navBackgroundImage:UIImage! = UIImage(named: "navi_background")
        //        UINavigationBar.appearance().setBackgroundImage(navBackgroundImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        //        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font : AppTheme.Font.semiBoldSystemFont(.large), NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func setNotification(launchOptions:[UIApplication.LaunchOptionsKey: Any]?) {
        let notifWillShowInForegroundHandler: OSNotificationWillShowInForegroundBlock = { notification, completion in
            //            guard let topVC = UIApplication.topViewController() else {
            //                return
            //            }
            if let additionalData = notification.additionalData {
                do {
                    let data = try JSONSerialization.data(withJSONObject: additionalData, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    
                    let parsedData = try decoder.decode(PushNotificationModel.self, from: data)
                    NotificationCenter.default.post(name: Notification.Name(kPushNotification), object: nil, userInfo: [kPushNotification:parsedData])
                } catch {
                    print(error)
                }
            }
        }
        OneSignal.setNotificationWillShowInForegroundHandler(notifWillShowInForegroundHandler)
        // when tap notification in screen
        OneSignal.setNotificationOpenedHandler { (result) in
            let notification: OSNotification = result.notification
            guard let topVC = UIApplication.topViewController() else {
                return
            }
            if let additionalData = notification.additionalData {
                do {
                    let data = try JSONSerialization.data(withJSONObject: additionalData, options: .prettyPrinted)
                    let decoder = JSONDecoder()
                    
                    let parsedData = try decoder.decode(PushNotificationModel.self, from: data)
//                    if topVC is SplashViewController {
//                        //                    CommonSession.shared.pushNoti = pushModel
//                    } else {
//                        if let typeString = parsedData.type {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                NotificationCenter.default.post(name: Notification.Name(kPushNotification), object: nil, userInfo: [kPushNotification:parsedData])
//                                if typeString == kPushNotificationAppointment {
//
//                                } else if typeString == kPushNotificationTreatment {
//
//                                } else if typeString == kPushNotificationNews {
//
//                                } else if typeString == kPushNotificationOther {
//
//                                }
                            }
//                        }
//                    }
                } catch {
                    print(error)
                }
            }
        }
        // Replace 'YOUR_APP_ID' with your OneSignal App ID.
        OneSignal.initWithLaunchOptions(launchOptions)
        OneSignal.setAppId(appId)
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("AAAAAAA")
        })
        //END OneSignal initializataion code
    }
}

extension AppDelegate {
    func onOSSubscriptionChanged(_ stateChanges: OSSubscriptionStateChanges) {
        //The player id is inside stateChanges. But be careful, this value can be nil if the user has not granted you permission to send notifications.
        
        if let playerId = stateChanges.to.userId {
            print("Current playerId: \(playerId)")
            USER_DEFAULT.set(playerId, forKey: "UserDefaultKeysPlayerId")
            USER_DEFAULT.synchronize()
        }
    }
}


extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
