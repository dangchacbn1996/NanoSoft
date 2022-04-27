//
//  HeaderCreateSaleTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class HeaderCreateSaleTableViewCell: UITableViewCell, ReusableCell {
    typealias T = CellViewCreateSale

    var item: CellViewCreateSale? {
          didSet {
            let model = item?.property?.model?.header
            let modessl = item?.property?.model?.customer
            self.avartaImageview.avartaImageView(url: modessl?.anhKhachHang ?? "")
        }
    }

    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var statusImageview: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    @IBOutlet weak var addServiceButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
             self.datetimeLabel.text = Date().getFormattedDate(format: "dd/MM/yyyy HH:mm:ss")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
