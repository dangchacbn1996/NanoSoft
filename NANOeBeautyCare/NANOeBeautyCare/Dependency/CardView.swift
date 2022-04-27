//
//  CardView.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/13/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CardView: UIView {
    
    @IBInspectable var cornerradius:CGFloat = 8
    
    @IBInspectable var shadowOffsetWidth:CGFloat = 0
    @IBInspectable var shadowOffsetHeight:CGFloat = 2
    
    @IBInspectable var shadowColors: UIColor = UIColor.gray
    @IBInspectable var shadowOpacitys: CGFloat = 0.5
    
    @IBInspectable var borderWidths: CGFloat = 1
    @IBInspectable var borderColors: UIColor = UIColor.clear

    var removeShadow: Bool = false
    
    override func layoutSubviews() {
        if removeShadow == false {
            // Corner..............
            layer.cornerRadius = cornerradius

            // Shadow...........
            layer.shadowColor = shadowColors.cgColor
            layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
            layer.shadowPath = shadowPath.cgPath
            layer.shadowOpacity = Float(shadowOpacitys)
            layer.masksToBounds = false

            // Border.............
            layer.borderWidth = borderWidths
            layer.borderColor = borderColors.cgColor
        } else {
            layer.cornerRadius = 0
            layer.shadowColor = UIColor.clear.cgColor
            layer.shadowPath = nil
            layer.shadowOpacity = 0.0
            layer.borderWidth = 0.0
            layer.borderColor = UIColor.clear.cgColor
        }
    }

    func resetCard() {
        self.removeShadow = true
        self.layoutSubviews()
    }

    func usingShadow() {
        self.removeShadow = false
        self.layoutSubviews()
    }
}
