//
//  MyTextField.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//


import Foundation
import UIKit

public extension String {
    
    var isEmptyStr:Bool{
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).isEmpty
    }
}

//protocol ProtocolMyTextField {
//    func
//}

public class MyTextView: UITextView {
    
}

public class MyTextField: UITextField {
    
    public enum FloatingDisplayStatus{
        case always
        case never
        case defaults
    }
    
    public enum DTBorderStyle{
        case none
        case rounded
        case sqare
    }
    
    fileprivate var lblFloatPlaceholder:UILabel             = UILabel()
    fileprivate var lblError:UILabel                        = UILabel()
    
    fileprivate let paddingX:CGFloat                        = 5.0
    
    fileprivate let paddingHeight:CGFloat                   = 10.0
    
    public var dtLayer:CALayer                              = CALayer()
    public var floatPlaceholderColor:UIColor                = UIColor.black
    public var floatPlaceholderActiveColor:UIColor          = UIColor.black
    public var floatingLabelShowAnimationDuration           = 0.3
    public var floatingDisplayStatus:FloatingDisplayStatus  = .never
    
    public var dtborderStyle:DTBorderStyle = .rounded {
        didSet{
            switch dtborderStyle {
            case .none:
                dtLayer.cornerRadius        = 0.0
                dtLayer.borderWidth         = 0.0
            case .rounded:
                dtLayer.cornerRadius        = 16.0
                dtLayer.borderWidth         = canShowBorder ? 1.0 : 0.0
                dtLayer.borderColor         = borderMyColor.cgColor
            case .sqare:
                dtLayer.cornerRadius        = 0.0
                dtLayer.borderWidth         = 0.5
                dtLayer.borderColor         = borderMyColor.cgColor
            }
        }
    }
    
    public var errorMessage:String = ""{
        didSet{ lblError.text = errorMessage }
    }
    
    public var animateFloatPlaceholder:Bool = true
    public var hideErrorWhenEditing:Bool   = true
    
    public var errorFont = UIFont.systemFont(ofSize: 12.0){
        didSet{ invalidateIntrinsicContentSize() }
    }
    
    public var floatPlaceholderFont = UIFont.systemFont(ofSize: 12.0){
        didSet{ invalidateIntrinsicContentSize() }
    }
    
    public var paddingYFloatLabel:CGFloat = 3.0{
        didSet{ invalidateIntrinsicContentSize() }
    }
    
    public var paddingYErrorLabel:CGFloat = 3.0{
        didSet{ invalidateIntrinsicContentSize() }
    }
    
    public var borderMyColor:UIColor = AppColors.primaryColor {
        didSet{ dtLayer.borderColor = borderMyColor.cgColor }
    }
    
    public var canShowBorder:Bool = true {
        didSet{
            dtLayer.borderColor         = borderMyColor.cgColor
            dtLayer.cornerRadius        = 16.0
            if canShowBorder == true {
                dtLayer.backgroundColor     = UIColor.white.cgColor
                dtLayer.borderWidth         = 1.0
            } else {
                dtLayer.backgroundColor     = UIColor(hex: "E6F2FF").cgColor
                dtLayer.borderWidth         = 0.0
            }
        }
    }
    
    public var placeholderColor:UIColor?{
        didSet{
            guard let color = placeholderColor else { return }
            attributedPlaceholder = NSAttributedString(string: placeholderFinal,
                                                       attributes: [NSAttributedString.Key.foregroundColor:color])
        }
    }
    
    fileprivate var x:CGFloat {
        
        if let leftView = leftView {
            return leftView.frame.origin.x + leftView.bounds.size.width - paddingX
        }
        
        return paddingX
    }
    
    fileprivate var fontHeight:CGFloat{
        return ceil(font!.lineHeight)
    }
    
    fileprivate var dtLayerHeight:CGFloat{
        return bounds.height
        //showErrorLabel ? floor(bounds.height - lblError.bounds.size.height - paddingYErrorLabel) : bounds.height
    }
    
    fileprivate var floatLabelWidth:CGFloat{
        
        var width = bounds.size.width
        
        if let leftViewWidth = leftView?.bounds.size.width{
            width -= leftViewWidth
        }
        
        if let rightViewWidth = rightView?.bounds.size.width {
            width -= rightViewWidth
        }
        
        return width - (self.x * 2)
    }
    
    fileprivate var placeholderFinal:String{
        if let attributed = attributedPlaceholder { return attributed.string }
        return placeholder ?? " "
    }
    
    fileprivate var isFloatLabelShowing:Bool = false
    
    fileprivate var showErrorLabel:Bool = false{
        didSet{
            
            guard showErrorLabel != oldValue else { return }
            
            guard showErrorLabel else {
                hideErrorMessage()
                return
            }
            
            guard !errorMessage.isEmptyStr else { return }
            showErrorMessage()
        }
    }
    
    override public var borderStyle: UITextField.BorderStyle{
        didSet{
            guard borderStyle != oldValue else { return }
            borderStyle = .none
        }
    }
    
    public override var textAlignment: NSTextAlignment{
        didSet{ setNeedsLayout() }
    }
    
    public override var text: String?{
        didSet{ self.textFieldTextChanged() }
    }
    
    override public var placeholder: String?{
        didSet{
            
            guard let color = placeholderColor else {
                lblFloatPlaceholder.text = placeholderFinal
                return
            }
            attributedPlaceholder = NSAttributedString(string: placeholderFinal,
                                                       attributes: [NSAttributedString.Key.foregroundColor:color])
        }
    }
    
    override public var attributedPlaceholder: NSAttributedString?{
        didSet{ lblFloatPlaceholder.text = placeholderFinal }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public func showError(message:String? = nil) {
        if let msg = message { errorMessage = msg }
        showErrorLabel = true
    }
    
    public func hideError()  {
        showErrorLabel = false
    }
    
    
    fileprivate func commonInit() {
        
        dtborderStyle               = .rounded
        dtLayer.backgroundColor     = UIColor.white.cgColor
        
        floatPlaceholderColor       = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
        floatPlaceholderActiveColor = tintColor
        lblFloatPlaceholder.frame   = CGRect.zero
        lblFloatPlaceholder.alpha   = 0.0
        lblFloatPlaceholder.font    = floatPlaceholderFont
        lblFloatPlaceholder.text    = placeholderFinal
        
        addSubview(lblFloatPlaceholder)
        
        lblError.frame              = CGRect.zero
        lblError.font               = errorFont
        lblError.textColor          = UIColor.red
        lblError.numberOfLines      = 0
        lblError.isHidden           = true
        
        addTarget(self, action: #selector(textFieldEditingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
        addTarget(self, action: #selector(textFieldEditingDidEnd), for: .editingDidEnd)
        
        addSubview(lblError)
        
        layer.insertSublayer(dtLayer, at: 0)
        
        //        let clearButton = UIButton(frame: CGRect(x: 0, y: self.frame.height / 2 - 8, width: 16, height: 16))
        //        clearButton.setImage(UIImage(named: "ic-clear")!, for: [])
        //        let padding: CGFloat = 10
        //
        //        // create the view that would act as the padding
        //        let rightView = UIView(frame: CGRect(
        //            x: 0, y: 0, // keep this as 0, 0
        //            width: clearButton.frame.width + padding, // add the padding
        //            height: self.frame.height))
        //        rightView.addSubview(clearButton)
        //        self.rightView = rightView
        //        clearButton.addTarget(self, action: #selector(clearClicked), for: .touchUpInside)
        //
        //        self.clearButtonMode = .never
        //        self.rightViewMode = .always
    }
    
    //    @objc func clearClicked(sender:UIButton)
    //    {
    //        self.text = ""
    //    }
    
    
    fileprivate func showErrorMessage(){
        
        lblError.text = errorMessage
        lblError.isHidden = false
        let boundWithPadding = CGSize(width: bounds.width - (paddingX * 2), height: bounds.height)
        lblError.frame = CGRect(x: paddingX, y: 0, width: boundWithPadding.width, height: boundWithPadding.height)
        lblError.sizeToFit()
        
        invalidateIntrinsicContentSize()
    }
    
    func setErrorLabelAlignment() {
        var newFrame = lblError.frame
        
        if textAlignment == .right {
            newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
        }else if textAlignment == .left{
            newFrame.origin.x = paddingX
        }else if textAlignment == .center{
            newFrame.origin.x = (bounds.width / 2.0) - (newFrame.size.width / 2.0)
        }else if textAlignment == .natural{
            
            if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft{
                newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
            }
        }
        
        lblError.frame = newFrame
    }
    
    func setFloatLabelAlignment() {
        var newFrame = lblFloatPlaceholder.frame
        
        if textAlignment == .right {
            newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
        }else if textAlignment == .left{
            newFrame.origin.x = paddingX
        }else if textAlignment == .center{
            newFrame.origin.x = (bounds.width / 2.0) - (newFrame.size.width / 2.0)
        }else if textAlignment == .natural{
            
            if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft{
                newFrame.origin.x = bounds.width - paddingX - newFrame.size.width
            }
            
        }
        
        lblFloatPlaceholder.frame = newFrame
    }
    
    fileprivate func hideErrorMessage(){
        lblError.text = ""
        lblError.isHidden = true
        lblError.frame = CGRect.zero
        invalidateIntrinsicContentSize()
    }
    
    fileprivate func showFloatingLabel(_ animated:Bool) {
        
        let animations:(()->()) = {
            self.lblFloatPlaceholder.alpha = 1.0
            self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
                                                    y: self.paddingYFloatLabel,
                                                    width: self.lblFloatPlaceholder.bounds.size.width,
                                                    height: self.lblFloatPlaceholder.bounds.size.height)
        }
        
        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration,
                           delay: 0.0,
                           options: [.beginFromCurrentState,.curveEaseOut],
                           animations: animations){ status in
                            DispatchQueue.main.async {
                                self.layoutIfNeeded()
                            }
            }
        }else{
            animations()
        }
    }
    
    fileprivate func hideFlotingLabel(_ animated:Bool) {
        
        let animations:(()->()) = {
            self.lblFloatPlaceholder.alpha = 0.0
            self.lblFloatPlaceholder.frame = CGRect(x: self.lblFloatPlaceholder.frame.origin.x,
                                                    y: self.lblFloatPlaceholder.font.lineHeight,
                                                    width: self.lblFloatPlaceholder.bounds.size.width,
                                                    height: self.lblFloatPlaceholder.bounds.size.height)
        }
        
        if animated && animateFloatPlaceholder {
            UIView.animate(withDuration: floatingLabelShowAnimationDuration,
                           delay: 0.0,
                           options: [.beginFromCurrentState,.curveEaseOut],
                           animations: animations){ status in
                            DispatchQueue.main.async {
                                self.layoutIfNeeded()
                            }
            }
        }else{
            animations()
        }
    }
    
    fileprivate func insetRectForEmptyBounds(rect:CGRect) -> CGRect{
        let newX = x
        guard showErrorLabel else { return CGRect(x: newX, y: 0, width: rect.width - newX - paddingX, height: rect.height) }
        
        let topInset = (rect.size.height - lblError.bounds.size.height - paddingYErrorLabel - fontHeight) / 2.0
        //        let textY = topInset - ((rect.height - fontHeight) / 2.0)
        
        return CGRect(x: newX, y: 0, width: rect.size.width - newX - paddingX, height: rect.size.height)
    }
    
    fileprivate func insetRectForBounds(rect:CGRect) -> CGRect {
        
        guard let placeholderText = lblFloatPlaceholder.text,!placeholderText.isEmptyStr  else {
            return insetRectForEmptyBounds(rect: rect)
        }
        
        if floatingDisplayStatus == .never {
            return insetRectForEmptyBounds(rect: rect)
        }else{
            
            if let text = text,text.isEmptyStr && floatingDisplayStatus == .defaults {
                return insetRectForEmptyBounds(rect: rect)
            }else{
                let topInset = paddingYFloatLabel + lblFloatPlaceholder.bounds.size.height + (paddingHeight / 2.0)
                let textOriginalY = (rect.height - fontHeight) / 2.0
                var textY = topInset - textOriginalY
                
                if textY < 0 && !showErrorLabel { textY = topInset }
                let newX = x
                return CGRect(x: newX, y: ceil(textY), width: rect.size.width - newX - paddingX, height: rect.height)
            }
        }
    }
    
    
    @objc fileprivate func textFieldEditingDidEnd(){
        self.canShowBorder = false
    }
    
    @objc fileprivate func textFieldEditingDidBegin(){
        self.canShowBorder = true
    }
    
    @objc fileprivate func textFieldTextChanged(){
        guard hideErrorWhenEditing && showErrorLabel else { return }
        showErrorLabel = false
    }
    
    override public var intrinsicContentSize: CGSize{
        self.layoutIfNeeded()
        
        let textFieldIntrinsicContentSize = super.intrinsicContentSize
        
        if showErrorLabel {
            lblFloatPlaceholder.sizeToFit()
            return CGSize(width: textFieldIntrinsicContentSize.width,
                          height: textFieldIntrinsicContentSize.height + paddingYFloatLabel + paddingYErrorLabel + lblFloatPlaceholder.bounds.size.height + lblError.bounds.size.height + paddingHeight)
        }else{
            return CGSize(width: textFieldIntrinsicContentSize.width,
                          height: textFieldIntrinsicContentSize.height + paddingYFloatLabel + lblFloatPlaceholder.bounds.size.height + paddingHeight)
        }
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return insetRectForBounds(rect: rect)
    }
    
    fileprivate func insetForSideView(forBounds bounds: CGRect) -> CGRect{
        var rect = bounds
        rect.origin.y = 0
        rect.size.height = dtLayerHeight
        return rect
    }
    
    override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return insetForSideView(forBounds: rect)
    }
    
    override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return insetForSideView(forBounds: rect)
    }
    
    override public func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.y = (dtLayerHeight - rect.size.height) / 2
        return rect
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        dtLayer.frame = CGRect(x: bounds.origin.x,
                               y: bounds.origin.y,
                               width: bounds.width,
                               height: dtLayerHeight)
        CATransaction.commit()
        
        if showErrorLabel {
            
            var lblErrorFrame = lblError.frame
            lblErrorFrame.origin.y = dtLayer.frame.origin.y + dtLayer.frame.size.height + paddingYErrorLabel
            lblError.frame = lblErrorFrame
        }
        
        let floatingLabelSize = lblFloatPlaceholder.sizeThatFits(lblFloatPlaceholder.superview!.bounds.size)
        
        lblFloatPlaceholder.frame = CGRect(x: x, y: lblFloatPlaceholder.frame.origin.y,
                                           width: floatingLabelSize.width,
                                           height: floatingLabelSize.height)
        
        setErrorLabelAlignment()
        setFloatLabelAlignment()
        lblFloatPlaceholder.textColor = isFirstResponder ? floatPlaceholderActiveColor : floatPlaceholderColor
        
        switch floatingDisplayStatus {
        case .never:
            hideFlotingLabel(isFirstResponder)
        case .always:
            showFloatingLabel(isFirstResponder)
        default:
            if let enteredText = text,!enteredText.isEmptyStr{
                showFloatingLabel(isFirstResponder)
            }else{
                hideFlotingLabel(isFirstResponder)
            }
        }
    }
    
}

let regexCardName = "(?<! )[-a-zA-Z' ]{2,26}"
let regexFullName = "^[a-zA-Z_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ\\s]+$"
let regexVisaCardNumber = "^4[0-9]{12}(?:[0-9]{3})?$"
let regexNumber10or20Digits = "^[0-9]{10}$|^[0-9]{12}$"

func validateTextfieldWithRegex(regex: String,titleTextfield: String, textfieldValidate: UITextField) -> Bool {
    let textfield = textfieldValidate.text ?? ""
    let regex = try! NSRegularExpression(pattern: regex, options: .caseInsensitive)
    var validate = false
    if textfield.isEmpty() == true {
        (textfieldValidate as? MyTextField)?.showError(message: "Trường bắt buộc")
    } else if regex.firstMatch(in: textfield, options: [], range: NSRange(location: 0, length: textfield.count)) == nil {
        (textfieldValidate as? MyTextField)?.showError(message: titleTextfield)
    } else {
        validate = true
    }
    return validate
}

func validateTextfield(titleTextfield: String, textfieldValidate: UITextField) -> Bool {
    let textfield = textfieldValidate.text ?? ""
    var validate = false
    if textfield.isEmptyOrWhitespace() == true {
        (textfieldValidate as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD20".localized,  titleTextfield))
    } else {
        validate = true
    }
    return validate
}

func validateTextfieldEmpty(titleTextfield: String, textfieldValidate: UITextField) -> Bool {
    let textfield = textfieldValidate.text ?? ""
    var validate = false
    if textfield.isEmpty() == true {
        (textfieldValidate as? MyTextField)?.showError(message: String(format: "Common.EmptyTextField".localized,  titleTextfield))
    } else {
        validate = true
    }
    return validate
}

func validatePhone(titleTextfield: String, textfieldValidate: UITextField) -> Bool {
    let textfield = (textfieldValidate.text ?? "").removeWhitespace()
    var validate = false
    let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
    let characterSet = CharacterSet(charactersIn: textfield)
    if allowedCharacters.isSuperset(of: characterSet) == true {
        if textfield.isEmptyOrWhitespace() == true {
            (textfieldValidate as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD20".localized, titleTextfield))
        } else if (textfield.first != "0") {
            (textfieldValidate as? MyTextField)?.showError(message: "\(MessageFormString)VLD6x1".localized)
            // Check case remove 0
        } else if (textfield.count) > 10 || (textfield.count) < 10 {
            (textfieldValidate as? MyTextField)?.showError(message: "\(MessageFormString)VLD6x2".localized)
        } else {
            if textfield.count == 10 {
                validate = true
            }
        }
    } else {
        
    }
    return validate
}

func validatePassword(firstTextfield: UITextField, secondTextfield: UITextField) -> Bool{
    let firstPasswrod = firstTextfield.text ?? ""
    let secondPassword = secondTextfield.text ?? ""
    var validate = false
    
    //    if firstPasswrod.count > 0 && secondPassword.count > 0 {
    var validateFirstPassword = false
    // Nhập mật khẩu
    if firstPasswrod.isEmptyOrWhitespace() == true {
        (firstTextfield as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD20".localized, "Nhập mật khẩu"))
    } else if firstPasswrod.count > 45 || firstPasswrod.count < 6 {
        (firstTextfield as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD8".localized, "6-45"))
    } else {
        validateFirstPassword = true
    }
    var validateSecondPassword = false
    // Nhập lại mật khẩu
    if secondPassword.isEmptyOrWhitespace() == true {
        (secondTextfield as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD20".localized, "Xác nhận mật khẩu"))
    } else if secondPassword.count > 45 || secondPassword.count < 6  {
        (secondTextfield as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD8".localized, "6-45"))
    } else {
        validateSecondPassword = true
    }
    
    if validateFirstPassword == true && validateSecondPassword == true{
        if firstPasswrod != secondPassword {
            //                (firstTextfield as? MyTextField)?.showError(message: "\(MessageFormString)VLD19".localized)
            (secondTextfield as? MyTextField)?.showError(message: "\(MessageFormString)VLD19".localized)
        } else {
            validate = true
        }
    }
    //    }
    return validate
}

func validatePassword(firstTextfield: UITextField) -> Bool{
    let firstPasswrod = firstTextfield.text ?? ""
    var validate = false
    
    if firstPasswrod.count > 0 {
        // Nhập mật khẩu
        if firstPasswrod.isEmptyOrWhitespace() == true {
            (firstTextfield as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD20".localized, "Nhập mật khẩu"))
        } else if firstPasswrod.count > 45 || firstPasswrod.count < 6 {
            (firstTextfield as? MyTextField)?.showError(message: String(format: "\(MessageFormString)VLD8".localized, "6-45"))
        } else {
            validate = true
        }
    }
    return validate
}

func statusTextfield(button: UIButton, textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
    if let text = textField.text {
        let newLength = text.count + string.count - range.length
        if newLength > 0 {
            enabledButton(next: button)
        } else {
            disabledButton(next: button)
        }
    } else {
        disabledButton(next: button)
    }
}

func statusTextfields(button: UIButton,currentTextfield: UITextField, textFields: [UITextField], shouldChangeCharactersIn range: NSRange, replacementString string: String) {
    var isEnable:[Bool] = []
    for (index,textField) in textFields.enumerated() {
        if let text = textField.text {
            if currentTextfield == textField {
                let newLength = text.count + string.count - range.length
                //                print(text)
                //                print(newLength)
                if newLength > 0 {
                    isEnable.insert(true, at: index)
                } else {
                    isEnable.insert(false, at: index)
                }
            } else {
                if text.count > 0 {
                    isEnable.insert(true, at: index)
                } else {
                    isEnable.insert(false, at: index)
                }
            }
        } else {
            isEnable.insert(false, at: index)
        }
    }
    if isEnable.filter({$0 == false}).count == 0 && isEnable.count == textFields.count {
        enabledButton(next: button)
    } else {
        disabledButton(next: button)
    }
}

func statusBoolTextfields(button: UIButton,currentTextfield: UITextField, textFields: [UITextField], shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    var isEnable:[Bool] = []
    for (index,textField) in textFields.enumerated() {
        if let text = textField.text {
            if currentTextfield == textField {
                let newLength = text.count + string.count - range.length
                //                print(text)
                //                print(newLength)
                if newLength > 0 {
                    isEnable.insert(true, at: index)
                } else {
                    isEnable.insert(false, at: index)
                }
            } else {
                if text.count > 0 {
                    isEnable.insert(true, at: index)
                } else {
                    isEnable.insert(false, at: index)
                }
            }
        } else {
            isEnable.insert(false, at: index)
        }
    }
    if isEnable.filter({$0 == false}).count == 0 && isEnable.count == textFields.count {
        return true
    } else {
        return false
    }
}

func enabledButton(next: UIButton) {
    next.isUserInteractionEnabled = true
    next.alpha = 1.0
}

func disabledButton(next: UIButton) {
    next.isUserInteractionEnabled = false
    next.alpha = 0.6
}

private var __maxLengths = [UITextField: Int]()
@IBDesignable
extension UITextField {
    
    @IBInspectable var paddingLeftCustom: CGFloat {
        get {
            return leftView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue.auto(), height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }
    
    @IBInspectable var paddingRightCustom: CGFloat {
        get {
            return rightView!.frame.size.width
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue.auto(), height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
