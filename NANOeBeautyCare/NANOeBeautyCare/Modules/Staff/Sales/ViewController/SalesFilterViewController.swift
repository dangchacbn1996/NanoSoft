//
//  SalesFilterViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

var filterSales: SalesRequest = SalesRequest()
class SalesFilterViewController: BaseViewController<SalesFilterPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusTextfield: MyTextField!
    @IBOutlet weak var fromTextfield: MyTextField!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var toTextfield: MyTextField!
    @IBOutlet weak var toButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!

    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = SalesFilterPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.SalesFilter".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()

        self.statusTextfield.text = Common.addAllInTypeInvoiceStatusCatelogData.first?.trangThai ?? ""
        self.presenter?.dataContext?.trangThai = Common.addAllInTypeInvoiceStatusCatelogData.first?.id ?? -1

        self.presenter?.dataContext?.tuNgay = Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        self.fromTextfield.text = Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")

        self.presenter?.dataContext?.denNgay = Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        self.toTextfield.text = Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        
        if filterSales.trangThai != -1 {
           
            self.presenter?.dataContext?.tuNgay = filterSales.tuNgay
            self.fromTextfield.text = filterSales.tuNgay

            self.presenter?.dataContext?.denNgay = filterSales.denNgay
            self.toTextfield.text = filterSales.denNgay
            
            Common.addAllInTypeInvoiceStatusCatelogData.filter { (model) -> Bool in
                if model.id == filterSales.trangThai {
                    self.statusTextfield.text = model.trangThai ?? ""
                    self.presenter?.dataContext?.trangThai = model.id ?? -1
                    
                    return true
                }
                return false
            }
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewSalesFilter) {

    }
    
    // MARK: - Action Button
    @IBAction func fromButtonAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.dataContext?.tuNgay.toDate(withFormat: "dd/MM/yyyy") ?? Date().startDateOfMonth
        CommonView.alertDate(title: "Từ ngày", maximumDate: Date().endDateOfMonth, currentdate: currentdate) { (date) in
            self.presenter?.dataContext?.tuNgay = date ?? Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
            self.fromTextfield.text = date
        }
    }

    @IBAction func toButtonAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.dataContext?.denNgay.toDate(withFormat: "dd/MM/yyyy") ?? Date().endDateOfMonth
        CommonView.alertDate(title: "Đến ngày", maximumDate: Date().endDateOfMonth, currentdate: currentdate) { (date) in             self.presenter?.dataContext?.denNgay = date ?? Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
            self.toTextfield.text = date
        }
    }

    @IBAction func statusButtonAction(_ sender: Any) {
        CommonView.alertInvoiceStatusCatalog(isShowAll: true, selected: { (selected) in
            self.presenter?.dataContext?.trangThai = selected.id ?? -1
            self.statusTextfield.text = selected.trangThai
        })
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.presenter?.cancel()
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        if let data = self.presenter?.dataContext {
            filterSales = data
        }
        self.presenter?.save()
    }
    
}

// MARK: - Protocol of Presenter
extension SalesFilterViewController: SalesFilterVC {
    func initData(data: ViewSalesFilter) {
    }
    
    func reloadData() {
    }
}

extension SalesFilterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.fromTextfield {
            self.presenter?.dataContext?.tuNgay = textField.text ?? Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        }
        if textField == self.toTextfield {
            self.presenter?.dataContext?.denNgay = textField.text ?? Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fromTextfield || textField == toTextfield {
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

