//
//  AppointmentTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class AppointmentTableViewCell:UITableViewCell, ReusableCell {
    typealias T = CellViewAppointment
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var moreAction: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //    TrangThai:
    //    -1 = Tất cả,
    //    0=Tạo mới - Xám - 9B9B9B
    //    1=Đã xác nhận - Cam - F87F28
    //    2=Chờ phục vụ - Cam - F87F28
    //    3=Hủy - Đỏ - EC1111
    //    4=Đang phục vụ - Xanh - 4E94E4
    //    5=Hoàn thành - Xanh lá cây - 00791F

    func statusWithColor(statusNumber: Int) -> (UIColor, UIImage?){
        if statusNumber == 0 {
            return (UIColor(hex: "9B9B9B"),  UIImage(named: "ic-new"))
        } else if statusNumber == 1 {
            return (UIColor(hex: "F87F28"),  UIImage(named: "ic-wait"))
        } else if statusNumber == 2 {
            return (UIColor(hex: "F87F28"),  UIImage(named: "ic-wait"))
        } else if statusNumber == 3 {
            return (UIColor(hex: "EC1111"), UIImage(named: "ic-cancel"))
        } else if statusNumber == 4 {
            return (UIColor(hex: "47C9E4"),  UIImage(named: "ic-progerss"))
        } else if statusNumber == 5 {
            return (AppColors.primaryColor,  UIImage(named: "ic-success"))
        }
        return (UIColor(hex: "9B9B9B"),  UIImage(named: "ic-cancel"))
    }

    var item: CellViewAppointment? {
        didSet {
            self.statusLabel.textColor = self.statusWithColor(statusNumber: item?.property?.model?.trangThai ?? -1).0
            self.statusImageView.image = self.statusWithColor(statusNumber: item?.property?.model?.trangThai ?? -1).1
            self.statusLabel.text = item?.property?.model?.trangThaiText
            self.nameLabel.text = item?.property?.model?.tenKhachHangDatHen

            self.timeLabel.text = item?.property?.model?.batDau?.setStringToDate()?.getFormattedDate(format: "HH:mm")
            self.descLabel.text = item?.property?.model?.dichVuYeuCau
            self.phoneLabel.text = item?.property?.model?.soDienThoai
        }
    }

}
