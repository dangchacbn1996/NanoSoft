//
//  AppointmentFilterViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

var IDAppointmentFilterViewController: Int = -1
class AppointmentFilterViewController: BaseViewController<AppointmentFilterPresenter> {
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
        presenter = AppointmentFilterPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.AppointmentFilter".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()

        self.statusTextfield.text = Common.addAllInTypeStatusCatelogData.first?.trangThai ?? ""
        self.presenter?.dataContext?.trangThai = Common.addAllInTypeStatusCatelogData.first?.id ?? -1

        self.presenter?.dataContext?.tuNgay = Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        self.fromTextfield.text = Date().startDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")

        self.presenter?.dataContext?.denNgay = Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        self.toTextfield.text = Date().endDateOfMonth.getFormattedDate(format: "dd/MM/yyyy")
        
        if IDAppointmentFilterViewController != -1 {
            Common.addAllInTypeStatusCatelogData.filter { (model) -> Bool in
                if model.id ?? -1 == IDAppointmentFilterViewController {
                    self.presenter?.dataContext?.trangThai = model.id ?? -1
                    self.statusTextfield.text = model.trangThai ?? "Tất cả"
                    return true
                } else {
                    return false
                }
            }
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewAppointmentFilter) {

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
        CommonView.alertStatusCatalog(isShowAll: true, selected: { (selected) in
            self.presenter?.dataContext?.trangThai = selected.id ?? -1
            IDAppointmentFilterViewController = selected.id ?? -1
            self.statusTextfield.text = selected.trangThai
        })
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.presenter?.cancel()
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        self.presenter?.save()
    }
}

// MARK: - Protocol of Presenter
extension AppointmentFilterViewController: AppointmentFilterVC {
    func initData(data: ViewAppointmentFilter) {
    }
    
    func reloadData() {
    }
}

extension AppointmentFilterViewController: UITextFieldDelegate {
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

