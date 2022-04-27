//
//  HospitalNavigationViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 10/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let gradient = CAGradientLayer()
//        var bounds = navigationBar.bounds
//        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
//        gradient.frame = self.view.bounds
//        gradient.colors = [UIColor(hex: "1A6CEE").cgColor, UIColor(hex: "2C86F3").cgColor, UIColor(hex: "54C0FF").cgColor, UIColor.white.cgColor]
//        gradient.locations = [0.0, 0.1, 0.3, 1.0]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 0, y: 1)
//
//        if let image = getImageFrom(gradientLayer: gradient) {
////            navigationBar.shouldRemoveShadow(true)
////            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
////            navigationBar.titleTextAttributes = [
////                NSAttributedString.Key.foregroundColor: UIColor.white,
////                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
////            navigationBar.layoutIfNeeded()
//            self.navigationBar.isTranslucent = true
//            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
//            self.navigationBar.shadowImage = UIImage()
//            self.navigationBar.barTintColor = UIColor.clear
//            self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
//            self.navigationBar.tintColor = UIColor.white
////            rootViewController?.edgesForExtendedLayout = UIRectEdge()
//
//            let imageView = UIImageView(image: image)
//            self.view.insertSubview(imageView, belowSubview: self.view.subviews[0])
//            imageView.snp.makeConstraints({
//                $0.edges.equalToSuperview()
//            })
//        }
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds
//        gradient.colors = [UIColor(hex: "1A6CEE").cgColor, UIColor(hex: "2C86F3").cgColor, UIColor(hex: "54C0FF").cgColor, UIColor.white.cgColor]
//        gradient.locations = [0.0, 0.1, 0.3, 1.0]
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            navigationBar.shouldRemoveShadow(true)
            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
            navigationBar.layoutIfNeeded()
            
        }
    }
    
}
