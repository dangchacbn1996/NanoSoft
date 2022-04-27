//
//  CustomerSignUpViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 22/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CustomerSignUpViewController: BaseViewController<CustomerSignUpPresenter> {
    // MARK: - IBOutlet
    // Avarta
    @IBOutlet weak var avartaImageview: UIImageView!
    @IBOutlet weak var avartaButton: UIButton!
    // Fullname
    @IBOutlet weak var fullnameTextfield: MyTextField!
    
    // Birthday
    @IBOutlet weak var birthdayTextfield: MyTextField!
    @IBOutlet weak var birthdayButton: UIButton!
    
    // Sex
    @IBOutlet weak var sexButton: UIButton!
    @IBOutlet weak var sexTextfield: MyTextField!
    
    // Phone
    @IBOutlet weak var phoneTextfield: MyTextField!
    
    @IBOutlet weak var passwordTextfield: MyTextField!
    
    //Address
    @IBOutlet weak var cmndTextfield: MyTextField!
    
    @IBOutlet weak var addressTextfield: MyTextField!
    // City
    @IBOutlet weak var cityTextfield: MyTextField!
    @IBOutlet weak var cityButton: UIButton!
    
    // District
    @IBOutlet weak var districtTextfield: MyTextField!
    @IBOutlet weak var districtButton: UIButton!
    
    // Email
    @IBOutlet weak var emailTextfield: MyTextField!
    // Facebook
    @IBOutlet weak var facebookTextfield: MyTextField!
    
    // Jobs
    @IBOutlet weak var jobTextfield: MyTextField!
    @IBOutlet weak var jobButton: UIButton!

    // Source to
    @IBOutlet weak var sourceToTextfield: MyTextField!
    @IBOutlet weak var sourceToButton: UIButton!
    
    // introduce
    @IBOutlet weak var introduceTextfield: MyTextField!
    @IBOutlet weak var introduceButton: UIButton!
    
    //classify
    @IBOutlet weak var classifyTextfield: MyTextField!
    @IBOutlet weak var classifyButton: UIButton!
    
    // Note
    @IBOutlet weak var noteTextfield: MyTextField!
    
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerSignUpPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Đăng ký"
        self.backButtonNavigation()
        self.presenter?.initDataPresent()
        
        let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
        self.navigationItem.rightBarButtonItems = [saveItem]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewCreateCustomer) {
        
    }
    
    @objc func actionSave() {
        self.hideKeyboard()
        self.presenter?.services()
    }
    
    // MARK: - Action Button
    @IBAction func avartaButton(_ sender: Any) {
        let actionSheet = MyActionSheet(cancelButtonTitle: "Huỷ bỏ")
        actionSheet.add(MyActionSheetItem(title: "Camera", handler: { _ in
            self.openCamera()
        }))
        actionSheet.add(MyActionSheetItem(title: "Thư viện", handler: { _ in
            self.openGallery()
        }))
        actionSheet.show()
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            
            UIApplication.topViewController()?.presentInFullScreen(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Thông Báo", message: "Không có quyền truy cập Camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.topViewController()?.presentInFullScreen(alert, animated: true, completion: nil)
        }
    }
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            UIApplication.topViewController()?.presentInFullScreen(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Thông Báo", message: "Không có quyền truy cập thư viện.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            UIApplication.topViewController()?.presentInFullScreen(alert, animated: true, completion: nil)
        }
    }
    @IBAction func sexButtonAction(_ sender: Any) {
        CommonView.alertSex { (selected) in
            self.presenter?.createRequestModel.idGioiTinh = selected.id
            self.sexTextfield.text = selected.tenGioiTinh
        }
    }
    
    @IBAction func birthdayButtonAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.createRequestModel.ngaySinh?.toDate(withFormat: "dd/MM/yyyy") ?? Date()
        CommonView.alertDate(title: "Ngày sinh", maximumDate: Date(), currentdate: currentdate) { (date) in
            self.presenter?.createRequestModel.ngaySinh = date
            self.birthdayTextfield.text = date
        }
    }
    
    @IBAction func cityButtonAction(_ sender: Any) {
        CommonView.alertCity { (selected) in
            self.presenter?.createRequestModel.maTinhThanh = selected.maTinhThanh
            self.presenter?.district(idx: selected.maTinhThanh ?? "", callBack: { (status) -> Void in
                
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
    
    
    @IBAction func jobButtonAction(_ sender: Any) {
        CommonView.alertJob { (selected) in
            self.presenter?.createRequestModel.idNgheNghiep = selected.idNgheNghiep
            self.jobTextfield.text = selected.tenNgheNghiep
        }
    }
    
    @IBAction func sourceToButtonAction(_ sender: Any) {
        CommonView.alertSourceTo { (selected) in
            self.presenter?.createRequestModel.idNguonDen = selected.idNguonDen
            self.sourceToTextfield.text = selected.tenNguonDen
        }
        
    }
    
    @IBAction func introduceButtonAction(_ sender: Any) {
        CommonView.alertReferral { (selected) in
            self.presenter?.createRequestModel.idNguonGioiThieu = selected.idNguonGioiThieu
            self.introduceTextfield.text = selected.nguonGioiThieu
        }
    }
    
    @IBAction func classifyButtonAction(_ sender: Any) {
        CommonView.alertTypeCustomer { (selected) in
            self.presenter?.createRequestModel.idLoaiKh = selected.idLoaiKH
            self.classifyTextfield.text  = selected.loaiKhachHang
        }
    }
    
    
}

// MARK: - Protocol of Presenter
extension CustomerSignUpViewController: CustomerSignUpVC {
    func alertCreateMessage(text: String) {
        self.alertOneActionButton(title: "Common.OK".localized, description: text) {
            guard let rootVC = UIStoryboard.init(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
                return
            }
            
            let navigationController = UINavigationController(rootViewController: rootVC)

            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    func initData(data: ViewCustomerSignUp) {
    }
    
    func reloadData() {
    }
}



extension CustomerSignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            self.avartaImageview.image = pickedImage
            //            self.data?.avartaChange = pickedImage
            //            // resize our selected image
            let resizedImage = pickedImage.resizeImage(resizeImageWidth, opaque: true)
            self.presenter?.uploadImage(image: resizedImage)
            
            
            picker.dismiss(animated: true, completion: nil)
        }
    }
}

extension CustomerSignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField == self.fullnameTextfield {
            self.presenter?.createRequestModel.hoTen = textField.text
        } else if textField == self.birthdayTextfield {
            self.presenter?.createRequestModel.ngaySinh = textField.text
        } else if textField == self.phoneTextfield {
            self.presenter?.createRequestModel.dienThoai = textField.text
        } else if textField == self.addressTextfield {
            self.presenter?.createRequestModel.diaChi = textField.text
        } else if textField == self.emailTextfield {
            self.presenter?.createRequestModel.email = textField.text
        } else if textField == self.facebookTextfield {
            self.presenter?.createRequestModel.faceBook = textField.text
        } else if textField == self.noteTextfield {
            self.presenter?.createRequestModel.ghiChu = textField.text
        }else if textField == self.passwordTextfield {
            self.presenter?.createRequestModel.matKhau = textField.text
        }else if textField == self.cmndTextfield {
            self.presenter?.createRequestModel.soCmndTheCccd = textField.text
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == birthdayTextfield {
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

