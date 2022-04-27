//
//  CustomerHomeFilterTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 24/11/2020.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerHomeFilterTableViewCell: UITableViewCell,ReusableCell {
    @IBOutlet weak var pictureImageview: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var appointmentButton: UIButton!
    @IBOutlet weak var originPriceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    typealias T = DefaultCellModel<SuggestionCustomerHomeOptionalResponse>

    var item: DefaultCellModel<SuggestionCustomerHomeOptionalResponse>? {
        didSet {
            let model = item?.property?.model
            if let data = model {
                self.pictureImageview.pictureImageView(url: Common.stringToUrlImage(text: data.anhDichVu ?? ""))
                self.titleLabel.text = data.tenDichVu
                self.descLabel.text = data.tomTat
                self.originPriceLabel.text = data.donGianNiemYet?.formatnumberWithCurrency()
                self.discountPriceLabel.attributedText = data.donGia?.formatnumberWithCurrency().strikeThrough()
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
