//
//  TreatmentTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class TreatmentTableViewCell:UITableViewCell,ReusableCell {
    
    typealias T = DefaultCellModel<TreatmentOptionalResponse>
    @IBOutlet weak var statusImageview: CircularImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var item: DefaultCellModel<TreatmentOptionalResponse>? {
        didSet {
            let model = item?.property?.model
            let (_, imageStatus) = Common.statusWithColor(statusNumber: model?.trangThaiDieuTri ?? 0)
            self.statusImageview.image = imageStatus
            self.statusLabel.text = model?.trangThaiDieuTriText
            self.titleLabel.text = model?.hoTen
            self.descLabel.text = model?.tenDichVu
            self.numberLabel.text = model?.soLuongDaThucHien
            
            self.avartaImageview.avartaImageView(url: Common.stringToUrlImage(text: model?.anhKhachHang ?? ""))
        }
    }
    
    @IBAction func moreButtonAction(_ sender: Any) {
    }
}
