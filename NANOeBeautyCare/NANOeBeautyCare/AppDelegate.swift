//
//  AppDelegate_Teamp.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import CoreData
import SDWebImage
import OneSignal

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, OSSubscriptionObserver, OSPermissionObserver {
    
    let appId = "55f502a1-9ad9-4f1b-852d-e38d1587cb85"

    // Avoid warning of Swift
    // Method 'initialize()' defines Objective-C class method 'initialize', which is not guaranteed to be invoked by Swift and will be disallowed in future versions
    override init() {
        super.init()
        UIFont.overrideInitialize()
    }
    var window: UIWindow?
    var backgroundUpdateTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        
        self.window?.tintColor = AppColors.primaryColor
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.7)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColors.primaryColor], for: .selected)
        self.allInOne(application: application, didFinishLaunchingWithOptions: launchOptions)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Huỷ"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = AppColors.primaryColor
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
        
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : AppColors.tabbar_unselected,
        //                                                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)], for: .normal)
        //        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : AppColors.tabbar_selected,
        //                                                          NSAttributedStringKey.font: UIFont.systemFont(ofSize: 11)], for: .selected)
                
                UITextField.appearance(whenContainedInInstancesOf:[UISearchBar.self]).backgroundColor = UIColor.white
                
//                OneSignal.add(self as OSSubscriptionObserver)
//                
//                // For debugging
//                OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
//                print("OneSignal.getDeviceState()?.userId")
//                print(OneSignal.getDeviceState()?.userId ?? "")
//                let notifWillShowInForegroundHandler: OSNotificationWillShowInForegroundBlock = { notification, completion in
//                    print("Received Notification: ", notification.notificationId ?? "no id")
//                    print("launchURL: ", notification.launchURL ?? "no launch url")
//                    print("content_available = \(notification.contentAvailable)")
//                    if notification.notificationId == "example_silent_notif" {
//                        completion(nil)
//                    } else {
//                        completion(notification)
//                    }
//                }
//        
//                let notificationOpenedBlock: OSNotificationOpenedBlock = { result in
//                    // This block gets called when the user reacts to a notification received
//                    let notification: OSNotification = result.notification
//        
//                    print("Message: ", notification.body ?? "empty body")
//                    print("badge number: ", notification.badge)
//                    print("notification sound: ", notification.sound ?? "No sound")
//        
//                    if let additionalData = notification.additionalData {
//                        print("additionalData: ", additionalData)
//        
//                        do {
//                            let data = try JSONSerialization.data(withJSONObject: additionalData, options: .prettyPrinted)
//                            let decoder = JSONDecoder()
//        
//                            let parsedData = try decoder.decode(PushNotificationModel.self, from: data)
//                            NotificationCenter.default.post(name: Notification.Name(kPushNotification), object: nil, userInfo: [kPushNotification:parsedData])
//                            Loading.notificationSuccess(title: parsedData.type ?? "", subtitle: "")
//                        } catch {
//                            print(error)
//                        }
//        
//                        if let actionSelected = notification.actionButtons {
//                            print("actionSelected: ", actionSelected)
//                        }
//                    }
//                }
//        
//        //        let onesignalInitSettings = [kOneSig: true,]
//        
//                OneSignal.setAppId(appId)
//                OneSignal.initWithLaunchOptions(launchOptions)
//                OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)
//                OneSignal.setNotificationWillShowInForegroundHandler(notifWillShowInForegroundHandler)
//        //        OneSignal.setAppSettings(onesignalInitSettings)
//        
//                // Add your AppDelegate as an obsserver
//                OneSignal.add(self as OSPermissionObserver)
//        
//                OneSignal.add(self as OSSubscriptionObserver)
        return true
    }
    
//    func onOneSignal() {
//        //         For debugging
//        OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
//        print("OneSignal.getDeviceState()?.userId")
//        print(OneSignal.getDeviceState()?.userId ?? "")
//        let notifWillShowInForegroundHandler: OSNotificationWillShowInForegroundBlock = { notification, completion in
//            print("Received Notification: ", notification.notificationId ?? "no id")
//            print("launchURL: ", notification.launchURL ?? "no launch url")
//            print("content_available = \(notification.contentAvailable)")
//            if notification.notificationId == "example_silent_notif" {
//                completion(nil)
//            } else {
//                completion(notification)
//            }
//        }
//
//        let notificationOpenedBlock: OSNotificationOpenedBlock = { result in
//            // This block gets called when the user reacts to a notification received
//            let notification: OSNotification = result.notification
//
//            print("Message: ", notification.body ?? "empty body")
//            print("badge number: ", notification.badge)
//            print("notification sound: ", notification.sound ?? "No sound")
//
//            if let additionalData = notification.additionalData {
//                print("additionalData: ", additionalData)
//
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: additionalData, options: .prettyPrinted)
//                    let decoder = JSONDecoder()
//
//                    let parsedData = try decoder.decode(PushNotificationModel.self, from: data)
//                    NotificationCenter.default.post(name: Notification.Name(kPushNotification), object: nil, userInfo: [kPushNotification:parsedData])
//                    Loading.notificationSuccess(title: parsedData.type ?? "", subtitle: "")
//                } catch {
//                    print(error)
//                }
//
//                if let actionSelected = notification.actionButtons {
//                    print("actionSelected: ", actionSelected)
//                }
//            }
//        }
//
//        //        let onesignalInitSettings = [kOneSig: true,]
//
//        OneSignal.setAppId(appId)
////        OneSignal.setAppId("d8930143-bc77-42c1-9936-1fdcdc3e8c69")
//
//
//        OneSignal.setNotificationOpenedHandler(notificationOpenedBlock)
//        OneSignal.setNotificationWillShowInForegroundHandler(notifWillShowInForegroundHandler)
//
//        //        OneSignal.setAppSettings(onesignalInitSettings)
//
//        // Add your AppDelegate as an obsserver
//        OneSignal.add(self as OSPermissionObserver)
//
//        OneSignal.add(self as OSSubscriptionObserver)
//
//
//        if let userDefaults = UserDefaults(suiteName: "group.com.nanosoft.pkcongnghe.onesignal") {
//            userDefaults.set("test 1" as AnyObject, forKey: "key1")
//            userDefaults.set("test 2" as AnyObject, forKey: "key2")
//            userDefaults.synchronize()
//        }
//        if let userDefaults = UserDefaults(suiteName: "group.com.nanosoft.pkcongnghe.onesignal") {
//            let value1 = userDefaults.string(forKey: "key1")
//            let value2 = userDefaults.string(forKey: "key2")
//            print("value1 = ", value1?.description ?? "No value")
//            print("value2 = ", value2?.description ?? "No value")
//        }
//    }
    
    func onOSPermissionChanged(_ stateChanges: OSPermissionStateChanges) {
        
    }
    
    static func actCall(tel: String) {
        if let url = URL(string: "tel://\(tel)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
