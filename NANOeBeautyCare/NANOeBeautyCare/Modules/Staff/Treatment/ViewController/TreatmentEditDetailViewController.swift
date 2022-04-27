//
//  TreatmentEditDetailViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class TreatmentEditDetailViewController: BaseViewController<TreatmentEditDetailPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var staffTextfield: MyTextField!
    @IBOutlet weak var staffButton: UIButton!

    @IBOutlet weak var roomTextfield: MyTextField!
    @IBOutlet weak var roomButton: UIButton!

    @IBOutlet weak var dateTextfield: MyTextField!
    @IBOutlet weak var dateButton: UIButton!

    @IBOutlet weak var statusTextfield: MyTextField!
    @IBOutlet weak var statusButton: UIButton!

    @IBOutlet weak var notesTextfield: MyTextField!

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = TreatmentEditDetailPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.TreatmentEditDetail".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()

        let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
        self.navigationItem.rightBarButtonItems = [saveItem]
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewTreatmentEditDetail) {

    }
    
    // MARK: - Action Button
    @IBAction func staffButtonAction(_ sender: Any) {
        CommonView.alertEmployeeAndSearchCatalog(isSelected: self.presenter?.dataContext?.listIDNhanVien ?? "", selected: { (selected) in
            let idMember = selected.map {String($0.idNhanVien!)}
            let stringMember = selected.map {String($0.tenNhanVien!)}
            self.presenter?.dataContext?.tenNhanVien = stringMember.joined(separator: ",")
            self.presenter?.requestModel.listIdNhanVien = idMember.joined(separator: ",")
            self.staffTextfield.text = stringMember.joined(separator: ",")
            self.presenter?.dataContext?.listIDNhanVien = idMember.joined(separator: ",")
        })
    }

    @IBAction func roomButtonAction(_ sender: Any) {
        CommonView.alertRoomCatalog { (selected) in
            self.presenter?.requestModel.idPhongDichVu = selected.idPhongBan
            self.roomTextfield.text = selected.tenPhongDichVu
        }
    }

    @IBAction func statusButtonAction(_ sender: Any) {
        CommonView.alertTreatmentEditStatusCatalog(selected: { (selected) in
            self.presenter?.requestModel.trangThaiLieuTrinh = selected.id ?? -1
            self.statusTextfield.text = selected.trangThai
        })
    }
    @IBAction func dateButtonAction(_ sender: Any) {
        let currentdate: Date = self.dateTextfield.text?.toDate(withFormat: "dd/MM/yyyy") ?? Date()
        CommonView.alertDate(title: "Ngày thực hiện", maximumDate: Date(), currentdate: currentdate) { (date) in
            self.presenter?.requestModel.ngayThucHien = date
            self.dateTextfield.text = date
        }
    }

    @objc func actionSave() {
        self.hideKeyboard()
        self.presenter?.requestModel.ghiChu = self.notesTextfield.text
        self.presenter?.services()
    }
}

// MARK: - Protocol of Presenter
extension TreatmentEditDetailViewController: TreatmentEditDetailVC {
    func updateStatus(isSuccess: Bool) {
        if isSuccess == true {
            self.alertOneActionButton(title: "Xác nhận", description: "Cập nhật thành công!") {
                self.backToPrevScreen(with: RouteContext([RVBackContext:true]))
            }
        } else {
            self.alertOneButton(description: "Xảy ra lỗi không lưu được")
        }
    }

    func initData(data: DetailTreatmentOptionalResponse) {
        self.presenter?.requestModel.ghiChu = data.ghiChu
        self.notesTextfield.text = data.ghiChu

        self.presenter?.requestModel.idLieuTrinhDieuTriDv = data.idLieuTrinhDieuTriDV

        self.presenter?.requestModel.idPhongDichVu = data.idPhongDichVu
        self.roomTextfield.text = data.tenPhongDichVu

        self.presenter?.requestModel.listIdNhanVien = data.listIDNhanVien
        self.staffTextfield.text = data.tenNhanVien

        self.presenter?.requestModel.ngayThucHien = data.ngayThucHien
        self.dateTextfield.text = data.ngayThucHien

        self.presenter?.requestModel.trangThaiLieuTrinh = data.trangThaiLieuTrinh
        self.statusTextfield.text = data.trangThaiLieuTrinhText
    }

    func reloadData() {


    }
}


