//
//  MyGradientButton.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class MyGradientButton : UIButton {
    
    @IBInspectable var startColor: UIColor = AppColors.gradientStart {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var endColor: UIColor = AppColors.gradientMid {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var roundness: CGFloat = 16.0 {
        didSet{
            setupView()
        }
    }
    
    // MARK: Overrides ******************************************
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
    
    // MARK: Internal functions *********************************
    
    // Setup the view appearance
    private func setupView(){
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        let colors:Array = [startColor.cgColor, endColor.cgColor]
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = roundness
        
        if (isHorizontal){
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        }else{
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        self.setNeedsDisplay()
        
    }
    
    // Helper to return the main layer as CAGradientLayer
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
}
