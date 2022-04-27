//
//  ServiceCustomFormTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/25/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ServiceCustomFormTableViewCell: UITableViewCell,ReusableCell {
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkedImageview: UIImageView!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var saleLabel: UILabel!

    typealias T = DefaultCellModel<CustomFormModelElement>

    var item: DefaultCellModel<CustomFormModelElement>? {
        didSet {
            if let sele = item?.property?.model {
                self.checkedImageview.isHidden = !sele.isSelected
            }
            guard let model = item?.property?.model?.rawItem as? ModelOptionResponseServiceCatalogDatum else {
                return
            }
            self.avartaImageview.pictureImageView(url: Common.stringToUrlImage(text: model.anhDichVu ?? ""))
            self.titleLabel.text = model.tenDichVu

            let numberPercernt = ((model.donGianNiemYet ?? 0) - (model.donGia ?? 0)) * 100 / (model.donGianNiemYet ?? 1)
            if numberPercernt <= 0 {
                self.originalLabel.text = (model.donGia ?? 0).formatnumberWithCurrency()
                self.percentLabel.text = ""
                self.saleLabel.text = ""
                self.saleLabel.isHidden = true
                self.percentLabel.isHidden = true
            } else {
                self.saleLabel.isHidden = false
                self.percentLabel.isHidden = false
                self.originalLabel.text = (model.donGia ?? 0).formatnumberWithCurrency()
                self.percentLabel.text = "\(numberPercernt)%"
                self.saleLabel.text = (model.donGianNiemYet ?? 0).formatnumberWithCurrency()
            }
        }
    }

}

