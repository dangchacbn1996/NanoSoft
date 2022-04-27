//
//  CreateCustomerSocialViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 23/11/2020
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateCustomerSocialViewController: BaseViewController<CreateCustomerSocialPresenter> {
    // MARK: - IBOutlet
    
    @IBOutlet weak var contentTextfield: MyTextField!
    @IBOutlet weak var categoriTextfield: MyTextField!
    @IBOutlet weak var categoriButton: UIButton!
    @IBOutlet weak var nextButton: MyGradientButton!
    @IBOutlet weak var swPrivate: UISwitch!
    var data: ModelOptionResponseSocialCatalogDatum?

    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CreateCustomerSocialPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Đặt câu hỏi cho bác sĩ"
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        disabledButton(next: self.nextButton)
        
        let gradient = CAGradientLayer()
        var bounds = self.navigationController?.navigationBar.bounds
        bounds?.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds ?? CGRect.zero
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientMid.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            self.navigationController?.navigationBar.shouldRemoveShadow(true)
            self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
            self.navigationController?.navigationBar.layoutIfNeeded()
            
        }
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCreateCustomerSocial) {

    }

    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        self.data = context[RVBackContext]
        if let model = self.data {
            self.categoriTextfield.text = model.tenNhomChuDe
            self.presenter?.modelRequest.idNhomChuDe = model.idNhomChuDe?.toString()
            
            if let newLength = self.contentTextfield.text?.length, let textCate = self.presenter?.modelRequest.idNhomChuDe?.length {
                if newLength > 0 && textCate > 0 {
                    enabledButton(next: nextButton)
                } else {
                    disabledButton(next: nextButton)
                }
            } else {
                disabledButton(next: nextButton)
            }
        }
        
    }
    
    // MARK: - Action Button
    @IBAction func categoriButtonAction(_ sender: Any) {
        self.openChildScreen(.FilterCustomerSocialViewController, fromStoryboard: .CustomerHome, withContext: RouteContext([:]))
    }
    @IBAction func nextButtonAction(_ sender: Any) {
        self.presenter?.modelRequest.isPublic = swPrivate.isOn ? 0 : 1
//        print("IsOn: \(self.presenter?.modelRequest.isPublic)")
        self.presenter?.services()
    }

}

// MARK: - Protocol of Presenter
extension CreateCustomerSocialViewController: CreateCustomerSocialVC {
    func alertShow(text: String) {
        self.alertOneButton(description: text)
        self.backToPrevScreen(with: RouteContext([RVBackContext:true]))
    }

    func initData(data: ViewCreateCustomerSocial) {
    }
    
    func reloadData() {
    }
}


extension CreateCustomerSocialViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.contentTextfield {
            self.presenter?.modelRequest.noiDungCauHoi = textField.text
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = self.contentTextfield.text, let textCate = self.presenter?.modelRequest.idNhomChuDe?.length {
            let newLength = text.count + string.count - range.length
            if newLength > 0 && textCate > 0 {
                enabledButton(next: nextButton)
            } else {
                disabledButton(next: nextButton)
            }
        } else {
            disabledButton(next: nextButton)
        }
        return true
    }
}

