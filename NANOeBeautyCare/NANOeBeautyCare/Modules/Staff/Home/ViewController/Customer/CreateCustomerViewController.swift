//
//  CreateCustomerViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit

class CreateCustomerViewController: BaseViewController<CreateCustomerPresenter> {
    // MARK: - IBOutlet
    // Avarta
    @IBOutlet weak var fullnameLabel: UILabel!
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

    //Address
    @IBOutlet weak var addressTextfield: MyTextField!
    // City
    @IBOutlet weak var cityTextfield: MyTextField!
    @IBOutlet weak var cityButton: UIButton!

    // District
    @IBOutlet weak var districtTextfield: MyTextField!
    @IBOutlet weak var districtButton: UIButton!
    // From Date
    @IBOutlet weak var fromDateTextfield: MyTextField!
    @IBOutlet weak var fromDateButton: UIButton!

    // Email
    @IBOutlet weak var emailTextfield: MyTextField!
    // Facebook
    @IBOutlet weak var facebookTextfield: MyTextField!

    // Jobs
    @IBOutlet weak var jobTextfield: MyTextField!
    @IBOutlet weak var jobButton: UIButton!

    // Company
    @IBOutlet weak var companyTextfield: MyTextField!

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
        presenter = CreateCustomerPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.CreateCustomer".localized
        self.backButtonNavigation()
        self.presenter?.initDataPresent()

        let saveItem = UIBarButtonItem.button(image: UIImage(named: "ic-floppy-disk")!, title: "", target: self, action: #selector(self.actionSave))
        self.navigationItem.rightBarButtonItems = [saveItem]
        
        let currentdate: Date = self.presenter?.createRequestModel.ngayDen?.toDate(withFormat: "dd/MM/yyyy") ?? Date()
        self.presenter?.createRequestModel.ngayDen = currentdate.getFormattedDate(format: "dd/MM/yyyy")
        self.fromDateTextfield.text = currentdate.getFormattedDate(format: "dd/MM/yyyy")
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

    @IBAction func fromDateButtonAction(_ sender: Any) {
        let currentdate: Date = self.presenter?.createRequestModel.ngayDen?.toDate(withFormat: "dd/MM/yyyy") ?? Date()
        CommonView.alertDate(title: "Từ ngày", maximumDate: Date(), currentdate: currentdate) { (date) in
            self.presenter?.createRequestModel.ngayDen = date
            self.fromDateTextfield.text = date
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
            self.presenter?.createRequestModel.idLoaiKH = selected.idLoaiKH
            self.classifyTextfield.text  = selected.loaiKhachHang
        }
    }


}

// MARK: - Protocol of Presenter
extension CreateCustomerViewController: CreateCustomerVC {
    func alertCreateMessage(text: String, data: HomeOptionalResponse?) {
        self.alertOneActionButton(title: "Common.OK".localized, description: text) {
            self.backToPrevScreen(with: RouteContext(["Loading": true, "CreateData": data]))
        }
    }

    func alertUpdateMessage(text: String, data: CustomerDetailOptionalResponse?) {
        self.alertOneActionButton(title: "Common.OK".localized, description: text) {
            self.backToPrevScreen(with: RouteContext(["Loading": true, "UpdataData": data]))
        }
    }

    func fillToViewWith(data: CustomerDetailOptionalResponse) {
        self.avartaImageview.avartaImageView(url: Common.stringToUrlImage(text: data.anhKhachHang ?? ""))
        self.fullnameTextfield.text = data.hoTen
        self.birthdayTextfield.text = data.ngaySinh
        self.sexTextfield.text = data.tenGioiTinh
        self.phoneTextfield.text = data.dienThoai
        self.addressTextfield.text = data.diaChi
        self.cityTextfield.text = data.tenTinhThanh
        self.districtTextfield.text = data.tenQuanHuyen
        self.fromDateTextfield.text = data.ngayDen
        self.emailTextfield.text = data.email
        self.facebookTextfield.text = data.faceBook
        self.jobTextfield.text = data.tenNgheNghiep
        self.companyTextfield.text = data.congTy
        self.sourceToTextfield.text = data.tenNguonDen
        self.introduceTextfield.text = data.nguonGioiThieu
        self.classifyTextfield.text = data.loaiKhachHang
        self.noteTextfield.text = data.ghiChu
    }

    func initData(data: ViewCreateCustomer) {
    }
    
    func reloadData() {
    }
}



extension CreateCustomerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension CreateCustomerViewController: UITextFieldDelegate {
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
        } else if textField == self.companyTextfield {
            self.presenter?.createRequestModel.congTy = textField.text
        } else if textField == self.noteTextfield {
            self.presenter?.createRequestModel.ghiChu = textField.text
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        disabledButton(next: self.nextButton)
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == birthdayTextfield || textField == fromDateTextfield {
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

