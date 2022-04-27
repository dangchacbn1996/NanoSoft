//
//  DetailTreatmentTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/30/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class DetailTreatmentTableViewCell: UITableViewCell,ReusableCell {

    typealias T = DefaultCellModel<DetailTreatmentOptionalResponse>
    @IBOutlet weak var statusImageview: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var moreImageButton: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var item: DefaultCellModel<DetailTreatmentOptionalResponse>? {
        didSet {
            let model = item?.property?.model
            let (_, imageStatus) = Common.statusWithColor(statusNumber: model?.trangThaiLieuTrinh ?? 0)
            self.statusImageview.image = imageStatus
            
            self.statusLabel.text = model?.trangThaiLieuTrinhText
            self.titleLabel.text = "\(model?.ngayDuKienThucHien ?? "") - \(model?.ngayThucHien ?? "")"
            self.descLabel.text = "Công việc thực hiện: \(model?.ghiChu1 ?? "")"
        }
    }

    @IBAction func moreButtonAction(_ sender: Any) {
    }
}
