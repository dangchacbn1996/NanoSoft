//
//  ProductSalesCollectionViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/31/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class ProductSalesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var checkedLabel: UILabel!
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var checkedImageview: UIImageView!

    func updateCardCell(model: CardProductOptionalResponse) {
        self.avartaImageview.pictureImageView(url: Common.stringToUrlImage(text: model.anhTheDichVu ?? ""))
        self.titleLabel.text = model.tenLoaiTheDichVu
        self.priceLabel.text = model.donGiaBan?.formatnumberWithCurrency()
        self.discountLabel.text = model.giaTriThe?.formatnumberWithCurrency()
        self.discountLabel.attributedText = model.giaTriThe?.formatnumberWithCurrency().strikeThrough()
        self.checkedImageview.isHidden = !model.isSelected
        self.checkedLabel.isHidden = true
    }

    func updateCatalogCell(model: CatalogProductOptionalResponse) {
        self.avartaImageview.pictureImageView(url: Common.stringToUrlImage(text: model.anhSanPham ?? ""))
        self.titleLabel.text = model.tenSanPham
        self.priceLabel.text = model.giaNiemYet?.formatnumberWithCurrency()
        self.discountLabel.text = model.giaBan?.formatnumberWithCurrency()
        self.discountLabel.attributedText = model.giaBan?.formatnumberWithCurrency().strikeThrough()
        self.checkedImageview.isHidden = !model.isSelected
        
        let solM = model.soLuongTonMin ?? -1
        if solM >= 0 {
            self.checkedLabel.isHidden = false
            self.checkedLabel.text = ["\(solM)",model.tenDonViMin ].joined(separator: "/")
        } else {
            self.checkedLabel.isHidden = true
        }
    }

    func updateServiceCell(model: ServiceProductOptionalResponse) {
        self.checkedLabel.isHidden = true
        self.avartaImageview.pictureImageView(url: Common.stringToUrlImage(text: model.anhDichVu ?? ""))
        self.titleLabel.text = model.tenDichVu
        self.priceLabel.text = model.donGia?.formatnumberWithCurrency()
        self.discountLabel.text = model.donGianNiemYet?.formatnumberWithCurrency()
        self.discountLabel.attributedText = model.donGianNiemYet?.formatnumberWithCurrency().strikeThrough()
        self.checkedImageview.isHidden = !model.isSelected
    }
}
