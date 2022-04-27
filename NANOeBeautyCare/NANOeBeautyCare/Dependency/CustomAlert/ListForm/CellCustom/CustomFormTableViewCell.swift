//
//  CustomFormTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/6/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomFormTableViewCell: UITableViewCell,ReusableCell {
    
    typealias T = DefaultCellModel<CustomFormModelElement>
    @IBOutlet weak var titleLabel: UILabel!
    
    var item: DefaultCellModel<CustomFormModelElement>? {
        didSet {
            self.titleLabel.text = item?.property?.model?.selected
        }
    }
    
}
