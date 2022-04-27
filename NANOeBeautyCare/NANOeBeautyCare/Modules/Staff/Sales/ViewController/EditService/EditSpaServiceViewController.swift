//
//  EditSpaServiceViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/15/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class EditSpaServiceViewController: BaseViewController<EditSpaServicePresenter> {
    // MARK: - IBOutlet
    var data: ListService?
    // MARK: - IBOutlet
    // View avarta
    @IBOutlet weak var avartaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!

    // Number
    @IBOutlet weak var minusButtona: UIButton!
    @IBOutlet weak var numberTextfield: MyTextField!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var priceAutoLabel: UILabel!

    // Promotion
    @IBOutlet weak var promotionTextfield: MyTextField!
    @IBOutlet weak var promotionButton: UIButton!
    @IBOutlet weak var clearPromotionButton: UIButton!


    @IBOutlet weak var discountTextfield: MyTextField!
    @IBOutlet weak var discountControl: BetterSegmentedControl!

    @IBOutlet weak var seriaDiscountTextfield: MyTextField!

    @IBOutlet weak var memberTextfield: MyTextField!
    @IBOutlet weak var memberButton: UIButton!


    @IBOutlet weak var viewRefButton: UIButton!
    @IBOutlet weak var viewRef: UIView!
    @IBOutlet weak var heightViewRef: NSLayoutConstraint!

    @IBOutlet weak var checkedImageview: UIImageView!
    @IBOutlet weak var refTextfield: MyTextField!
    @IBOutlet weak var refButton: UIButton!

    @IBOutlet weak var phoneTextfield: MyTextField!
    @IBOutlet weak var roseTextfield: MyTextField!
    @IBOutlet weak var roseControl: BetterSegmentedControl!

    @IBOutlet weak var transferDiscountButton: UIButton!
    @IBOutlet weak var transferResultTextfield: MyTextField!
    
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = EditSpaServicePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.EditSpaService".localized
        self.presenter?.initDataPresent()


        discountControl.segments = LabelSegment.segments(withTitles: ["%", "VND"],
                                                         normalFont: UIFont.systemFont(ofSize: 17.0),
                                                         selectedFont: UIFont.boldSystemFont(ofSize: 17.0),
                                                         selectedTextColor: UIColor(red: 0.20, green: 0.68, blue: 0.27, alpha: 1.00))

        roseControl.segments = LabelSegment.segments(withTitles: ["%", "VND"],
                                                     normalFont: UIFont.systemFont(ofSize: 17.0),
                                                     selectedFont: UIFont.boldSystemFont(ofSize: 17.0),
                                                     selectedTextColor: UIColor(red: 0.20, green: 0.68, blue: 0.27, alpha: 1.00))
        self.backButtonNavigation()
        let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
        self.navigationItem.rightBarButtonItems = [saveItem]

    }

    // MARK: - Update Data IBOutlet
    func updateData(data: ViewEditProductService) {

    }

    @objc func actionSave() {
        self.hideKeyboard()
        self.updateTotalMoney(number: (self.data?.donGiaNew ?? 0.0) - (self.data?.thanhTienGiamGia ?? 0.0))
        if let model = self.data {
            self.presenter?.services(model: model)
        }
    }

    // Update to CART
    func updateDiscountMoney(number: Double) {
        self.data?.thanhTienGiamGia = number
    }

    func updateNewPrice(number: Double) {
        self.data?.donGiaNew = number
    }

    func updateTotalMoney(number: Double) {
        self.data?.tienThanhToan = number
    }

    func updatePromotion(selected: PromotionProductOptionalResponse) {
        self.promotionTextfield.text = selected.tenChuongTrinhKM
        self.discountTextfield.text = selected.giamTang?.formatnumber()
        self.discountTextfield.isUserInteractionEnabled = false
        self.discountControl.isUserInteractionEnabled = false

        let discountNumber = (selected.giamTang ?? 0.0)

        if selected.tienOrPhanTram == true {
            let totalDiscountNumber = discountNumber + (self.data?.discountInput ?? 0.0) + (self.data?.discountSeria ?? 0.0)
            self.data?.discountSelected = discountNumber
            self.updateDiscountMoney(number: totalDiscountNumber)
            self.discountControl.setIndex(1)
        } else {
            let countDis = (discountNumber / 100 * (self.data?.donGiaNew ?? 0.0))
            self.data?.discountSelected = countDis
            let totalDiscountNumber = countDis + (self.data?.discountInput ?? 0.0) + (self.data?.discountSeria ?? 0.0)
            self.updateDiscountMoney(number: totalDiscountNumber)
            self.discountControl.setIndex(0)
        }
        self.clearPromotionButton.isHidden = false
    }

    func updateSeriaDiscount(model: SeriaDiscountOptionalResponse) {
        let number:Double = (model.giamTang ?? 0.0)
        self.transferResultTextfield.text = "\(number)"

        let discountNumber = number

        if model.tienOrPhanTram == true {
            let totalDiscountNumber = discountNumber + (self.data?.discountSelected ?? 0.0) + (self.data?.discountInput ?? 0.0)
            self.data?.discountSeria = discountNumber
            self.updateDiscountMoney(number: totalDiscountNumber)
        } else {
            let percentCo: Double = discountNumber / 100
            let countDis = (percentCo * (self.data?.donGiaNew ?? 0.0))
            self.data?.discountSeria = countDis
            let totalDiscountNumber = countDis + (self.data?.discountSelected ?? 0.0) + (self.data?.discountInput ?? 0.0)
            self.updateDiscountMoney(number: totalDiscountNumber)
        }

        self.data?.seriaDiscountTra = model
    }

    func updateSourceTo() {

    }


    // MARK: - Action Button

    @IBAction func viewRefButtonAction(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {
            self.viewRef.isHidden = !self.viewRef.isHidden
            self.heightViewRef.constant = (self.viewRef.isHidden == true) ? 0.0 : 314

            self.checkedImageview.image = (self.viewRef.isHidden == true) ? UIImage(named: "ic-uncheck") : UIImage(named: "ic-check-circle")
        }
    }

    @IBAction func promotionButton(_ sender: Any) {
        CommonView.alertPromotionCatalog { (selected) in
            self.data?.discountInput = 0.0
            self.updatePromotion(selected: selected)
            self.data?.promotion = selected
        }
    }


    @IBAction func memberButtonAction(_ sender: Any) {
        CommonView.alertEmployeeAndSearchCatalog(isSelected: self.presenter?.dataContext?.listIDTuVanVien ?? "") { (selected) in
            let idMember = selected.map {String($0.idNhanVien!)}
            let stringMember = selected.map {String($0.tenNhanVien!)}
            //            self.presenter?.createRequestModel.listMaNhanVienYeuCau = idMember.joined(separator: ",")
            self.data?.listIDTuVanVien = idMember.joined(separator: ",")
            self.presenter?.dataContext?.listIDTuVanVien = idMember.joined(separator: ",")
            self.data?.listTenNhanVienTuVan = stringMember.joined(separator: ",")
            self.memberTextfield.text = stringMember.joined(separator: ",")
        }
    }
    @IBAction func discountControl(_ sender: BetterSegmentedControl) {
        let number = Double(self.discountTextfield.text ?? "0.0") ?? 0.0

        let discountNumber = number

        if sender.index == 1 {
            let totalDiscountNumber = discountNumber + (self.data?.discountSelected ?? 0.0) + (self.data?.discountSeria ?? 0.0)
            self.data?.discountInput = discountNumber
            self.updateDiscountMoney(number: totalDiscountNumber)
            self.data?.typeThanhTienGiamGia = true
        } else {
            let countDis = (discountNumber / 100 * (self.data?.donGiaNew ?? 0.0))
            self.data?.discountInput = countDis
            let totalDiscountNumber = countDis + (self.data?.discountSelected ?? 0.0) + (self.data?.discountSeria ?? 0.0)
            self.updateDiscountMoney(number: totalDiscountNumber)
            self.data?.typeThanhTienGiamGia = false
        }
    }

    @IBAction func refButtonAction(_ sender: Any) {
        CommonView.alertSourceTo { (selected) in
            self.data?.sourceToRef = selected
            self.data?.idNguonGioiThieu = selected.idNguonDen
            self.data?.nguonGioiThieu = selected.tenNguonDen
            self.refTextfield.text = selected.tenNguonDen
        }
    }

    @IBAction func roseControl(_ sender: Any) {
    }

    @IBAction func minusButtonAction(_ sender: Any) {
        let number = Double(self.numberTextfield.text ?? "1.0") ?? 1.0
        if number == 0 || number == 1 {
            self.numberTextfield.text = "1"
            //                  self.presenter?.createRequestModel.soLuongKhach = 1
            let priceAction = (self.data?.donGia ?? 0.0) * 1.0
            self.priceAutoLabel.text = priceAction.formatnumberWithCurrency()
            self.updateNewPrice(number: priceAction)
            self.data?.soLuong = 1
        } else {
            self.numberTextfield.text = "\(number-1)"
            let priceAction = (self.data?.donGia ?? 0.0) * (number-1)
            self.priceAutoLabel.text = priceAction.formatnumberWithCurrency()
            self.updateNewPrice(number: priceAction)
            self.data?.soLuong = number-1
            //                  self.presenter?.createRequestModel.soLuongKhach = number-1
        }
    }

    @IBAction func plusButtonAction(_ sender: Any) {
        let number = Double(self.numberTextfield.text ?? "1.0") ?? 1.0
        self.numberTextfield.text = "\(number+1)"
        let priceAction = (self.data?.donGia ?? 0.0) * (number+1)
        self.updateNewPrice(number: priceAction)
        self.priceAutoLabel.text = priceAction.formatnumberWithCurrency()
        self.data?.soLuong = number+1
        //            self.presenter?.createRequestModel.soLuongKhach = number+1
    }

    @IBAction func clearPromotionButtonAction(_ sender: Any) {
        self.promotionTextfield.text = ""
        self.discountTextfield.text = ""
        self.discountTextfield.isUserInteractionEnabled = true
        self.discountControl.isUserInteractionEnabled = true
        self.clearPromotionButton.isHidden = true
        self.data?.discountSelected = 0.0
        self.data?.promotion = nil
        let discount = (self.data?.discountSeria ?? 0.0) + (self.data?.discountSelected ?? 0.0) + (self.data?.discountInput ?? 0.0)
        self.updateDiscountMoney(number: discount)
    }

    @IBAction func transferDiscountButtonAction(_ sender: Any) {
        self.presenter?.seriaDiscountChecked()
    }
}

// MARK: - Protocol of Presenter
extension EditSpaServiceViewController: EditSpaServiceVC {
    func updateSeria(model: SeriaDiscountOptionalResponse) {
        self.updateSeriaDiscount(model: model)
    }

    func initData(data: ListService) {
        self.data = data
        self.avartaImageView.pictureImageView(url: Common.stringToUrlImage(text: data.anhDaiDien ?? ""))
        self.titleLabel.text = data.ten
        self.priceLabel.text = data.donGia?.formatnumberWithCurrency()
        self.updateNewPrice(number: ((data.donGia ?? 0) * (data.soLuong ?? 1)))
        self.priceAutoLabel.text = self.data?.donGiaNew.formatnumberWithCurrency()
        self.discountLabel.text = data.thanhTienGiamGia?.formatnumberWithCurrency()
        self.discountLabel.attributedText = data.thanhTienGiamGia?.formatnumberWithCurrency().strikeThrough()

        self.numberTextfield.text = "\(data.soLuong ?? 1)"


        self.memberTextfield.text = data.listTenNhanVienTuVan

        self.phoneTextfield.text =  data.sdtNguonGioiThieu
        self.roseTextfield.text = "\(data.tienHoaHong ?? 0)"
        self.roseControl.setIndex((data.htTraHoaHong ?? 1)-1)

        self.discountTextfield.text = "\(data.valueThanhTienGiamGia)"
        if data.typeThanhTienGiamGia == false {
            self.discountControl.setIndex(0)
        } else {
            self.discountControl.setIndex(1)
        }

        // Promotion
        if let selected = data.promotion {
            self.updatePromotion(selected: selected)
        }

        if let source = data.sourceToRef {
            self.refTextfield.text = source.tenNguonDen
        } else {
            self.refTextfield.text = data.nguonGioiThieu
        }

        if let model = data.seriaDiscountTra {
            self.seriaDiscountTextfield.text = model.maKhuyenMai
            self.updateSeriaDiscount(model: model)
        }
    }

    func reloadData() {
    }
}

extension EditSpaServiceViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.numberTextfield {
            let priceAction = (self.data?.donGia ?? 0.0) * (Double(textField.text ?? "1.0") ?? 1.0)
            self.updateNewPrice(number: priceAction)
            self.priceAutoLabel.text = priceAction.formatnumberWithCurrency()
        } else if textField == self.discountTextfield {
            self.data?.discountSelected = 0.0

            let number = Double(textField.text ?? "0.0") ?? 0.0

            self.data?.valueThanhTienGiamGia = number
            let discountNumber = number

            if discountControl.index == 1 {
                let totalDiscountNumber = discountNumber + (self.data?.discountSelected ?? 0) + (self.data?.discountSeria ?? 0)
                self.data?.discountInput = discountNumber
                self.updateDiscountMoney(number: totalDiscountNumber)
            } else {
                let countDis = (discountNumber / 100 * (self.data?.donGiaNew ?? 0))
                self.data?.discountInput = countDis
                let totalDiscountNumber = countDis + (self.data?.discountSelected ?? 0) + (self.data?.discountSeria ?? 0)
                self.updateDiscountMoney(number: totalDiscountNumber)
            }

        } else if textField == self.phoneTextfield {
            self.data?.sdtNguonGioiThieu = textField.text
        } else if textField == self.roseTextfield {
            let number = Double(textField.text ?? "0.0") ?? 0.0
            self.data?.tienHoaHong = number
        } else if textField == self.seriaDiscountTextfield {
            self.presenter?.modelRequest.maKhuyenMai = textField.text
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        if textField == discountTextfield {
        //            self.discountTextfield.text = Double(textField.text ?? "0")?.formatnumber()
        //        }
        //        if textField == dateTextfield {
        //            if textField.text?.count == 2 || textField.text?.count == 5 {
        //                //Handle backspace being pressed
        //                if !(string == "") {
        //                    // append the text
        //                    textField.text = textField.text! + "/"
        //                }
        //            }
        //            // check the condition not exceed 9 chars
        //            return !(textField.text!.count > 9 && (string.count ) > range.length)
        //        } else {
        return true
        //        }
    }
}
