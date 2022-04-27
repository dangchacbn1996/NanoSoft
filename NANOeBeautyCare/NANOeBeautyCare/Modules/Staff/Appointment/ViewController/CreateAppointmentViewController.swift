//
//  CreateAppointmentViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateAppointmentViewController: BaseViewController<CreateAppointmentPresenter> {
    @IBOutlet weak var statusImageview: UIImageView!
    // MARK: - IBOutlet
    @IBOutlet weak var stMain: UIStackView!
    @IBOutlet weak var infomationView: CardView!
    @IBOutlet weak var viewListSearchBar: CardView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.registerXIB(SearchCustomerTableViewCell.identfier)
        }
    }

    var items: [CustomFormModelElement] = []

    var dataSource: TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>,
    DefaultCellModel<CustomFormModelElement>,
    CustomFormModelElement>?

    private var searchActive = false
    // Card View 1st
    @IBOutlet weak var fullnameTextfield: MyTextField!
    @IBOutlet weak var birthTextfield: MyTextField!
    @IBOutlet weak var phoneTextfield: MyTextField!
    @IBOutlet weak var sexTextfield: MyTextField!
    @IBOutlet weak var sexButton: UIButton!
    @IBOutlet weak var addressTextfield: MyTextField!
    @IBOutlet weak var cityTextfield: MyTextField!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var districtTextfield: MyTextField!
    @IBOutlet weak var districtButton: UIButton!
    // Card View 2rd
    @IBOutlet weak var descTextfield: MyTextField!
    @IBOutlet weak var dateTextfield: MyTextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var timeTextfield: MyTextField!
    @IBOutlet weak var timeButton: UIButton!
    @IBOutlet weak var tfStatus: MyTextField!
    @IBOutlet weak var tfTienSuCaNhan: MyTextField!
    @IBOutlet weak var tfTienSuGiaDinh: MyTextField!

    @IBOutlet weak var cvDetail: CardView!
    
    @IBOutlet weak var minusNumberCustomerButton: UIButton!
    @IBOutlet weak var numberCustomerTextfield: MyTextField!
    @IBOutlet weak var plusNumberCustomerButton: UIButton!

    @IBOutlet weak var noteTextfield: MyTextField!

    @IBOutlet weak var stInfo: UIStackView!
    private var ipSource: InputTextField!
    private var ipService: InputTextField!
    private var ipServicePack: InputTextField!
    private var ipMember: InputTextField!
    private var ipRoom: InputTextField!
    private var ipStatus: InputTextField!
    private let vContact = CardView()
    private var phone: String = "" {
        didSet {
            vContact.isHidden = phone.isEmpty
        }
    }


    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CreateAppointmentPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Chi tiết lịch hẹn".localized
        
        ipSource = InputTextField.droplist(title: "Nguồn đặt", placeholder: "Chọn nguồn đặt", listOpts: SessionManager.shared.listNguonDen.map({$0.tenNguonDen ?? "-"}), selected: { string, index in
            self.presenter?.createRequestModel.idNguonDen = SessionManager.shared.listNguonDen[index].idNguonDen
        })
        stInfo.addArrangedSubview(ipSource)
        
        ipService = InputTextField.alertTable(title: "Dịch vụ", placeholder: "Chọn dịch vụ", load: {
            CommonView.alertServiceCatalogData(isSelected: self.presenter?.dataDetailAppointment?.listMaDichVuYeuCau ?? "") { (selected) in
                let idMember = selected.map {String($0.idDichVu!)}
                let stringMember = selected.map {String($0.tenDichVu!)}
                self.presenter?.createRequestModel.listMaDichVuYeuCau = idMember.joined(separator: ",")
                self.presenter?.dataDetailAppointment?.listMaDichVuYeuCau = idMember.joined(separator: ",")
                self.ipService.setDefaultContent(stringMember.joined(separator: ","))
            }
        })
        stInfo.addArrangedSubview(ipService)
        
        ipServicePack = InputTextField.droplist(title: "Gói dịch vụ", placeholder: "Chọn gói dịch vụ", listOpts: SessionManager.shared.listServicePackage.map({$0.TenComboGoiDVSP ?? "-"}), selected: { string, index in
            self.presenter?.createRequestModel.idComboGoiDVSP = SessionManager.shared.listServicePackage[index].IDComboGoiDVSP
        })
        stInfo.addArrangedSubview(ipServicePack)

        
        ipMember = InputTextField.alertTable(title: "Chuyên viên", placeholder: "Chọn chuyên viên", load: {
            CommonView.alertEmployeeAndSearchCatalog(isSelected: self.presenter?.dataDetailAppointment?.listMaNhanVienYeuCau ?? "") { (selected) in
                let idMember = selected.map {String($0.idNhanVien!)}
                let stringMember = selected.map {String($0.tenNhanVien!)}
                self.presenter?.createRequestModel.listMaNhanVienYeuCau = idMember.joined(separator: ",")
                self.presenter?.dataDetailAppointment?.listMaNhanVienYeuCau = idMember.joined(separator: ",")
                self.ipMember.setDefaultContent(stringMember.joined(separator: ","))
            }
        })
        stInfo.addArrangedSubview(ipMember)
        
        ipRoom = InputTextField.droplist(title: "Phòng dịch vụ", placeholder: "Chọn phòng dịch vụ", listOpts: Common.roomCatalogData.map({$0.tenPhongDichVu ?? "-"}), selected: { string, index in
            self.presenter?.createRequestModel.idPhongDichVu = Common.roomCatalogData[index].idPhongBan
        })
        stInfo.addArrangedSubview(ipRoom)
        
        ipStatus = InputTextField.alertTable(title: "Trạng thái", placeholder: "", load: {
            let brandType = Common.BRAND_TYPE
            if brandType == BrandTypeEnum.Staff.rawValue {
                CommonView.alertStatusCatalog { (selected) in
                    self.presenter?.createRequestModel.trangThai = selected.id
                    self.ipStatus.setDefaultContent(selected.trangThai)
                }
            } else {

            }
        })
        stInfo.addArrangedSubview(ipStatus)
        
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        
        self.dateButton.imageView?.tintColor = AppColors.viewBlue
        self.timeButton.imageView?.tintColor = AppColors.viewBlue
        self.minusNumberCustomerButton.imageView?.tintColor = AppColors.viewBlue
        self.plusNumberCustomerButton.imageView?.tintColor = AppColors.viewBlue

        let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
        self.navigationItem.rightBarButtonItems = [saveItem]

        self.configureTableView()
        self.addContactView()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let brandType = Common.BRAND_TYPE
        if brandType == BrandTypeEnum.Staff.rawValue {
            self.ipStatus.setEditable(true)
            self.ipStatus.setDefaultContent(Common.typeStatusCatelogData.first?.trangThai ?? "")
            self.presenter?.createRequestModel.trangThai = Common.typeStatusCatelogData.first?.id ?? -1
        } else {
            self.ipStatus.setDefaultContent(Common.typeStatusCatelogData.first?.trangThai ?? "")
            self.presenter?.createRequestModel.trangThai = Common.typeStatusCatelogData.first?.id ?? -1
            self.ipStatus.setEditable(false)
        }
    }
    
    func reloadLayout(code: String) {
        switch code {
        case "KTN":
            cvDetail.isHidden = true
        default:
            cvDetail.isHidden = false
        }
    }
    
    private func addContactView() {
        self.phone = DataManager.shared.companyModel?.DienThoai ?? ""
        vContact.shadowColors = AppColors.gray
        vContact.backgroundColor = .white
        //Under SearchBar
//        stMain.addArrangedSubview(vContact)
        stMain.insertArrangedSubview(vContact, at: 1)
        vContact.cornerradius = 4
        vContact.clipsToBounds = true
        vContact.snp.makeConstraints({
//            $0.top.equalToSuperview().offset(4)
//            $0.centerX.equalToSuperview()
            $0.height.equalTo(96)
//            $0.width.equalToSuperview().offset(-36)
//            $0.bottom.equalToSuperview().offset(-8)
        })
        
        let lbTitle = UILabel(text: "HOTLINE", font: .customOpenSans(16, .semiBold), color: AppColors.textBlue, breakable: false)
        vContact.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        })
        
        let vPhone = UIView()
        vContact.addSubview(vPhone)
        vPhone.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.greaterThanOrEqualTo(lbTitle.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-12)
            $0.height.equalTo(28)
        })
        vPhone.layer.cornerRadius = 14
        vPhone.clipsToBounds = true
        vPhone.backgroundColor = AppColors.textBlue
//        vContact.setHorizontalGradient(startColor: AppColors.gradientStart, endColor: AppColors.gradientMid.withAlphaComponent(0.6))
        
        let icContact = UIImageView(image: UIImage(named: "ic_call_home"))
        vPhone.addSubview(icContact)
        icContact.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(8)
            $0.height.equalToSuperview().offset(-8)
            $0.width.equalTo(icContact.snp.height)
        })
        icContact.contentMode = .scaleAspectFit
        
        let lbContact = UILabel(text: phone, font: UIFont.customOpenSans(16, .semiBoldItalic), color: .white, breakable: false)
        vPhone.addSubview(lbContact)
        lbContact.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(icContact.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-12)
        })
        vContact.isUserInteractionEnabled = true
        vContact.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actCall)))
    }
    
    @objc private func actCall() {
        if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    private func configureTableView() {
        let brandType = Common.BRAND_TYPE
        if brandType == BrandTypeEnum.Staff.rawValue {
            self.searchBar.isHidden = false
        } else {
            self.searchBar.isHidden = true
            self.infomationView.isUserInteractionEnabled = false
            let data = UserDefaults.standard.df.fetch(forKey: String(describing: CustomerProfileOptionalResponse.self), type: CustomerProfileOptionalResponse.self)
            self.fullnameTextfield.text = data?.hoTen
            self.presenter?.createRequestModel.tenKhachHangDatHen = self.fullnameTextfield.text

            self.phoneTextfield.text = data?.dienThoai
            self.presenter?.createRequestModel.soDienThoai = self.phoneTextfield.text

            self.sexTextfield.text = data?.tenGioiTinh
            self.presenter?.createRequestModel.maGioiTinh = data?.idGioiTinh ?? 0
            
            if let birthString = data?.ngaySinh {
                if let birth = Date(string: birthString, format: "dd/MM/yyyy hh:mm:ss") {
                    let birthVal = birth.toString(format: "dd/MM/yyyy")
                    self.birthTextfield.text = birthVal
                    self.presenter?.createRequestModel.ngaySinh = birthVal
                }
            }

            self.addressTextfield.text = data?.diaChi
            self.presenter?.createRequestModel.diaChi = self.addressTextfield.text

            self.cityTextfield.text = data?.tenTinhThanh
            self.presenter?.createRequestModel.maTinhThanh = data?.maTinhThanh
            self.presenter?.district(idx: data?.maTinhThanh ?? "", callBack: { (status) in

            })

            self.districtTextfield.text = data?.tenQuanHuyen
            self.presenter?.createRequestModel.maQuanHuyen = data?.maQuanHuyen
        }

        dataSource = TableDataSource<DefaultHeaderFooterModel<CustomFormModelElement>, DefaultCellModel<CustomFormModelElement>, CustomFormModelElement>.init(.SingleListing(items: self.items, identifier: SearchCustomerTableViewCell.identfier, height: UITableView.automaticDimension, leadingSwipe: nil, trailingSwipe: nil), tableView)

        dataSource?.configureCell = { (cell, item, indexPath) in
            (cell as? SearchCustomerTableViewCell)?.item = item
        }

        dataSource?.addPullToRefresh = { [weak self] in
            //                      self?.pageNo = 0
            //                      self?.getNewDataWhenPulled()
            self?.dataSource?.stopInfiniteLoading(.FinishLoading)
        }

        dataSource?.addInfiniteScrolling = { [weak self] (page) in
            //                  self?.pageNo = (self?.pageNo ?? 0) + 1
            //                  self?.addMoreDataWithPaging()
        }
        dataSource?.didSelectRow = { (indexPath, item) in
            guard let model = item?.property?.model?.rawItem as? SearchCustomerAppointmentOptionalResponse else {
                return
            }
            self.fullnameTextfield.text = model.hoTen
            self.presenter?.createRequestModel.tenKhachHangDatHen = self.fullnameTextfield.text

            self.phoneTextfield.text = model.dienThoai
            self.presenter?.createRequestModel.soDienThoai = self.phoneTextfield.text

            self.addressTextfield.text = model.diaChi
            self.presenter?.createRequestModel.diaChi = self.addressTextfield.text

            self.cityTextfield.text = Common.cityData.filter({$0.maTinhThanh == model.maTinhThanh}).first?.tenTinhThanh
            self.presenter?.createRequestModel.maTinhThanh = Common.cityData.filter({$0.maTinhThanh == model.maTinhThanh}).first?.maTinhThanh

            self.presenter?.district(idx: model.maTinhThanh ?? "", callBack: { (status) -> Void in
                self.districtTextfield.text = Common.districtData.filter({$0.maQuanHuyen == model.maQuanHuyen}).first?.tenQuanHuyen
                self.presenter?.createRequestModel.maQuanHuyen = Common.districtData.filter({$0.maQuanHuyen == model.maQuanHuyen}).first?.maQuanHuyen
            })

            self.presenter?.createRequestModel.khachHangID = model.id
            self.presenter?.createRequestModel.email = model.email
//            self.presenter?.createRequestModel.idLichHen = 0
//            self.presenter?.createRequestModel.maKhachHang = data.maKhachHang
            self.presenter?.createRequestModel.ngaySinh = model.ngaySinh
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCreateAppointment) {
    }

    @objc func actionSave() {
        self.hideKeyboard()
        self.presenter?.services()
    }
    
    // MARK: - Action Button
    @IBAction func sexButtonAction(_ sender: Any) {
        CommonView.alertSex { (selected) in
            self.presenter?.createRequestModel.maGioiTinh = selected.id
            self.sexTextfield.text = selected.tenGioiTinh
        }
    }

    @IBAction func cityButtonAction(_ sender: Any) {
        CommonView.alertCity { (selected) in
            self.presenter?.createRequestModel.maTinhThanh = selected.maTinhThanh
            self.presenter?.district(idx: selected.maTinhThanh ?? "", callBack: { (status) in

            })
            self.cityTextfield.text = selected.tenTinhThanh

            self.presenter?.createRequestModel.maQuanHuyen = ""
            self.districtTextfield.text = ""
        }
    }

    @IBAction func districtButtonAction(_ sender: Any) {
        if self.presenter?.createRequestModel.maTinhThanh?.count ?? 0 > 0 {
            CommonView.alertDistrist { (selected) in
                self.presenter?.createRequestModel.maQuanHuyen = selected.maQuanHuyen
                self.districtTextfield.text = selected.tenQuanHuyen
            }
        }
    }
    
    @IBAction func dateOfBirthAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.createRequestModel.ngaySinh?.toDate(withFormat: "dd/MM/yyyy") ?? Date()
        CommonView.alertDate(title: "Ngày sinh", maximumDate: nil, currentdate: currentdate) { (date) in
            self.presenter?.createRequestModel.ngaySinh = date ?? ""
            self.birthTextfield.text = date
        }
    }

    @IBAction func dateButtonAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.createRequestModel.thoigian[1].toDate(withFormat: "dd/MM/yyyy") ?? Date()

        CommonView.alertDate(title: "Ngày hẹn", maximumDate: nil, currentdate: currentdate) { (date) in
            self.presenter?.createRequestModel.thoigian[1] = date ?? ""
            self.dateTextfield.text = date
        }
    }

    @IBAction func timeButtonAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.createRequestModel.thoigian[0].toDate(withFormat: "HH:mm") ?? Date()

        CommonView.alertTime(title: "Thời gian", maximumDate: nil, currentdate: currentdate) { (date) in
            self.presenter?.createRequestModel.thoigian[0] = date ?? ""
            self.timeTextfield.text = date
        }
    }

//    @IBAction func sourceToButtonAction(_ sender: Any) {
//        CommonView.alertSourceTo { (selected) in
//            self.presenter?.createRequestModel.idNguonDen = selected.idNguonDen
//            self.ipSource.text = selected.tenNguonDen
//        }
//    }
//
//    @IBAction func serviceButtonAction(_ sender: Any) {
//
//    }
//
//    @IBAction func memberButtonAction(_ sender: Any) {
//        CommonView.alertEmployeeAndSearchCatalog(isSelected: self.presenter?.dataDetailAppointment?.listMaNhanVienYeuCau ?? "") { (selected) in
//            let idMember = selected.map {String($0.idNhanVien!)}
//            let stringMember = selected.map {String($0.tenNhanVien!)}
//            self.presenter?.createRequestModel.listMaNhanVienYeuCau = idMember.joined(separator: ",")
//            self.presenter?.dataDetailAppointment?.listMaNhanVienYeuCau = idMember.joined(separator: ",")
//            self.ipMember.text = stringMember.joined(separator: ",")
//        }
//    }
//
//    @IBAction func roomButtonAction(_ sender: Any) {
//        CommonView.alertRoomCatalog { (selected) in
//            self.presenter?.createRequestModel.idPhongDichVu = selected.idPhongBan
//            self.ipRoom.text = selected.tenPhongDichVu
//        }
//    }
//
//    @IBAction func statusButtonAction(_ sender: Any) {
//        let brandType = Common.BRAND_TYPE
//        if brandType == BrandTypeEnum.Staff.rawValue {
//            CommonView.alertStatusCatalog { (selected) in
//                self.presenter?.createRequestModel.trangThai = selected.id
//                self.ipStatus.text = selected.trangThai
//            }
//        } else {
//
//        }
//    }

    @IBAction func minusNumberCustomerButtonAction(_ sender: Any) {
        let number = Int(self.numberCustomerTextfield.text ?? "1") ?? 1
        if number == 0 || number == 1 {
            self.numberCustomerTextfield.text = "1"
            self.presenter?.createRequestModel.soLuongKhach = 1
        } else {
            self.numberCustomerTextfield.text = "\(number-1)"
            self.presenter?.createRequestModel.soLuongKhach = number-1
        }
    }

    @IBAction func plusNumberCustomerButtonAction(_ sender: Any) {
        let number = Int(self.numberCustomerTextfield.text ?? "1") ?? 1
        self.numberCustomerTextfield.text = "\(number+1)"
        self.presenter?.createRequestModel.soLuongKhach = number+1
    }
}

// MARK: - Protocol of Presenter
extension CreateAppointmentViewController: CreateAppointmentVC {
    func updateDataComboService(data: ResponseComboServiceModel) {
        self.ipServicePack.setDefaultContent(data.TenComboGoiDVSP)
        self.presenter?.createRequestModel.idComboGoiDVSP = data.IDComboGoiDVSP ?? nil
    }

    func updateDataService(data: [ResponseProductListSubModel]) {
        var listName = ""
        var listId = ""
        if data.count > 0 {
            listName += data[0].TenDichVu ?? ""
            listId += data[0].ID?.toString() ?? ""
        }
        if data.count > 1 {
            for i in 1..<data.count {
                listName += ", " + (data[i].TenDichVu ?? "")
                listId += ", " + (data[i].ID?.toString() ?? "")
            }
        }
        
        
        self.ipService.setDefaultContent(listName)
        self.presenter?.createRequestModel.listMaDichVuYeuCau = listId
    }

    func updateDataCustomer(data: SuggestionCustomerHomeOptionalResponse) {
        self.ipService.setDefaultContent(data.tenDichVu)
        self.presenter?.createRequestModel.listMaDichVuYeuCau = data.idDichVu?.toString()
    }
    
    func updateDataDoctor(data: ResponseDoctorByMajorModel) {
        self.ipMember.setDefaultContent(data.TenNhanVien)
        self.ipService.setDefaultContent(data.TenKhoa)
    }

    func updateInfomationFromHome(model: AppointmentOptionalResponse) {
        self.fullnameTextfield.text = model.tenKhachHangDatHen
        self.presenter?.createRequestModel.tenKhachHangDatHen = self.fullnameTextfield.text

        self.phoneTextfield.text = model.soDienThoai
        self.presenter?.createRequestModel.soDienThoai = self.phoneTextfield.text
    }

    func initData(data: DetailAppointmentOptionalResponse) {
        self.fullnameTextfield.text = data.tenKhachHangDatHen
        self.presenter?.createRequestModel.tenKhachHangDatHen = self.fullnameTextfield.text

        self.phoneTextfield.text = data.soDienThoai
        self.presenter?.createRequestModel.soDienThoai = self.phoneTextfield.text

        self.sexTextfield.text = data.tenGioiTinh
        self.presenter?.createRequestModel.maGioiTinh = Int(data.maGioiTinh ?? "0")

        self.addressTextfield.text = data.diaChi
        self.presenter?.createRequestModel.diaChi = self.addressTextfield.text

        self.cityTextfield.text = data.tenTinhThanh
        self.presenter?.createRequestModel.maTinhThanh = data.maTinhThanh
        self.presenter?.district(idx: data.maTinhThanh ?? "", callBack: { (status) in

        })

        self.districtTextfield.text = data.tenQuanHuyen
        self.presenter?.createRequestModel.maQuanHuyen = data.maQuanHuyen

        self.descTextfield.text = data.tieuDe
        self.presenter?.createRequestModel.tieuDe = data.tieuDe

        if let dateTime = data.batDau {
            let dateTimeSplit = dateTime.split(separator: " ")
            self.dateTextfield.text = String(dateTimeSplit[0])
            let timeText = dateTimeSplit[1].split(separator: ":")
            let timeConvert = "\(timeText[0]):\(timeText[1])"
            self.timeTextfield.text = timeConvert
            self.presenter?.createRequestModel.thoigian[0] = timeConvert
            self.presenter?.createRequestModel.thoigian[1] = String(dateTimeSplit[0])
         }

        self.numberCustomerTextfield.text = "\(data.soLuongKhach ?? 1)"
        self.presenter?.createRequestModel.soLuongKhach = data.soLuongKhach

        self.noteTextfield.text = data.ghiChu
        self.presenter?.createRequestModel.ghiChu = data.ghiChu

        self.ipSource.setDefaultContent(data.tenNguonDen)
        self.presenter?.createRequestModel.idNguonDen = data.idNguonDen

        self.ipService.setDefaultContent(data.tenDichVu)
        self.presenter?.createRequestModel.listMaDichVuYeuCau = data.listMaDichVuYeuCau

        self.ipMember.setDefaultContent(data.tenNhanVien)
        self.presenter?.createRequestModel.listMaNhanVienYeuCau = data.listMaNhanVienYeuCau

        self.ipRoom.setDefaultContent(data.tenPhongDichVu)
        self.presenter?.createRequestModel.idPhongDichVu = data.idPhongDichVu

        self.ipStatus.setDefaultContent(data.trangThaiText)
        self.presenter?.createRequestModel.trangThai = data.trangThai

        self.presenter?.createRequestModel.khachHangID = data.khachHangID
        self.presenter?.createRequestModel.email = data.email
        self.presenter?.createRequestModel.idLichHen = data.idLichHen
        self.presenter?.createRequestModel.maKhachHang = data.maKhachHang
        self.presenter?.createRequestModel.ngaySinh = data.ngaySinh
    }

    func updateListSearchBar(items: [CustomFormModelElement]) {
        if items.count > 0 {
            self.viewListSearchBar.isHidden = false
        } else {
            self.viewListSearchBar.isHidden = true
        }
        self.dataSource?.updateAndReload(for: .SingleListing(items: items), .FullReload)
    }


    func reloadData() {
    }

    func alertMessage(text: String) {
        self.alertOneActionButton(title: "Common.OK".localized, description: text) {
            self.backToPrevScreen(with: RouteContext(["Loading": true, RVIsReload: true]))
        }
    }
    
    func createAppointment(productName: String) {
        self.lbProductName.text = productName
        self.lbProductName.isHidden = productName.isEmpty
    }
}


extension CreateAppointmentViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        self.viewListSearchBar.isHidden = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.viewListSearchBar.isHidden = true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter?.searchService(search: searchText)
    }
}

extension CreateAppointmentViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.fullnameTextfield {
            self.presenter?.createRequestModel.tenKhachHangDatHen = textField.text
        } else if textField == self.phoneTextfield {
            self.presenter?.createRequestModel.soDienThoai = textField.text
        } else if textField == self.addressTextfield {
            self.presenter?.createRequestModel.diaChi = textField.text
        } else if textField == self.descTextfield {
            self.presenter?.createRequestModel.tieuDe = textField.text
        } else if textField == self.dateTextfield {
            self.presenter?.createRequestModel.thoigian[1] = textField.text ?? ""
        }  else if textField == self.numberCustomerTextfield {
            self.presenter?.createRequestModel.soLuongKhach = Int(textField.text ?? "1")
        } else if textField == self.noteTextfield {
            self.presenter?.createRequestModel.ghiChu = textField.text
        } else if textField == self.tfStatus {
            self.presenter?.createRequestModel.tinhTrangHienTai = textField.text
        } else if textField == self.tfTienSuCaNhan {
            self.presenter?.createRequestModel.tienSuBenhLyBanThan = textField.text
        } else if textField == self.tfTienSuGiaDinh {
            self.presenter?.createRequestModel.tienSuBenhLyGiaDinh = textField.text
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTextfield {
            if textField.text?.count == 2 || textField.text?.count == 5 {
                //Handle backspace being pressed
                if !(string == "") {
                    // append the text
                    textField.text = textField.text! + "/"
                }
            }
            // check the condition not exceed 9 chars
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        } else {
            return true
        }
    }
}

