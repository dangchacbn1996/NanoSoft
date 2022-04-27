//
//  FooterCreateSaleTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class FooterCreateSaleTableViewCell: UITableViewCell, ReusableCell {

    typealias T = CellViewCreateSale

    var item: CellViewCreateSale? {
        didSet {
            let model = item?.property?.model?.footer
            self.totalLabel.text = model?.tongTien?.formatnumberWithCurrency()
            self.discountLabel.text = model?.tongTienGiamGiaDVSPTHE?.formatnumberWithCurrency()
            self.discountBillLabel.text = model?.tongTienGiamGiaHD?.formatnumberWithCurrency()
            self.originLabel.text = model?.tongTienThanhToan?.formatnumberWithCurrency()
            self.notedTextfield.text = model?.ghiChu

            if model?.trangthaiSwipe == 0 || model?.trangthaiSwipe == 5 {
                self.discountInvoteButton.isHidden = false
                self.confirmPaymentButton.isHidden = false
                self.cancelPaymentButton.isHidden = false
            } else {
                self.confirmPaymentButton.isHidden = true
                self.cancelPaymentButton.isHidden = true
                self.discountInvoteButton.isHidden = true
            }
        }
    }

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var discountBillLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var notedTextfield: MyTextField!
    @IBOutlet weak var discountInvoteButton: UIButton!
    @IBOutlet weak var confirmPaymentButton: MyGradientButton!
    @IBOutlet weak var cancelPaymentButton: MyGradientButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
