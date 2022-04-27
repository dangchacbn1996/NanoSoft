//
//  AppointmentTableViewHeaderFooterView.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/9/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class AppointmentTableViewHeaderFooterView: UITableViewHeaderFooterView,ReusableHeaderFooter {
    @IBOutlet weak var titleLabel: UILabel!
    typealias T = ViewAppointment

    var item: ViewAppointment? {
        didSet {
            self.titleLabel.text = item?.headerProperty?.model?.title.setStringToDate(formatCurrent: "dd/MM/yyyy")?.getFormattedDate(format: "EEEE dd/MM/yyyy")
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
