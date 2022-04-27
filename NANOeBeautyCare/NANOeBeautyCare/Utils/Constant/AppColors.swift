//
//  AppColors.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 02/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

struct AppColors {
    static let mainNaviColor = UIColor(hex: "2C86F3")
    static let mainStartGradient = UIColor(hex: "1A6CEE")
    static let mainEndGradient = UIColor(hex: "54C0FF")
    static let mainBackColor = UIColor(hex: "F6FAFC")
    static let gray = UIColor(hex: "908F9D")
//    static let textGray = UIColor(hex: "908F9D")
    static let viewRed = UIColor(hex: "CF5555")
    static let viewBlueLight = UIColor(hex: "E6F2FF")
    static let viewBlue = UIColor(hex: "28ACF5")
    static let viewYellow = UIColor(hex: "FAB345")
    
//    static let textBlack = UIColor(hex: "3B3A43")
    static let textBlack = UIColor.black
    static let textBlue = UIColor(hex: "28ACF5")
    static let textRed = UIColor(hex: "EE1A1A")
    static let textGray = UIColor.gray
    
    static let primaryColor: UIColor = UIColor(hex: "1A6CEE")
    static let dangerColor: UIColor = UIColor.red
    static let gradientStart = UIColor(hex: "1A6CEE")
    static let gradientNaviEnd = UIColor(hex: "6CA3E6")
    static let gradientMid = UIColor(hex: "2C86F3")
    static let gradientEnd = UIColor(hex: "54C0FF")
    
    struct gradientRed {
        static let start = UIColor(hex: "EE1A1A")
        static let end = UIColor(hex: "F45D5B")
    }
}

class DataManager {
    
    static let shared = DataManager()
    
    var companyModel: ResponseHospitalDetailModel? = nil
}

class SessionManager {
    static let shared = SessionManager()
    
    var userInfo: CustomerProfileOptionalResponse? = nil
    var listServicePackage: [ResponseComboServiceModel] = []
    var listProvince: [ModelOptionResponseProvincesCatalogDatum] = []
    var listNgheNghiep: [ModelOptionResponseOccupationCatalogDatum] = []
    var listNguonGioiThieu: [ModelOptionResponseReferralCatalogDatum] = []
    var listNguonDen: [ModelOptionResponseSourceToCatalogDatum] = []
    
    
    var soDienThoai: String {
        get {
            return userInfo?.dienThoai ?? ""
        }
    }
    
    var countNoti: Int = 0 {
        didSet {
            NotificationCenter.default.post(Notification(name: Notification.Name(NotificationKey.notiCountChange.rawValue)))
        }
    }
}
