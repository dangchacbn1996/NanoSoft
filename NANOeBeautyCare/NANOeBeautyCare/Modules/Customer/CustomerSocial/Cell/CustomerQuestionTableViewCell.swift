//
//  CustomerQuestionTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/10/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerQuestionTableViewCell: UITableViewCell,ReusableCell {

    typealias T = CellViewCustomerSocialDetail
    
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var item: CellViewCustomerSocialDetail? {
        didSet {
            let model = item?.property?.model
            self.avartaImageview.image = UIImage(named: "ic-question")
            self.dateLabel.text = model?.ngayTao
            self.descLabel.text = model?.noiDungCauHoi
        }
    }
}
