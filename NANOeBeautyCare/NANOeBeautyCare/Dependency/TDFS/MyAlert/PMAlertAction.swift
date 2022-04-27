//
//  PMAlertAction.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import UIKit

@objc public enum PMAlertActionStyle : Int {
    
    case `default`
    case cancel
}

@objc open class PMAlertAction: UIButton {
    
    fileprivate var action: (() -> Void)?
    
    open var actionStyle : PMAlertActionStyle
    
    open var separator = UIImageView()
    
    init(){
        self.actionStyle = .cancel
        super.init(frame: CGRect.zero)
    }
    
    @objc public convenience init(title: String?, style: PMAlertActionStyle, action: (() -> Void)? = nil){
        self.init()
        
        self.action = action
        self.addTarget(self, action: #selector(PMAlertAction.tapped(_:)), for: .touchUpInside)
        
        self.setTitle(title, for: UIControl.State())
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        self.actionStyle = style
        style == .default ? (self.setTitleColor(UIColor(hex: "0091ff"), for: UIControl.State())) : (self.setTitleColor(UIColor.gray, for: UIControl.State()))
        
        self.addSeparator()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped(_ sender: PMAlertAction) {
        //Action need to be fired after alert dismiss
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.action?()
        }
    }
    
    @objc fileprivate func addSeparator(){
        self.cornerRadius = 6
        self.clipsToBounds = true
        separator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        self.addSubview(separator)
        
        // Autolayout separator
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        separator.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
//        separator.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
        separator.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        separator.widthAnchor.constraint(equalToConstant: 5).isActive = true
    }
    
}
