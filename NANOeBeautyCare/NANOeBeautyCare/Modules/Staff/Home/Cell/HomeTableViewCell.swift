//
//  HomeTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell,ReusableCell {

    typealias T = DefaultCellModel<HomeOptionalResponse>

    @IBOutlet weak var avartaImageview: CircularImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var leverLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
 
    var item: DefaultCellModel<HomeOptionalResponse>? {
        didSet {
            let model = item?.property?.model
            self.avartaImageview.avartaImageView(url: Common.stringToUrlImage(text: model?.anhKhachHang ?? ""))
            self.titleLabel.text = model?.hoTen ?? ""
            self.phoneLabel.text = model?.dienThoai ?? ""
            
            self.addressLabel.text = [model?.diaChi ?? "",model?.tenQuanHuyen ?? "",model?.tenTinhThanh ?? ""].joined(separator: ",")
            self.leverLabel.text = model?.tenHangThanhVien ?? ""
            self.numberLabel.text = "\(model?.tongDiemTichLuy ?? 0)"
        }
    }
}
