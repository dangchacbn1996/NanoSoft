//
//  CircularImageView.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/7/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

@IBDesignable
class CircularImageView: UIImageView {

  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    makeCircularImage()
  }

  // drawRect will not work on UIImageView
  override func layoutSubviews() {
    super.layoutSubviews()
    makeCircularImage()
  }

  func makeCircularImage() {
    self.layer.cornerRadius = self.frame.size.height / 2
  }

}
