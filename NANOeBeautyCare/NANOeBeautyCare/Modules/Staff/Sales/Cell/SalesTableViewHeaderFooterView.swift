//
//  SalesTableViewHeaderFooterView.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/31/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SalesTableViewHeaderFooterView: UITableViewHeaderFooterView,ReusableHeaderFooter {
    @IBOutlet weak var titleLabel: UILabel!
    typealias T = ViewSales

    var item: ViewSales? {
        didSet {
            self.titleLabel.text = item?.headerProperty?.model?.title.setStringToDate(formatCurrent: "HH:mm dd/MM/yyyy")?.getFormattedDate(format: "EEEE dd/MM/yyyy")
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}

