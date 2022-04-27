//
//  Constants.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

public struct ConstantsVal {
    
    static var authToken = ""
    static let deviceToken = UIDevice.current.identifierForVendor?.uuidString ?? ""
    static let currency = "đ"
    static let edgePadding : CGFloat = 16
    static let widthPadding : CGFloat = 32
    
//    enum App {
//
//    }
//
//    enum Network {
//
//    }
}

public enum NotificationKey: String {
    case notiCountChange = "NotiCountChange"
}

enum UserDefaultEnum: String {
//    case HOST = "HOST"
//    case BRAND_DOMAIN = "BRAND_DOMAIN"
//    case BRAND_NAME = "BRAND_NAME"
//    case BRAND_LOGO = "BRAND_LOGO"
    case BRAND_TYPE = "BRAND_TYPE"
    case SavePass = "SavePassword"
//    case BRAND_NUMBER = "BRAND_NUMBER"
//    case BRAND_USER = "BRAND_USER"
//    case BRAND_SID = "BRAND_SID"
}

let HOST = UserDefaults.standard.df.fetch(forKey: String(describing: ServerSettingOptionalResponseDatum.self), type: ServerSettingOptionalResponseDatum.self)?.domain

enum BrandTypeEnum: String {
    case Staff = "NHAN_VIEN"
    case Customer = "KHACH_HANG"
}

enum Storyboards: String {
    case main = "Main"
}
