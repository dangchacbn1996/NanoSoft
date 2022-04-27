//
//  SearchCustomerTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/27/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class SearchCustomerTableViewCell: UITableViewCell, ReusableCell {
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var checkedImageview: UIImageView!

    typealias T = DefaultCellModel<CustomFormModelElement>

    var item: DefaultCellModel<CustomFormModelElement>? {
        didSet {
            guard let model = item?.property?.model?.rawItem as? SearchCustomerAppointmentOptionalResponse else {
                return
            }
//            let avarta = Common.stringToUrlImage(text: model.anhNhanVien ?? "")
            self.avartaImageview.avartaImageView(url: "avarta")
            self.titleLabel.text = model.hoTen
            self.descLabel.text = model.dienThoai
            self.numberLabel.text = ""

            if let sele = item?.property?.model {
                self.checkedImageview.isHidden = !sele.isSelected
            }
        }
    }
    
}
