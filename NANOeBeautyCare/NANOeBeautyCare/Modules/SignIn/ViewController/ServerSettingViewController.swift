//
//  ServerSettingViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 7/3/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

struct ServerSettingStore: Codable {
    let brandType: String
    enum CodingKeys: String, CodingKey {
        case brandType = "brandType"
    }
}

class ServerSettingViewController: BaseViewController<ServerSettingPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var listDomainButton: UIButton!
    @IBOutlet weak var hostTextfield: MyTextField!
    @IBOutlet weak var checkHost: UIImageView!
    @IBOutlet weak var httpRadioView: RadioButtonContainerView!
    @IBOutlet weak var radioView: RadioButtonContainerView!
    @IBOutlet weak var customerRadioButton: RadioButton!
    @IBOutlet weak var staffRadioButton: RadioButton!
    @IBOutlet weak var nextButton: MyGradientButton!
    var data: [ServerSettingResponseDatum] = []
    var dataSelected: ServerSettingResponseDatum?
    var buttonSelected = BrandTypeEnum.Customer
    @IBOutlet weak var httpsButton: RadioButton!
    @IBOutlet weak var httpButton: RadioButton!
    var isHttps:Bool = true
    var urlMergeString: String = ""
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = ServerSettingPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.ServerSetting".localized
        self.presenter?.initDataPresent()
        self.backButtonNavigation()
        
        self.httpRadioView.buttonContainer.delegate = self
        
        self.radioView.buttonContainer.delegate = self
        
        let brandType = Common.BRAND_TYPE
        if brandType == BrandTypeEnum.Staff.rawValue {
            self.radioView.buttonContainer.selectedButton = self.staffRadioButton
        } else {
            self.radioView.buttonContainer.selectedButton = self.customerRadioButton
        }
        
        let gradient = CAGradientLayer()
        var bounds = self.navigationController?.navigationBar.bounds
        bounds?.size.height += UIApplication.shared.statusBarFrame.size.height
        gradient.frame = bounds ?? CGRect.zero
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientNaviEnd.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        
        if let image = getImageFrom(gradientLayer: gradient) {
            self.navigationController?.navigationBar.shouldRemoveShadow(true)
            self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
            self.navigationController?.navigationBar.layoutIfNeeded()
            self.navigationController?.navigationBar.tintColor = .white
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        _ = self.checkUrlIsExited(valueUrl: self.hostTextfield.text ?? "")
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewServerSetting) {
        
    }
    
    // MARK: - Action Button
    @IBAction func httpsButtonAction(_ sender: Any) {
        self.isHttps = true
    }
    
    @IBAction func httpButtonAction(_ sender: Any) {
        self.isHttps = false
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if let item = self.dataSelected {
            let setting = ServerSettingStore(brandType: self.buttonSelected.rawValue)
            UserDefaults.standard.df.store(setting, forKey: String(describing: ServerSettingStore.self))
            self.backToPrevScreen()
        } else {
            Loading.notificationError(title: "Lỗi đường dẫn", subtitle: "")
        }
    }
    
    func checkUrlIsExited(valueUrl: String) -> (Bool, ServerSettingResponseDatum?) {
        let urlHttpString = (self.isHttps == true) ? "https://" : "http://"
        urlMergeString = urlHttpString + valueUrl
        for item in self.data {
            if urlMergeString == item.url {
                self.checkHost.isHidden = false
                self.dataSelected = item
                UserDefaults.standard.df.store(item, forKey: String(describing: ServerSettingResponseDatum.self))
                return (true, item)
            } else {
                self.checkHost.isHidden = true
                self.dataSelected = nil
                continue
            }
        }
        return (false, nil)
    }
    
    @IBAction func listDomainButtonAction(_ sender: Any) {
        CommonView.alertListDomain { (selected) in
            let splitUrl = selected.url.components(separatedBy: "://")
            if let host = splitUrl[1] as? String, let httpS = splitUrl[0] as? String {
                if httpS == "https" {
                    self.httpRadioView.buttonContainer.selectedButton = self.httpsButton
                } else {
                    self.httpRadioView.buttonContainer.selectedButton = self.httpButton
                }
                self.hostTextfield.text = host
                _ = self.checkUrlIsExited(valueUrl: host)
            } else {
                self.httpRadioView.buttonContainer.selectedButton = self.httpsButton
            }
        }
    }
}

// MARK: - Protocol of Presenter
extension ServerSettingViewController: ServerSettingVC {
    func initData(data: [ServerSettingResponseDatum]) {
        self.data = data
        
        for item in data {
            if item.url == "https://365care.vn" {
                Common.Domain = ServerSettingResponseDatum(maCongTy: item.maCongTy ?? "", domain: item.domain ?? "", url: item.url ?? "", tenCongTy: item.tenCongTy ?? "", tenThuongHieu: item.tenThuongHieu ?? "", keyGen: item.keyGen ?? "", diaChiCongTy: item.diaChiCongTy ?? "", mst: item.mst ?? "", email: item.email ?? "", dienThoai: item.dienThoai ?? "", fax: item.fax ?? "", logo: "\(item.url ?? "")\(item.logo ?? "")")
            }
        }
        var valueUrl = ""
        
//        #if DEBUG
//        valueUrl = Common.HOST.count > 0 ? Common.HOST : data.first?.url ?? ""
//        let splitUrl = valueUrl.components(separatedBy: "://")
//        if let host = splitUrl[1] as? String, let httpS = splitUrl[0] as? String {
//            if httpS == "https" {
//                self.httpRadioView.buttonContainer.selectedButton = self.httpsButton
//            } else {
//                self.httpRadioView.buttonContainer.selectedButton = self.httpButton
//            }
//            self.hostTextfield.text = host
//            _ = self.checkUrlIsExited(valueUrl: host)
//        } else {
//            self.httpRadioView.buttonContainer.selectedButton = self.httpsButton
//        }
//        #else
//        valueUrl = Common.HOST.count > 0 ? Common.HOST : ""
//        let splitUrl = valueUrl.components(separatedBy: "://")
//        self.hostTextfield.text = splitUrl[1]
//        _ = self.checkUrlIsExited(valueUrl: splitUrl[1] )
//        #endif
        valueUrl = Common.HOST.count > 0 ? Common.HOST : ""
        let splitUrl = valueUrl.components(separatedBy: "://")
        if splitUrl.count > 1 {
            if let host = splitUrl[1] as? String, let httpS = splitUrl[0] as? String {
                if httpS == "https" {
                    self.httpRadioView.buttonContainer.selectedButton = self.httpsButton
                } else {
                    self.httpRadioView.buttonContainer.selectedButton = self.httpButton
                }
                self.hostTextfield.text = host
                _ = self.checkUrlIsExited(valueUrl: host)
            } else {
                self.httpRadioView.buttonContainer.selectedButton = self.httpsButton
            }
        }
        
        self.listDomainButton.isHidden = !(Common.ListDomain.count > 0)
        
        self.isHttps = true
        self.hostTextfield.text = "quanly.phongkhamcongnghe.com:456"
        self.httpsButton.isOn = true
    }
    
    func reloadData() {
    }
}

extension ServerSettingViewController: RadioButtonDelegate {
    func radioButtonDidSelect(_ button: RadioButton) {
        print("Select: ", button.title(for: .normal)!)
        if let title = button.title(for: .normal) {
            if title == "ServerSetting.Staff".localized {
                self.buttonSelected = .Staff
            } else if title == "ServerSetting.Customer".localized {
                self.buttonSelected = .Customer
            } else if title == "https://" {
                self.isHttps = true
                _ = self.checkUrlIsExited(valueUrl: self.hostTextfield.text ?? "")
            } else if title == "http://" {
                self.isHttps = false
                _ = self.checkUrlIsExited(valueUrl: self.hostTextfield.text ?? "")
            }
        }
    }
    
    func radioButtonDidDeselect(_ button: RadioButton) {
        print("Deselect: ",  button.title(for: .normal)!)
    }
}


extension ServerSettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if hostTextfield == textField {
            _ = self.checkUrlIsExited(valueUrl: textField.text ?? "")
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        disabledButton(next: self.nextButton)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        statusTextfields(button: self.<#button#>, textFields: [<#textfield#>], shouldChangeCharactersIn: range, replacementString: string)
        if hostTextfield == textField {
            if let textFieldString = textField.fullTextWith(range: range, replacementString: string) {
                    print("FullString: \(textFieldString)")
                _ = self.checkUrlIsExited(valueUrl: textFieldString)
                }
        }
        return true
    }
}

