//
//  HospitalUltils.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 13/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import Foundation

class HospitalUltils {
    static func gradientImage(bounds: CGRect, start: UIColor = AppColors.primaryColor, end: UIColor = AppColors.gradientMid) -> (UIImage?) {
        let gradient = CAGradientLayer()
        var bounds = bounds
        gradient.frame = bounds
        gradient.colors = [start.cgColor, end.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            return image
        }
        return nil
    }
    
    static func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
}
