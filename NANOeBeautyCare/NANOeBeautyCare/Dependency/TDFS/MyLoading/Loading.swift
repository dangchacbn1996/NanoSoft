//
//  Loading.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import Foundation
import Whisper
import NotificationBannerSwift

final class Loading {
    static func startAnimation() {
        let activityData = ActivityData(icon: UIImage(named: "LogoLoading")!)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    static func stopAnimation() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
    static func whisper(title:String = Bundle.main.displayName ?? "", subtitle: String = "") {
        let announcement = Announcement(title: title, subtitle: subtitle, image: UIImage(named: "LogoLoading"))
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            Whisper.show(shout: announcement, to: vc) {
                print("The shout was silent.")
            }
        } else if let navi = UIApplication.shared.keyWindow?.rootViewController?.navigationController {
            Whisper.show(shout: announcement, to: navi, completion: {
                print("The shout was silent.")
            })
        }
    }
    static func alert() {
        
    }
    
    static func notificationSuccess(title:String, subtitle: String) {
        let leftView = UIImageView(image: #imageLiteral(resourceName: "ic-logo-app"))
        let banner = GrowingNotificationBanner(title: title, subtitle: subtitle, leftView: leftView, style: .success)
        banner.show()
    }
    
    static func notificationError(title:String, subtitle: String) {
        let leftView = UIImageView(image: #imageLiteral(resourceName: "ic-logo-app"))
        let banner = GrowingNotificationBanner(title: title, subtitle: subtitle, leftView: leftView, style: .danger)
        banner.show()
    }
    
}

extension Bundle {
    var displayName: String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
