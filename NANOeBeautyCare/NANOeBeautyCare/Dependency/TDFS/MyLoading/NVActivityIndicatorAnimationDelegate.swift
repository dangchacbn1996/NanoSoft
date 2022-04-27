//
//  NVActivityIndicatorAnimationDelegate.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import UIKit

// swiftlint:disable:next class_delegate_protocol
protocol NVActivityIndicatorAnimationDelegate {
    func setUpAnimation(in layer: CALayer, size: CGSize, color: UIColor)
}
