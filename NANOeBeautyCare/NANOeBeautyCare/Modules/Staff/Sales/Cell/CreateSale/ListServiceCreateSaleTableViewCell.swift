//
//  ListServiceCreateSaleTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ListServiceCreateSaleTableViewCell: SwipeableTableViewCell, ReusableCell {

    typealias T = CellViewCreateSale

    var item: CellViewCreateSale? {
        didSet {
            let model = item?.property?.model?.listService
            self.avartaImageview.pictureImageView(url: Common.stringToUrlImage(text: model?.anhDaiDien ?? ""))
            self.titleLabel.text = model?.ten
            self.numberLabel.text = "Số lượng: \(model?.soLuong ?? 0)"
            self.moneyLabel.text = (model?.donGiaNew ?? -1 > 0) ? model?.donGiaNew.formatnumberWithCurrency() : model?.donGia?.formatnumberWithCurrency()
            if model?.thanhTienGiamGia ?? 0 > 0 {
                self.discountLabel.text = "(-\(model?.thanhTienGiamGia?.formatnumberWithCurrency() ?? 0.formatnumberWithCurrency()))"
                self.totalDiscountLabel.text = model?.tienThanhToan?.formatnumberWithCurrency()
            } else {
                self.discountLabel.text =  ""
                self.totalDiscountLabel.text =  ""
            }
        }
    }


    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var totalDiscountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
