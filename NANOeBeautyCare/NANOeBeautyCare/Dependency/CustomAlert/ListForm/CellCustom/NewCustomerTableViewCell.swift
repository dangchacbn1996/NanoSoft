//
//  NewCustomerTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class NewCustomerTableViewCell: UITableViewCell, ReusableCell {
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var appoimentButton: UIButton!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    typealias T = DefaultCellModel<CustomFormModelElement>

    var item: DefaultCellModel<CustomFormModelElement>? {
        didSet {
            guard let model = item?.property?.model?.rawItem as? ModelOptionResponseEmployeeAndSearchCatalogDatum else {
                return
            }
//            let avarta = Common.stringToUrlImage(text: model.anhNhanVien ?? "")
//            self.avartaImageview.avartaImageView(url: avarta)
//            self.titleLabel.text = model.tenNhanVien
//            self.descLabel.text = model.nhomNhanVien
//            self.numberLabel.text = "\(model.soSao ?? 0)"
//
//            if let sele = item?.property?.model {
//                self.checkedImageview.isHidden = !sele.isSelected
//            }
        }
    }
    
}
