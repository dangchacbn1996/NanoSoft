//
//  InputTextField.swift
//  tatamilk
//
//  Created by Ngo Dang Chac on 12/07/2021.
//

import Foundation
import UIKit
import ActionSheetPicker_3_0

class InputBase: UIView {
    let lbTitle = UILabel(font: UIFont.customOpenSans(16, .semiBold), color: AppColors.textBlack, breakable: false)
    fileprivate let vText = UIView()
    fileprivate var isRequired: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func isValidateRequired() -> (Bool) {
        return true
    }
    
    func setEditable(_ isEditable: Bool) {
        if !isEditable {
            vText.backgroundColor = AppColors.viewBlueLight
            vText.layer.borderWidth = 0
        } else {
            vText.backgroundColor = UIColor.white
            vText.layer.borderWidth = 1
        }
    }
}

@IBDesignable class InputTextView: InputBase {
    let tvContent = UITextView()
    var content: String {
        get {
            return contentTv
        }
    }
    
    @IBInspectable private var font: UIFont = UIFont.customBig16 {
        didSet {
            tvContent.font = font
        }
    }
    @IBInspectable private var title: String = "" {
        didSet {
            lbTitle.text = title
        }
    }
    @IBInspectable private var placeholder: String = "" {
        didSet {
            validateContent()
        }
    }
    @IBInspectable private var contentTv: String = "" {
        didSet {
            validateContent()
        }
    }
    
    @IBInspectable private var colorText = UIColor.black
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    convenience init(title: String, placeholder: String = "", isRequired: Bool = false) {
        self.init(frame: .zero)
        setupUI()
        self.title = title
        lbTitle.text = title
        self.placeholder = placeholder
        self.isRequired = isRequired
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func isEmpty() -> (Bool) {
        return contentTv.isEmpty
    }
    
    override func isValidateRequired() -> (Bool) {
        if !isRequired {
            return true
        }
        return !isEmpty()
    }
    
    func setDefaultContent(_ val: String?) {
        if val != nil {
            contentTv = val!
        }
    }
    
    override func setEditable(_ isEditable: Bool) {
        super.setEditable(isEditable)
        tvContent.isUserInteractionEnabled = isEditable
    }
    
    private func validateContent() {
        if contentTv.length > 0 {
            tvContent.text = contentTv
            tvContent.textColor = colorText
        } else {
            tvContent.text = placeholder
            tvContent.textColor = colorText.withAlphaComponent(0.5)
        }
    }
    
    private func setupUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(20)
        })
        
        self.addSubview(vText)
        vText.snp.makeConstraints({
            $0.centerX.leading.equalToSuperview()
            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
            $0.height.equalTo(72)
            $0.bottom.equalToSuperview()
        })
        vText.layer.cornerRadius = 16
        vText.layer.borderWidth = 1
        vText.layer.borderColor = AppColors.primaryColor.cgColor
        
        vText.addSubview(tvContent)
        tvContent.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().offset(-8)
        })
        tvContent.backgroundColor = .clear
        tvContent.font = font
//        tvContent.addObserver(<#T##observer: NSObject##NSObject#>, forKeyPath: <#T##String#>, options: <#T##NSKeyValueObservingOptions#>, context: <#T##UnsafeMutableRawPointer?#>)
    }
    
}

class InputTextField: InputBase {
    enum InputTextFieldType {
        case normal
        case secure
        case drop
        case calendar
        case alertTable
        case OTP
        case textview
    }
    
    enum CalendarType : String {
        case ddMMyyyy = "dd/MM/yyyy"
        case hhmm = "hh:mm"
        case hhmmddMMyyyy = "hh:mm dd/MM/yyyy"
//        case yyyy = "yyyy"
    }
    
    let tfContent = UITextField(font: .customNormal14)
    var content: String {
        get {
            return tfContent.text ?? ""
        }
    }
    
    private var inputType: InputTextFieldType = .normal
    var dropListData: [String] = []
    private var dropPreload: (() -> Void)? = nil
    private var dropHandler: ((Any, Int) -> (Void))? = nil
    private var alertTableHandler: (() -> Void)? = nil
    private var dateFormatter: CalendarType = .ddMMyyyy
    
    private var calendarHandler: ((String?) -> Void)? = nil
    
    static func otp(title: String? = nil, placeHolder: String? = nil) -> (InputTextField) {
        let instance = InputTextField(type: .OTP, title: title ?? "Mã OTP", placeHolder: placeHolder ?? "Nhập mã OTP")
        return instance
    }
    
    static func secure(title: String, required: Bool = false, placeholder: String) -> (InputTextField) {
        let instance = InputTextField(type: .secure, title: title, required: required, placeHolder: placeholder)
        return instance
    }
    
    static func normal(title: String, required: Bool = false, placeholder: String) -> (InputTextField) {
        let instance = InputTextField(type: .normal, title: title, required: required, placeHolder: placeholder)
        return instance
    }
    
    static func droplist(title: String, placeholder: String, listOpts: [String], selected: @escaping ((Any, Int) -> Void)) -> (InputTextField) {
        let instance = InputTextField(type: .drop, title: title, placeHolder: placeholder)
        instance.dropListData = listOpts
        instance.dropHandler = selected
        return instance
    }
    
    static func droplist(title: String, placeholder: String, preload: @escaping () -> (Void), selected: @escaping ((Any, Int) -> Void)) -> (InputTextField) {
        let instance = InputTextField(type: .drop, title: title, placeHolder: placeholder)
        instance.dropPreload = preload
        instance.dropHandler = selected
        return instance
    }
    
    static func alertTable(title: String, placeholder: String, load: @escaping () -> Void) -> (InputTextField) {
        let instance = InputTextField(type: .alertTable, title: title, placeHolder: placeholder)
        instance.alertTableHandler = load
        return instance
    }
    
    
    static func calendar(title: String, required: Bool = false, placeholder: String, timeMode: CalendarType, completion: ((String?) -> Void)?) -> (InputTextField) {
        let instance = InputTextField(type: .calendar, title: title, required: required, placeHolder: placeholder)
        instance.calendarHandler = completion
        return instance
    }
    
    static func textView(title: String, required: Bool = false, placeholder: String) -> (InputTextField) {
        let instance = InputTextField(type: .textview, title: title, required: required, placeHolder: placeholder)
        return instance
    }
    
    convenience private init(type: InputTextFieldType, title: String, required: Bool = false, placeHolder: String) {
        self.init(frame: .zero)
        self.inputType = type
        lbTitle.text = title
        tfContent.placeholder = placeHolder
        isRequired = required
        refreshLayout()
    }
    
    override private init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isValidateRequired() -> (Bool) {
        if !isRequired {
            return true
        }
        return !isEmpty()
    }
    
    override func setEditable(_ isEditable: Bool) {
        super.setEditable(isEditable)
        tfContent.rightView?.isHidden = !isEditable
        tfContent.isUserInteractionEnabled = isEditable
    }
    
    @objc
    private func actSecureShow() {
        tfContent.isSecureTextEntry = !tfContent.isSecureTextEntry
//        (tfContent.rightView as? UIImageView)?.tintColor = tfContent.isSecureTextEntry ? AppColors.gray : AppColors.cyanBlue
    }
    
    @objc
    func actDropList() {
        if dropPreload != nil {
            dropPreload?()
        } else {
            actShowDrop()
        }
    }
    
    func actShowDrop(listData: [String] = []) {
        if listData != [] {
            self.dropListData = listData
        }
        let action = ActionSheetStringPicker()
        ActionSheetStringPicker.show(withTitle: lbTitle.text ?? "", rows: dropListData, initialSelection: 0, doneBlock: { picker, index, data in
            if let stringData = data as? String {
                self.tfContent.text = stringData
            }
            self.dropHandler?(data, index)
        }, cancel: { picker in
            return
        }, origin: tfContent)
    }
    
    @objc
    private func actShowAlert() {
        self.alertTableHandler?()
    }
    
    @objc
    private func actShowCalendar() {
        let current = DateFormatter(format: dateFormatter.rawValue).date(from: tfContent.text ?? "") ?? Date()
        var mode: UIDatePicker.Mode = .date
        switch dateFormatter {
        case .ddMMyyyy:
            mode = .date
        case .hhmm:
            mode = .time
        case .hhmmddMMyyyy:
            mode = .dateAndTime
        default:
            mode = .date
        }
        
        let currentdate: Date = DateFormatter(format: dateFormatter.rawValue).date(from: tfContent.text ?? "") ?? Date()
        CommonView.alertDate(title: lbTitle.text ?? "", maximumDate: nil, currentdate: currentdate) { (date) in
            self.tfContent.text = date
            self.calendarHandler?(date)
        }
        
//        ActionSheetDatePicker.show(withTitle: lbTitle.text ?? "", datePickerMode: mode, selectedDate: current, doneBlock: { picker, any1, any2 in
//        }, cancel: { picker in
//            return
//        }, origin: tfContent)
    }
    
    private func refreshLayout() {
        if isRequired {
            let attributeText = NSMutableAttributedString(string: lbTitle.text ?? "")
            attributeText.custom(" (")
            attributeText.custom("*", color: AppColors.textRed)
            attributeText.custom(")")
            lbTitle.attributedText = attributeText
        }
        switch inputType {
        case .normal:
            break
        case .secure:
            tfContent.isSecureTextEntry = true
//            let rightIcon = UIImageView(image: UIImage(named: AssetsName.icVision)?.withRenderingMode(.alwaysTemplate).withInset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 6)))
//            rightIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 36)
//            tfContent.rightView = rightIcon
//            rightIcon.tintColor = AppColors.gray
////            rightIcon.transform = CGAffineTransform(rotationAngle: .pi * 3/2)
//            rightIcon.isUserInteractionEnabled = true
//            rightIcon.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actSecureShow)))
//            tfContent.rightViewMode = .always
            break
        case .drop:
            let rightIcon = UIImageView(image: UIImage(named: "ic_back_dark")?.withRenderingMode(.alwaysTemplate).withInset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 6)))
            rightIcon.frame = CGRect(x: 0, y: 6, width: 36, height: 52)
            rightIcon.contentMode = .center
            tfContent.rightView = rightIcon
            rightIcon.tintColor = AppColors.primaryColor
            rightIcon.transform = CGAffineTransform(rotationAngle: .pi * 3/2)
            tfContent.rightViewMode = .always
            
            let vUser = UIView()
            tfContent.addSubview(vUser)
            vUser.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
            vUser.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actDropList)))
            break
        case .calendar:
            let rightIcon = UIImageView(image: UIImage(named: "ic-birthday")?.withRenderingMode(.alwaysTemplate).withInset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 6)))
            rightIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 36)
            rightIcon.contentMode = .scaleAspectFit
            tfContent.rightView = rightIcon
            rightIcon.tintColor = AppColors.primaryColor
//            rightIcon.transform = CGAffineTransform(rotationAngle: .pi * 3/2)
            tfContent.rightViewMode = .always
            
            let vUser = UIView()
            tfContent.addSubview(vUser)
            vUser.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
            vUser.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actShowCalendar)))
            break
        case .alertTable:
            let rightIcon = UIImageView(image: UIImage(named: "ic-more-horizontal")?.withInset(UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 2)))
            rightIcon.frame = CGRect(x: 0, y: 6, width: 36, height: 52)
            rightIcon.contentMode = .center
            tfContent.rightView = rightIcon
            tfContent.rightViewMode = .always
            
            let vUser = UIView()
            tfContent.addSubview(vUser)
            vUser.snp.makeConstraints({
                $0.edges.equalToSuperview()
            })
            vUser.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actShowAlert)))
            break
        case .textview:
            break
        case .OTP:
            tfContent.keyboardType = .numberPad
            if #available(iOS 12.0, *) {
                tfContent.textContentType = .oneTimeCode
            }
        default:
            break
        }
    }
}

//Public function
extension InputTextField {
    
    func isEmpty() -> (Bool) {
        return tfContent.text?.isEmpty ?? true
    }
    
    func setDefaultContent(_ val: String?) {
        tfContent.text = val ?? ""
    }
}

extension InputTextField {
    private func setupUI() {
        self.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        })

        self.addSubview(vText)
        vText.snp.makeConstraints({
            $0.centerX.leading.equalToSuperview()
            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
            $0.height.equalTo(48)
            $0.bottom.equalToSuperview()
        })
        vText.layer.cornerRadius = 16
        vText.layer.borderWidth = 1
        vText.layer.borderColor = AppColors.primaryColor.cgColor
        
        vText.addSubview(tfContent)
        tfContent.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().offset(-16)
        })
        tfContent.backgroundColor = .clear
        
//        self.addSubview(tfContent)
//        tfContent.snp.makeConstraints({
//            $0.centerX.leading.equalToSuperview()
//            $0.top.equalTo(lbTitle.snp.bottom).offset(8)
//            $0.height.equalTo(46)
//            $0.bottom.equalToSuperview()
//        })
//        tfContent.borderStyle = .roundedRect
//        tfContent.layer.cornerRadius = 16
//        tfContent.layer.borderWidth = 1
//        tfContent.layer.borderColor = AppColors.primaryColor.cgColor
    }
}
