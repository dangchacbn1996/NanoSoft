//
//  MyActionSheetItem.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import UIKit

public typealias MyActionSheetHandler = ((MyActionSheet) -> Void)

public class MyActionSheetItem {
    
    public enum ItemType {
        case `default`
        case destructive
        case cancel
    }
    
    public var title: String?
    public var titleEdgeInsets: UIEdgeInsets = .zero
    public var titleColor: UIColor = MyActionSheet.Preferences.ButtonTitleColor
    public var titleBackgroudColor: UIColor = UIColor.white
    public var font: UIFont = UIFont.systemFont(ofSize: 17)
    
    public var desc: String?
    public var descColor: UIColor = UIColor(white: 0, alpha: 0.4)
    
    public var iconImage: UIImage?
    public var imageEdgeInsets: UIEdgeInsets = .zero
    
    public var type: ItemType = .default
    public var handler: MyActionSheetHandler? = nil
    
    public convenience init(title: String) {
        self.init(title: title, handler: nil, type: .default)
    }
    
    public convenience init(title: String, handler: @escaping MyActionSheetHandler) {
        self.init(title: title, handler: handler, type: .default)
    }
    
    public init(title: String, handler: MyActionSheetHandler?, type: ItemType) {
        self.title = title
        self.handler = handler
        self.type = type
    }
    
    public init(title: String, desc: String, handler: MyActionSheetHandler?, type: ItemType = .default) {
        self.title = title
        self.handler = handler
        self.desc = desc
        self.type = type
    }
}

