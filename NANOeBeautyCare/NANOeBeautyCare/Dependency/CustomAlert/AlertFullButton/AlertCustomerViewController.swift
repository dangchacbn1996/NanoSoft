//
//  AlertCustomerViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/5/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

let KGetAvarta = "KGetAvarta"

class AlertCustomerViewController: SwiftPopup {
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var addButton: UIButton!

    var dataModel: HomeOptionalResponse?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss()

    }

    @IBAction func callButtonAction(_ sender: Any) {
        if let model = self.dataModel {
            if let url = URL(string: "tel://\(model.dienThoai ?? "")") {
                 UIApplication.shared.openURL(url)
             }
        }
    }

    @IBAction func messageButtonAction(_ sender: Any) {
        if let model = self.dataModel {
            if let url = URL(string: "sms:+\(model.dienThoai ?? "")&body=\(model.tenHangThanhVien ?? "")") {
                 UIApplication.shared.openURL(url)
             }
        }
    }

    @IBAction func calendarButtonAction(_ sender: Any) {
        if let model = self.dataModel {
            self.dismiss {
                if var prevRoutableController = UIApplication.topViewController() as? BaseView {
                    let item = AppointmentOptionalResponse(totalRow: nil, tieuDe: nil, maKhachHang: "", tenKhachHangDatHen: model.hoTen ?? "", ngaySinh: "", ghiChu: "", listMaDichVuYeuCau: "", ngayTao: nil, batDau: nil, ketThuc: nil, dateModified: nil, trangThai: nil, soDienThoai: model.dienThoai ?? "", email: "", idLichHen: nil, trangThaiText: nil, dichVuYeuCau: nil)
                    prevRoutableController.openChildScreen(.CreateAppointmentViewController, fromStoryboard: .Appointment, withContext: RouteContext([RVContext:item]))
                }
            }
        }
    }

    @IBAction func addButtonAction(_ sender: Any) {
        if let model = self.dataModel {
            self.dismiss {
                if var prevRoutableController = UIApplication.topViewController() as? BaseView {
                    prevRoutableController.openChildScreen(.CreateSaleServiceViewController, fromStoryboard: .Sales, withContext: RouteContext([KGetAvarta:model.hoTen ?? ""]))
                }
            }
        }
//        if let model = self.dataModel {
//
//        }
    }


}
