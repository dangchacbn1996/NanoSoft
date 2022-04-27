//
//  TreatmentFilterViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

var filterTreatment = TreatmentRequest()

class TreatmentFilterViewController: BaseViewController<TreatmentFilterPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var statusTextfield: MyTextField!
    @IBOutlet weak var fromTextfield: MyTextField!
    @IBOutlet weak var fromButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = TreatmentFilterPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.TreatmentFilter".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()

        self.statusTextfield.text = Common.addAllInStatusTreatmentData.first?.trangThai ?? ""
        self.presenter?.dataContext?.trangThai = Common.addAllInStatusTreatmentData.first?.id ?? 0

        self.presenter?.dataContext?.ngayDieuTri = Date().getFormattedDate(format: "dd/MM/yyyy")
        self.fromTextfield.text = Date().getFormattedDate(format: "dd/MM/yyyy")
        
        if filterTreatment.trangThai != -1 {
            let currentdate: Date = filterTreatment.ngayDieuTri.toDate(withFormat: "dd/MM/yyyy") ?? Date()
            self.presenter?.dataContext?.ngayDieuTri = currentdate.getFormattedDate(format: "dd/MM/yyyy")
            self.fromTextfield.text = currentdate.getFormattedDate(format: "dd/MM/yyyy")
            
            Common.addAllInStatusTreatmentData.filter { (model) -> Bool in
                if model.id == filterTreatment.trangThai {
                    self.presenter?.dataContext?.trangThai = model.id ?? -1
                    self.statusTextfield.text = model.trangThai ?? ""
                    return true
                }
                return false
            }
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewTreatmentFilter) {

    }
    
    // MARK: - Action Button
    @IBAction func fromButtonAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.dataContext?.ngayDieuTri.toDate(withFormat: "dd/MM/yyyy") ?? Date()
        CommonView.alertDate(title: "Từ ngày", maximumDate: Date().endDateOfMonth, currentdate: currentdate) { (date) in
            self.presenter?.dataContext?.ngayDieuTri = date ?? Date().getFormattedDate(format: "dd/MM/yyyy")
            self.fromTextfield.text = date
        }
    }

    @IBAction func statusButtonAction(_ sender: Any) {
        CommonView.alertTreatmentStatusCatalog(isShowAll: true, selected: { (selected) in
            self.presenter?.dataContext?.trangThai = selected.id ?? -1
            self.statusTextfield.text = selected.trangThai
        })
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.presenter?.cancel()
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        if let data = self.presenter?.dataContext {
            filterTreatment = data
        }
        self.presenter?.save()
    }
}

// MARK: - Protocol of Presenter
extension TreatmentFilterViewController: TreatmentFilterVC {
    func initData(data: ViewTreatmentFilter) {
    }
    
    func reloadData() {
    }
}

extension TreatmentFilterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.fromTextfield {
            self.presenter?.dataContext?.ngayDieuTri = textField.text ?? Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == fromTextfield {
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

