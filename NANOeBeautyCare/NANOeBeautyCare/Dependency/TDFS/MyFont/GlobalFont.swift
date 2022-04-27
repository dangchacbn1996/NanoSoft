//
//  GlobalFont.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import UIKit

struct AppFontName {
    static let regular = "Nunito-Regular"
    static let medium = "Nunito-Regular"
    static let bold = "Nunito-Bold"
    static let italic = "Nunito-Italic"
    static let black = "Nunito-Black"
    static let heavy = "Nunito-ExtraBold"
    static let ultraLight = "Nunito-ExtraLight"
    static let thin = "Nunito-ExtraLight"
    static let light = "Nunito-Light"
    static let semibold = "Nunito-SemiBold"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIColor {
    static var isOverrided: Bool = false
}

extension UIFont {
    static var isOverrided: Bool = false
    
    static func mySize(size: CGFloat) -> CGFloat{
        guard UIDevice.current.userInterfaceIdiom == .phone else {
            return size
        }
        let base = 414.0
        let screenWidth = Double(UIScreen.main.bounds.width)
        let screenHeight = Double(UIScreen.main.bounds.height)
        let width = min(screenWidth, screenHeight)
        return (size * CGFloat((width / base))).rounded()
    }
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: mySize(size: size))!
    }
    
    @objc class func mySystemFontMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: mySize(size: size))!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: mySize(size: size))!
    }
    
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: mySize(size: size))!
    }
    
    @objc class func myMediumSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.medium, size: mySize(size: size))!
    }
    
    @objc class func myBlackSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.black, size: mySize(size: size))!
    }
    
    @objc class func myHeavySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.heavy, size: mySize(size: size))!
    }
    
    @objc class func myUltralightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.ultraLight, size: mySize(size: size))!
    }
    
    @objc class func myThinSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.thin, size: mySize(size: size))!
    }
    @objc class func myLightSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.light, size: mySize(size: size))!
    }
    @objc class func mySemiboldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.semibold, size: mySize(size: size))!
    }
    
    @objc class func mySystemFontWeight(ofSize: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .medium:
            return myMediumSystemFont(ofSize: ofSize)
        case .black:
            return myBlackSystemFont(ofSize: ofSize)
        case .heavy:
            return myHeavySystemFont(ofSize: ofSize)
        case .ultraLight:
            return myUltralightSystemFont(ofSize: ofSize)
        case .thin:
            return myThinSystemFont(ofSize: ofSize)
        case .light:
            return myLightSystemFont(ofSize: ofSize)
        case .semibold:
            return mySemiboldSystemFont(ofSize: ofSize)
        case .regular:
            return mySystemFont(ofSize: ofSize)
        case .bold:
            return myBoldSystemFont(ofSize: ofSize)
            
        default:
            return mySystemFont(ofSize: ofSize)
        }
    }
    
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
            fontName = AppFontName.italic
        case "CTFontBlackUsage":
            fontName = AppFontName.black
        case "CTFontHeavyUsage":
            fontName = AppFontName.heavy
        case "CTFontUltraLightUsage":
            fontName = AppFontName.ultraLight
        case "CTFontThinUsage":
            fontName = AppFontName.thin
        case "CTFontLightUsage":
            fontName = AppFontName.light
        case "CTFontMediumUsage":
            fontName = AppFontName.medium
        case "CTFontDemiUsage":
            fontName = AppFontName.semibold
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
//        for family: String in UIFont.familyNames
//        {
//            print(family)
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
        guard self == UIFont.self, !isOverrided else { return }
        
        // Avoid method swizzling run twice and revert to original initialize function
        isOverrided = true
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        
        if let weightSystemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:weight:))),
            let myweightSystemFontMethod = class_getClassMethod(self, #selector(mySystemFontWeight(ofSize:weight:))) {
            method_exchangeImplementations(weightSystemFontMethod, myweightSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}

