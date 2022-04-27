//
//  EditInvoveServiceViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/15/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class EditInvoveServiceViewController: BaseViewController<EditInvoveServicePresenter> {
    // MARK: - IBOutlet
    var data: FooterService?
    // MARK: - IBOutlet
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var discountMoneyLabel: UILabel!
    
    // Promotion
    @IBOutlet weak var promotionTextfield: MyTextField!
    @IBOutlet weak var promotionButton: UIButton!
    @IBOutlet weak var clearPromotionButton: UIButton!
    
    @IBOutlet weak var discountTextfield: MyTextField!
    @IBOutlet weak var discountControl: BetterSegmentedControl!
    
    
    @IBOutlet weak var transferPointTextfield: MyTextField!
    @IBOutlet weak var transferPointButton: UIButton!
    @IBOutlet weak var transferPointResultTextfield: MyTextField!
    
    
    @IBOutlet weak var transferDiscountTextfield: MyTextField!
    @IBOutlet weak var transferDiscountButton: UIButton!
    @IBOutlet weak var transferDiscountResultTextfield: MyTextField!
    
    @IBOutlet weak var pointLabel: UILabel!

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = EditInvoveServicePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.EditInvoveService".localized
        self.presenter?.initDataPresent()
        
        discountControl.segments = LabelSegment.segments(withTitles: ["%", "VND"],
                                                         normalFont: UIFont.systemFont(ofSize: 17.0),
                                                         selectedFont: UIFont.boldSystemFont(ofSize: 17.0),
                                                         selectedTextColor: UIColor(red: 0.20, green: 0.68, blue: 0.27, alpha: 1.00))
        
        self.backButtonNavigation()
        let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
        self.navigationItem.rightBarButtonItems = [saveItem]
        
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewEditInvoveService) {
        
    }
    
    // MARK: - Action Button
    @objc func actionSave() {
        self.hideKeyboard()
//        self.data?.tongTienThanhToan = (self.data?.tongTien ?? 0.0) - (self.data?.tongTien ?? 0.0) - (self.data?.tongTien ?? 0.0)
        if let model = self.data {
            self.presenter?.services(model: model)
        }
    }

    func updateDiscountMoney(number: Double) {
        self.discountMoneyLabel.text = number.formatnumberWithCurrency()
        self.data?.tongTienGiamGiaHD = number
    }
    
    // MARK: - Action Button

    func updatePromotion(selected: PromotionProductOptionalResponse) {
        self.promotionTextfield.text = selected.tenChuongTrinhKM
        self.discountTextfield.text = selected.giamTang?.formatnumber()
        self.discountTextfield.isUserInteractionEnabled = false
        self.discountControl.isUserInteractionEnabled = false

        let discountNumber = (selected.giamTang ?? 0.0)

        if selected.tienOrPhanTram == true {
            let totalDiscountNumber = discountNumber + (self.data?.discountPoint ?? 0.0) + (self.data?.discountSeria ?? 0.0)
            self.data?.discountPromotion = discountNumber
            self.updateDiscountMoney(number: totalDiscountNumber)
            self.discountControl.setIndex(1)
        } else {
            if let data = self.data {
                let countDis = (discountNumber / 100 * self.totalNewDiscount(data: data))
                self.data?.discountPromotion = countDis
                let totalDiscountNumber = countDis +  (self.data?.discountPoint ?? 0.0) + (self.data?.discountSeria ?? 0.0)
                self.updateDiscountMoney(number: totalDiscountNumber)
                self.discountControl.setIndex(0)
            }
        }

        self.clearPromotionButton.isHidden = false
    }
    
    @IBAction func promotionButton(_ sender: Any) {
        CommonView.alertPromotionCatalog { (selected) in
            self.data?.promotion = selected
            self.updatePromotion(selected: selected)
        }
    }
    
    @IBAction func discountControl(_ sender: BetterSegmentedControl) {
        if sender.index == 1 {
            self.data?.typeThanhTienGiamGia = true
        } else {
            self.data?.typeThanhTienGiamGia = false
        }
        updateDiscountTextfield()
    }
    
    @IBAction func clearPromotionButtonAction(_ sender: Any) {
        self.promotionTextfield.text = ""
        self.discountTextfield.text = ""
        self.discountTextfield.isUserInteractionEnabled = true
        self.discountControl.isUserInteractionEnabled = true
        self.clearPromotionButton.isHidden = true

        self.data?.discountPromotion = 0.0
        self.data?.promotion = nil
        let totalDiscountNumber = (self.data?.discountPromotion ?? 0.0) + (self.data?.discountPoint ?? 0.0) + (self.data?.discountSeria ?? 0.0)
        self.updateDiscountMoney(number: totalDiscountNumber)
    }
    
    @IBAction func transferPointButtonAction(_ sender: Any) {
        self.presenter?.pointTransferMemberSerivceChecked()
    }
    
    @IBAction func transferDiscountButtonAction(_ sender: Any) {
        self.presenter?.seriaDiscountChecked()
    }
    
    func totalNewDiscount(data: FooterService) -> Double {
        let tongtien = data.tongTien ?? 0
        let giamgia = data.tongTienGiamGiaDVSPTHE ?? 0
        let total = tongtien - giamgia
        return total
    }
    
}

// MARK: - Protocol of Presenter
extension EditInvoveServiceViewController: EditInvoveServiceVC {
    func initData(data: FooterService) {
        self.data = data
        self.totalMoneyLabel.text = self.totalNewDiscount(data: data).formatnumberWithCurrency()
        self.discountMoneyLabel.text = data.tongTienGiamGiaHD?.formatnumberWithCurrency()
        if let promotionModel = data.promotion {
            self.updatePromotion(selected: promotionModel)
        }

        if let seriaModel = data.seria {
            self.updateSeria(model: seriaModel)
        }
        if let pointMember = data.poitMember {
            self.updatePointMember(model: pointMember)
        }
        if let poitMemberTransfer = data.poitMemberTransfer {
            self.updateTransferPointMember(model: poitMemberTransfer)
        }
        if data.typeThanhTienGiamGia == false {
            self.discountControl.setIndex(0)
        } else {
            self.discountControl.setIndex(1)
        }
        if data.valueThanhTienGiamGia > 0.0 {
            self.updateDiscountTextfield()
        }
    }
    
    func reloadData() {
    }
    
    func updateDiscountTextfield() {
        if let data = self.data {
            self.data?.discountSelected = 0.0

            let discountNumber = data.valueThanhTienGiamGia
            self.discountTextfield.text = "\(discountNumber)"

            if discountControl.index == 1 {
                let totalDiscountNumber = discountNumber + (self.data?.discountSelected ?? 0) + (self.data?.discountSeria ?? 0)
                self.data?.discountInput = discountNumber
                self.updateDiscountMoney(number: totalDiscountNumber)
            } else {
                let countDis = (discountNumber / 100 * (self.totalNewDiscount(data: data)))
                self.data?.discountInput = countDis
                let totalDiscountNumber = countDis + (self.data?.discountSelected ?? 0) + (self.data?.discountSeria ?? 0)
                self.updateDiscountMoney(number: totalDiscountNumber)
            }
        }
    }

    func updateSeria(model: SeriaDiscountOptionalResponse) {
        self.data?.seria = model

        self.transferDiscountResultTextfield.text = "\(model.giamTang ?? 0.0)"
        let discountNumber = (model.giamTang ?? 0.0)

        if model.tienOrPhanTram == true {
            let totalDiscountNumber = discountNumber + (self.data?.discountPoint ?? 0.0) + (self.data?.discountPromotion ?? 0.0)
            self.data?.discountSeria = discountNumber
            self.updateDiscountMoney(number: totalDiscountNumber)
        } else {
            let countDis = (discountNumber / 100 * (self.data?.tongTien ?? 0.0))
            self.data?.discountSeria = countDis
            let totalDiscountNumber = countDis +  (self.data?.discountPoint ?? 0.0) + (self.data?.discountPromotion ?? 0.0)
            self.updateDiscountMoney(number: totalDiscountNumber)
        }

    }

    func updatePointMember(model: PointMemberOptionalResponse) {
        self.data?.poitMember = model
        self.pointLabel.text = "\(model.diemTichLuy ?? 0) điểm"
    }

    func updateTransferPointMember(model: TransferPointMemberOptionalResponse) {
        self.data?.poitMemberTransfer = model
        self.transferPointResultTextfield.text = model.soTien?.formatnumber()
        let discountNumber = model.soTien ?? 0.0

        let totalDiscountNumber = discountNumber + (self.data?.discountPromotion ?? 0.0) + (self.data?.discountSeria ?? 0.0)
        self.data?.discountPoint = discountNumber
        self.updateDiscountMoney(number: totalDiscountNumber)
    }
}

extension EditInvoveServiceViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.discountTextfield {
            let number = Double(textField.text ?? "0.0") ?? 0.0
            self.data?.valueThanhTienGiamGia = number
            self.updateDiscountTextfield()
        } else if textField == self.transferPointTextfield {
            self.presenter?.modelTransferPointMember.soDiemQuyDoi = (Int(textField.text ?? "0") ?? 0)
        } else if textField == self.transferDiscountTextfield {
            self.presenter?.modelRequest.maKhuyenMai = textField.text
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}


