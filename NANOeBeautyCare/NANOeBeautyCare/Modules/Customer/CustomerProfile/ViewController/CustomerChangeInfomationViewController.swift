//
//  CustomerChangeInfomationViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/08/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class CustomerChangeInfomationViewController: UIViewController {
    private var stackMain = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 24)
    private var ipName: InputTextField!
    private var ipBirth: InputTextField!
    private var ipSex: InputTextField!
    private var ipPhone: InputTextField!
    private var ipAddress: InputTextView!
    private var ipCity: InputTextField!
    private var ipDistrict: InputTextField!
    
    private var ipEmail: InputTextField!
    private var ipFacebook: InputTextField!
    private var ipJob: InputTextField!
    private var ipCompany: InputTextField!
    private var ipSource: InputTextField!
    private var ipSale: InputTextField!
    private var ipType: InputTextField!
    private var ipNote: InputTextView!
    
    private var service = CustomerProfileService()
    private var userData: CustomerProfileOptionalResponse?
    private var userUpdate: CustomerProfileService.UpdateUserInfoReqquest = CustomerProfileService.UpdateUserInfoReqquest()
    
    private var listQuanHuyen: [ModelOptionResponseDistrictsByProvinceCodeCatalogDatum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let user = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self) {
            self.userData = user
            userUpdate = CustomerProfileService.UpdateUserInfoReqquest(AnhKhachHang: "", CongTy: "", DiaChi: user.diaChi, DienThoai: user.dienThoai, Email: user.email, FaceBook: "", GhiChu: "", HoTen: user.hoTen, ID: user.id, IDLoaiKH: nil, IDNgheNghiep: user.idNgheNghiep, IDNguonDen: user.idNguonDen, IDNguonGioiThieu: user.idNguonGioiThieu, IdGioiTinh: user.idGioiTinh, MaChiNhanh: "", MaGioiTinh: "\(user.idGioiTinh)", MaKhachHang: "\(user.id)", MaQuanHuyen: user.maQuanHuyen, MaTinhThanh: user.maTinhThanh, NgayCapNhat: "", NgayDen: "", NgaySinh: user.ngaySinh, NgayTao: "", STT: nil, SoDiDong: user.dienThoai)
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
        
        ipEmail.setDefaultContent(userData?.email)
//        ipFacebook.setDefaultContent(userData?.)
        ipCity.setDefaultContent(userData?.tenTinhThanh)
        ipDistrict.setDefaultContent(userData?.tenQuanHuyen)
        ipJob.setDefaultContent(userData?.tenNgheNghiep)
        
        if let idNguonDen = userData?.idNguonDen {
            if let nguonDen = SessionManager.shared.listNguonDen.first(where: {$0.idNguonDen == idNguonDen})?.tenNguonDen {
                ipSource.setDefaultContent(nguonDen)
            }
        }
        
        if let idGioithieu = userData?.idNguonGioiThieu {
            if let gioithieu = SessionManager.shared.listNguonGioiThieu.first(where: {$0.idNguonGioiThieu == idGioithieu})?.nguonGioiThieu {
                ipSale.setDefaultContent(gioithieu)
            }
        }
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc private func actConfirm() {
        userUpdate.HoTen = ipName.content
        userUpdate.NgaySinh = ipBirth.content
        userUpdate.DienThoai = ipPhone.content
        userUpdate.DiaChi = ipAddress.content
        userUpdate.Email = ipEmail.content
        userUpdate.FaceBook = ipFacebook.content
        userUpdate.CongTy = ipCompany.content
        userUpdate.GhiChu = ipNote.content
        
        service.actChangeUserInfo(requestData: userUpdate) { code, error in
            CommonView.alert(title: "Đóng", description: error ?? "Có lỗi xảy ra!")
        } success: {
            CommonView.alert(title: "Đóng", description: "Cập nhật thông tin thành công!")
        }

    }
}

extension CustomerChangeInfomationViewController {
    private func setupUI() {
        self.title = "Thay đổi thông tin"
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
        
        func setViewUser() {
            let cardUser = CardView()
            cardUser.backgroundColor = .white
            cardUser.cornerradius = 12
            stackMain.addArrangedSubview(cardUser)
            
            let vAvartar = UIView()
            cardUser.addSubview(vAvartar)
            vAvartar.snp.makeConstraints({
                $0.centerX.width.equalToSuperview()
                $0.top.equalToSuperview().offset(8)
                $0.height.equalTo(102)
            })
            let stackUser = UIStackView(axis: .vertical, distribution: .equalSpacing, alignment: .fill, spacing: 12)
            cardUser.addSubview(stackUser)
            stackUser.snp.makeConstraints({
                $0.top.equalTo(vAvartar.snp.bottom).offset(16)
                $0.centerX.equalToSuperview()
                $0.width.equalToSuperview().offset(-16)
                $0.bottom.equalToSuperview().offset(-8)
            })
            
            ipName = InputTextField.normal(title: "Họ và tên", required: true, placeholder: "Nhập họ tên")
            stackUser.addArrangedSubview(ipName)
            
            let subStack = UIStackView(axis: .horizontal, distribution: .fill, alignment: .fill, spacing: stackUser.spacing)
            stackUser.addArrangedSubview(subStack)
            ipBirth = InputTextField.calendar(title: "Ngày sinh", placeholder: "  /  /", timeMode: .ddMMyyyy, completion: nil)
            subStack.addArrangedSubview(ipBirth)
            ipBirth.snp.makeConstraints({
                $0.width.equalToSuperview().multipliedBy(0.7)
            })
            
            ipSex = InputTextField.droplist(title: "Giới tính", placeholder: "Chọn", listOpts: ["Nam", "Nữ"], selected: { val, index in
                
            })
            subStack.addArrangedSubview(ipSex)
            
            ipPhone = InputTextField.normal(title: "Điện thoại", required: true, placeholder: "Nhập số điện thoại")
            ipPhone.tfContent.keyboardType = .numberPad
            stackUser.addArrangedSubview(ipPhone)
            
            //Thanh pho
            ipCity = InputTextField.droplist(title: "Tỉnh/Thành phố", placeholder: "Chọn tỉnh/thành phố", preload: {
                let listProvinceName = SessionManager.shared.listProvince.map({$0.tenTinhThanh ?? "Unknow"})
                self.ipCity.actShowDrop(listData: listProvinceName)
            }, selected: {selected, index in
                self.userUpdate.MaTinhThanh = SessionManager.shared.listProvince[index].maTinhThanh
            })
            stackUser.addArrangedSubview(ipCity)
            
            //Quan Huyen
            ipDistrict = InputTextField.droplist(title: "Quận/Huyện", placeholder: "Chọn quận/huyện", preload: {
                self.listQuanHuyen = []
                self.service.systemDistrictsByProvinceCodeCatalog(maTinhThanh: "") { code, error in
                    CommonView.alert(title: "Thông báo", description: error ?? "")
                } success: { model in
                    if let list = model.data {
                        self.listQuanHuyen = list
                        let listDictrictName = list.map({$0.tenQuanHuyen ?? "Unknow"})
                        self.ipDistrict.actShowDrop(listData: listDictrictName)
                    }
                    else {
                        CommonView.alert(title: "Thông báo", description: "Không tìm thấy thông tin quận huyện")
                    }
                }
                
            }, selected: {selected, index in
                self.userUpdate.MaQuanHuyen = self.listQuanHuyen[index].maQuanHuyen
            })
            stackUser.addArrangedSubview(ipDistrict)
            
            ipAddress = InputTextView(title: "Địa chỉ", placeholder: "Nhập địa chỉ")
            ipAddress.tvContent.textContentType = .addressCityAndState
            stackUser.addArrangedSubview(ipAddress)
        }
        setViewUser()
        
        func setViewInfo() {
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
            
            ipEmail = InputTextField.normal(title: "Email", placeholder: "Nhập email")
            ipEmail.tfContent.textContentType = .emailAddress
            stackInfo.addArrangedSubview(ipEmail)
            
            ipFacebook = InputTextField.normal(title: "Facebook", placeholder: "Nhập tên facebook")
            stackInfo.addArrangedSubview(ipFacebook)
            
            //Nghê nghiệp
            ipJob = InputTextField.droplist(title: "Nghề nghiệp", placeholder: "Chọn nghề nghiệp", preload: {
                let listName = SessionManager.shared.listNgheNghiep.map({$0.tenNgheNghiep ?? "Unknow"})
                self.ipJob.actShowDrop(listData: listName)
            }, selected: {selected, index in
                self.userUpdate.IDNgheNghiep = SessionManager.shared.listNgheNghiep[index].idNgheNghiep
            })
            stackInfo.addArrangedSubview(ipJob)
            
            ipCompany = InputTextField.normal(title: "Tên công ty", placeholder: "Nhập tên công ty")
            stackInfo.addArrangedSubview(ipCompany)
            
            //Nghê nghiệp
            ipSource = InputTextField.droplist(title: "Nguồn đến", placeholder: "Chọn nguồn đến", preload: {
                let listName = SessionManager.shared.listNguonDen.map({$0.tenNguonDen ?? "Unknow"})
                self.ipSource.actShowDrop(listData: listName)
            }, selected: {selected, index in
                self.userUpdate.IDNguonDen = SessionManager.shared.listNguonDen[index].idNguonDen
            })
            stackInfo.addArrangedSubview(ipSource)
            
            //Nghê nghiệp
            ipSale = InputTextField.droplist(title: "Giới thiệu", placeholder: "Chọn nguồn giới thiệu", preload: {
                let listName = SessionManager.shared.listNguonGioiThieu.map({$0.nguonGioiThieu ?? "Unknow"})
                self.ipSale.actShowDrop(listData: listName)
            }, selected: {selected, index in
                self.userUpdate.IDNguonGioiThieu = SessionManager.shared.listNguonGioiThieu[index].idNguonGioiThieu
            })
            stackInfo.addArrangedSubview(ipSale)
            
            ipNote = InputTextView(title: "Ghi chú", placeholder: "Nhập ghi chú", isRequired: false)
            stackInfo.addArrangedSubview(ipNote)
        }
        setViewInfo()
    }
}
