//
//  KhaiBaoYTeViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 26/07/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class KhaiBaoYTeViewController: UIViewController {
    
    private var stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 24)
    private var ipName: InputTextField!
    private var ipBirth: InputTextField!
    private var ipPhone: InputTextField!
    private var ipSex: InputTextField!
    private var ipAddress: InputTextView!
    private var ipCurrentStatus: InputTextField!
    private var ipHeartBeat: InputTextField!
    private var ipTemp: InputTextField!
    private var ipPressure: InputTextField!
    
    private var service = HospitalService()
    private var userData: CustomerProfileOptionalResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let user = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self) {
            self.userData = user
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ipName.setDefaultContent(userData?.hoTen)
        ipBirth.setDefaultContent(userData?.ngaySinh)
        if let dateString = userData?.ngaySinh {
            if let date = Date(string: dateString, format: "dd/MM/yyyy hh:mm") {
                ipBirth.setDefaultContent(date.toString(format: "dd/MM/yyyy"))
            }
        }
        ipPhone.setDefaultContent(userData?.dienThoai)
        ipSex.setDefaultContent(userData?.tenGioiTinh)
        ipAddress.setDefaultContent(userData?.diaChi)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func actConfirm() {
        let listCheck : [InputBase] = [ipName, ipBirth, ipPhone, ipSex, ipAddress, ipCurrentStatus, ipHeartBeat, ipTemp, ipPressure]
        for item in listCheck {
            if !item.isValidateRequired() {
                let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: "Vui lòng điền đẩy đủ thông tin cần thiết", image: nil, style: .alert)
                
                alertVC.addAction(PMAlertAction(title: "Đồng ý", style: .default, action: {
                    alertVC.dismiss(animated: true, completion: nil)
                }))
                
                UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
                return
            }
        }
        var request = CreateAppointmentRequest(idLichHen: 0, tieuDe: "Khai báo y tế", maKhachHang: "", tenKhachHangDatHen: "", ngaySinh: "", maGioiTinh: 0, maTinhThanh: "", maQuanHuyen: "", diaChi: "", soDienThoai: "", email: "", batDau: "", ghiChu: "", soLuongKhach: 1, listMaDichVuYeuCau: "", listMaNhanVienYeuCau: "", idPhongDichVu: 0, idNguonDen: 0, idNguonGioiThieu: 0, trangThai: 0, khachHangID: (Common.BRAND_TYPE == BrandTypeEnum.Customer.rawValue) ? Common.BRAND_USER_ID : 0, idComboGoiDVSP: 0, maLoaiDichVu: "", tinhTrangHienTai: "", tienSuBenhLyBanThan: "", tienSuBenhLyGiaDinh: "", nhipTim: "", nhietDo: "", huyetAp: "")
        request.tenKhachHangDatHen = ipName.content
        request.ngaySinh = ipBirth.content
        request.soDienThoai = ipPhone.content
        request.maGioiTinh = ipSex.content == "Nam" ? 1 : 0
        request.diaChi = ipAddress.content
        request.tinhTrangHienTai = ipCurrentStatus.content
        request.nhipTim = ipHeartBeat.content
        request.nhietDo = ipTemp.content
        request.huyetAp = ipPressure.content
        request.maLoaiDichVu = "TSK"
        
        
        service.hospitalKhaiBaoYTe(requestData: request)  { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: CreateAppointmentOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                CommonView.alert(self, title: "Thành công", description: "Quý khách đã khai báo y tế thành công!") { alert in
                    self.navigationController?.popViewController(animated: true)
                }
            }) { (repo) in

            }
        }
        
    }
}

extension KhaiBaoYTeViewController {
    private func setupUI() {
        self.title = "Khai báo y tế"
        self.view.backgroundColor = .white
        
        let btnRightSave = UIButton()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnRightSave)
//        self.navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnRightSave)
        btnRightSave.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actConfirm)))
        btnRightSave.setImage(UIImage(named: "ic-floppy-disk"), for: .normal)
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        scrollView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
        
        scrollView.addSubview(stackMain)
        stackMain.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.width.equalTo(self.view.snp.width).offset(-32)
        })
        
        ipName = InputTextField.normal(title: "Họ và tên", required: true, placeholder: "Nhập họ tên")
        ipName.setEditable(false)
        ipBirth = InputTextField.calendar(title: "Ngày sinh", placeholder: "  /  /", timeMode: .ddMMyyyy, completion: nil)
        ipBirth.setEditable(false)
        ipPhone = InputTextField.normal(title: "Điện thoại", required: true, placeholder: "Nhập số điện thoại")
        ipPhone.setEditable(false)
        ipSex = InputTextField.droplist(title: "Giới tính", placeholder: "Chọn", listOpts: ["Nam", "Nữ"], selected: { val, index in
            
        })
        ipSex.setEditable(false)
//        ipAddress = InputTextField.normal(title: "Địa chỉ", placeholder: "Nhập địa chỉ")
        ipAddress = InputTextView(title: "Địa chỉ", placeholder: "Nhập địa chỉ")
        ipAddress.setEditable(false)
        
        ipCurrentStatus = InputTextField.textView(title: "Tình trạng hiện tại",required: true, placeholder: "Nhập tình trạng hiện tại")
        ipHeartBeat = InputTextField.normal(title: "Nhịp tim", placeholder: "Nhập nhịp tim")
        ipHeartBeat.tfContent.keyboardType = .numberPad
        ipTemp = InputTextField.normal(title: "Nhiệt độ", placeholder: "Nhập nhiệt độ")
        ipTemp.tfContent.keyboardType = .numberPad
        ipPressure = InputTextField.normal(title: "Huyết áp", placeholder: "Nhập huyết áp")
        ipPressure.tfContent.keyboardType = .numberPad
        
        let cardUser = CardView()
        cardUser.backgroundColor = .white
        cardUser.cornerradius = 12
        stackMain.addArrangedSubview(cardUser)
        let stackUser = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 12)
        cardUser.addSubview(stackUser)
        stackUser.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().offset(-16)
        })
        stackUser.addArrangedSubview(ipName)
        stackUser.addArrangedSubview(ipBirth)
        let vSub = UIView()
        stackUser.addArrangedSubview(vSub)
        vSub.addSubview(ipPhone)
        ipPhone.snp.makeConstraints({
            $0.leading.centerY.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.6)
        })
        
        vSub.addSubview(ipSex)
        ipSex.snp.makeConstraints({
            $0.trailing.centerY.height.equalToSuperview()
            $0.leading.equalTo(ipPhone.snp.trailing).offset(12)
        })
        
        stackUser.addArrangedSubview(ipAddress)
        
        let cardInfo = CardView()
        cardInfo.backgroundColor = .white
        cardInfo.cornerradius = 12
        stackMain.addArrangedSubview(cardInfo)
        let stackInfo = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 12)
        cardInfo.addSubview(stackInfo)
        stackInfo.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().offset(-16)
        })
        stackInfo.addArrangedSubview(ipCurrentStatus)
        stackInfo.addArrangedSubview(ipHeartBeat)
        stackInfo.addArrangedSubview(ipTemp)
        stackInfo.addArrangedSubview(ipPressure)
        
    }
}
