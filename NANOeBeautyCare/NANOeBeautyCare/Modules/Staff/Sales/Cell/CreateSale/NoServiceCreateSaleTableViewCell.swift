//
//  NoServiceCreateSaleTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class NoServiceCreateSaleTableViewCell: UITableViewCell, ReusableCell {

    typealias T = CellViewCreateSale

    var item: CellViewCreateSale? {
        didSet {
            let model = item?.property?.model
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
