//
//  Extentions.swift
//  VPBS Mobile
//
//  Created by Le Van Long on 6/24/17.
//  Copyright © 2017 com.ifs. All rights reserved.
//

import Foundation
import UIKit
//import HandyJSON
//import CommonCrypto
import SnapKit
import Alamofire

extension UIImage
{
    class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func resize(to size: CGSize) -> UIImage? {
        let scaleWidth = size.width / self.size.width
        let scaleHeight = size.height / self.size.height
        let scale = min(scaleWidth, scaleHeight)
        let newWidth = self.size.width * scale
        let newHeight = self.size.height * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        let drawRect = CGRect(origin: .zero, size: newSize)
        UIGraphicsBeginImageContext(newSize)
        self.draw(in: drawRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func grayscale() -> UIImage? {
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectNoir") {
            filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}

extension UILabel {
    
    convenience init(text : String = "", font : UIFont, color : UIColor = UIColor.black, tag : Int = 0, breakable : Bool = false) {
        self.init(frame: CGRect.zero)
        self.textColor = color
        self.font = font
        self.accessibilityLabel = text
        if text != "" {
            self.text = text
        }
        self.tag = tag
        if breakable {
            self.numberOfLines = 0
        }
    }
    
    func setIndex(_ value: (String, UIColor, Decimal)) {
        self.text = value.0
        self.textColor = value.1
    }
    
    func setAttributed(_ attribute: [(String?, UIColor?, UIFont?)]) {
        let attr = NSMutableAttributedString()
        for item in attribute {
            attr.custom(item.0 ?? "", font: item.2, color: item.1)
        }
        self.attributedText = attr
    }
}

public extension Date {
    static let IFS_DEFAULT_FORMAT = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
    public func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public init?(string: String, format: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //self.init()
        self = dateFormatter.date(from: string) ?? Date(timeIntervalSince1970: 0)
    }
    
    public static func from(string: String, format: String = Date.IFS_DEFAULT_FORMAT) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        var dateString = ""
        if string.count > 19 {
            dateString = string.subString(to: 19) + "+07:00"
        }
        let retVal = dateFormatter.date(from: dateString)
        return retVal
    }
    
    public func getComponent(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
    public func getComponents(_ components: [Calendar.Component]) -> [Int] {
        var retVal = [Int]()
        for component in components {
            retVal.append(Calendar.current.component(component, from: self))
        }
        return retVal
    }
    
    public func addDay(_ day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self)!
    }
    
    public func addMonth(_ month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: self)!
    }
    
    public func addYear(_ year: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }
    
}


public extension UIColor {
    
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    public convenience init?(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        var hex:String!
        
        if rgba.hasPrefix("#") {
            hex = rgba.subString(from: 1)
        }
        else if(rgba.hasPrefix("0x"))
        {
            hex = rgba.subString(from: 2)
        }
        else
        {
//            print("Invalid RGB string, missing '#' or '0x' as prefix")
            self.init(red:red, green:green, blue:blue, alpha:alpha)
            return nil
        }
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue)
        {
            switch (hex.count)
            {
            case 3:
                red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue  = CGFloat(hexValue & 0x00F)              / 15.0
            case 4:
                red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                alpha = CGFloat(hexValue & 0x000F)             / 15.0
            case 6:
                red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
            case 8:
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            default:
                print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
            }
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

extension String: ParameterEncoding {
    
    init?(htmlEncodedString: String) {

        guard let data = htmlEncodedString.data(using: .utf8) else {
            return nil
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return nil
        }

        self.init(attributedString.string)

    }
    
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        return request
    }
}


public extension String {
    public func index(with offset: Int) -> Index {
        return self.index(startIndex, offsetBy: offset)
    }
    
    public func subString(from offset: Int) -> String {
        let fromIndex = index(with: offset)
        return String(self.suffix(from: fromIndex))
    }
    
    public func subString(to offset: Int) -> String {
        let toIndex = index(with: offset)
        
        return String(self.prefix(upTo: toIndex))
    }
    
    private func subString(from startOffset: Int, to endOffset: Int) -> String? {
        guard startOffset <= endOffset && startOffset >= 0 && endOffset < self.count else {
//            print("Invalid String offset")
            return nil
        }
        let lo = index(with: startOffset)
        let hi = index(with: endOffset)
        let subRange = lo...hi
        return String(self[subRange])
    }
    
    public subscript(range: ClosedRange<Int>) -> String {
        return subString(with: range)
    }
    
    public func subString(with range: Range<Int>) -> String {
        let startIndex = index(with: range.lowerBound)
        let endIndex = index(with: range.upperBound)
        return String(self[startIndex..<endIndex])
    }
    public func subString(with range: ClosedRange<Int>) -> String {
        let startIndex = index(with: range.lowerBound)
        let endIndex = index(with: range.upperBound)
        return String(self[startIndex...endIndex])
    }
    
    
    public func index(of string: String, options: String.CompareOptions = .literal) -> String.Index? {
        return range(of: string, options: options, range: nil, locale: nil)?.lowerBound
    }
    
    
    public func indexes(of string: String, options: String.CompareOptions = .literal) -> [Int] {
        var result: [Int] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex, locale: nil) {
            let idx = distance(from: startIndex, to: range.lowerBound)
            result.append(idx)
            start = range.upperBound
        }
        return result
    }
    
    
    public func ranges(of string: String, options: String.CompareOptions = .literal) -> [Range<String.Index>] {
        var result: [Range<String.Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex, locale: nil) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
    //
    var isNumber: Bool { return Int(self) != nil || Double(self) != nil }
    
    
    public func removeAccent() -> String
    {
        let vietnamese = "ĂÂÀẰẦÁẮẤẢẲẨÃẴẪẠẶẬỄẼỂẺÉÊÈỀẾẸỆÔÒỒƠỜÓỐỚỎỔỞÕỖỠỌỘỢƯÚÙỨỪỦỬŨỮỤỰÌÍỈĨỊỲÝỶỸỴĐăâàằầáắấảẳẩãẵẫạặậễẽểẻéêèềếẹệôòồơờóốớỏổởõỗỡọộợưúùứừủửũữụựìíỉĩịỳýỷỹỵđ"
        let ascii = "AAAAAAAAAAAAAAAAAEEEEEEEEEEEOOOOOOOOOOOOOOOOOUUUUUUUUUUUIIIIIYYYYYDaaaaaaaaaaaaaaaaaeeeeeeeeeeeooooooooooooooooouuuuuuuuuuuiiiiiyyyyyd"
        
        var inputString = self
        
        for i in 0 ..< ascii.count {
            
            inputString = inputString.replacingOccurrences(of: vietnamese[i], with: ascii[i])
        }
        //    for var i = 0; i < To.Length; i++)
        //    {
        //        self.replacingOccurrences(of: <#T##StringProtocol#>, with: <#T##StringProtocol#>)
        //   // self = self.Replace(convert[i], To[i]);
        //    }
        
        return inputString
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension UIScrollView {
    func fitHeightToChild(bottomDistance: CGFloat = 8) {
        var height: CGFloat = 0
        for subView in subviews where !subView.isHidden {
            let endPoint = subView.frame.origin.y + subView.frame.height
            height = endPoint > height ? endPoint : height
        }
        height += bottomDistance
        self.contentSize = CGSize(width: self.contentSize.width, height: height)
    }
    
    func fitWidthToChild(trailDistance: CGFloat = 8) {
        var width: CGFloat = 0
        for subView in subviews where !subView.isHidden  {
            
            let endPoint = subView.frame.origin.x + subView.frame.width
            width = endPoint > width ? endPoint : width
        }
        width += trailDistance
        self.contentSize = CGSize(width: width, height: self.contentSize.height)
    }
    
    func lastChildTrail(trailDistance: CGFloat = 8) -> CGFloat {
        var width: CGFloat = 0
        for subView in subviews where !subView.isHidden && subView.alpha != 0 {
            let endPoint = subView.frame.origin.x + subView.frame.width
            width = endPoint > width ? endPoint : width
        }
        width += trailDistance
        return width
    }
    
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: 0)
        setContentOffset(topOffset, animated: animated)
    }

    // Bonus: Scroll to bottom
    func scrollToBottom(animated: Bool) {
//        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
//        if(bottomOffset.y > 0) {
//            setContentOffset(bottomOffset, animated: animated)
//        }
        if #available(iOS 11.0, *) {
            self.scrollRectToVisible(CGRect(x: 0, y: (self.contentSize.height + self.safeAreaInsets.top) - 1, width: 1, height: 1), animated: true)
        } else {
            self.scrollRectToVisible(CGRect(x: 0, y: (self.contentSize.height) - 1, width: 1, height: 1), animated: true)
        }
    }
    
}

extension UIView {
    func calculateHeightToFit(bottomDistance: CGFloat = 8) -> CGFloat {
        var height: CGFloat = 0
        for subView in subviews where !subView.isHidden {
            let endPoint = subView.frame.origin.y + subView.frame.height
            height = endPoint > height ? endPoint : height
        }
        height += bottomDistance
        return height
    }
    
    func dropShadow(offsetX: CGFloat, offsetY: CGFloat, color: UIColor, opacity: Float, radius: CGFloat, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = 5
        layer.cornerRadius = radius
    }
    
    
    /**
     With view in UITableViewCell
     Should call in override func layoutIfNeeded()
     */
    static func gradientImage(for view: UIView, start: UIColor = AppColors.gradientStart, end: UIColor = AppColors.gradientMid, startPoint: CGPoint, endPoint: CGPoint) -> (UIImage?) {
        let gradient = CAGradientLayer()
        var bounds = view.bounds
        gradient.frame = bounds
        gradient.colors = [start.cgColor, end.cgColor]
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        
        func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
            var gradientImage:UIImage?
            UIGraphicsBeginImageContext(gradientLayer.frame.size)
            if let context = UIGraphicsGetCurrentContext() {
                gradientLayer.render(in: context)
                gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
            }
            UIGraphicsEndImageContext()
            return gradientImage
        }
        
        return getImageFrom(gradientLayer: gradient)
            
    }
}

extension ConstraintMaker {
    public func aspectRatio(_ x: Int, by y: Int, self instance: ConstraintView) {
        self.width.equalTo(instance.snp.height).multipliedBy(x / y)
    }
}

//MARK: TextField
private var KeyMaxLength: Int = 0
extension UITextField {
    
    public var hasValidEmail: Bool {
        return text!.range(of: "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}" +
            "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
            "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
            "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
            "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
            "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
            "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    func setBottomBorder(color:UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set(hasDone){
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
    
    class func connectAllTxtFieldFields(txtfields:[UITextField]) -> Void {
        guard let last = txtfields.last else {
            return
        }
        for i in 0 ..< txtfields.count - 1 {
            txtfields[i].returnKeyType = .next
            txtfields[i].addTarget(txtfields[i+1], action: #selector(UIResponder.becomeFirstResponder), for: .editingDidEndOnExit)
        }
        last.returnKeyType = .done
        last.addTarget(last, action: #selector(UIResponder.resignFirstResponder), for: .editingDidEndOnExit)
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
    
    func setRightIcon(image: UIImage,  color: UIColor = UIColor.darkGray, iconSize: CGSize = CGSize(width: 16, height: 16)) {
        self.rightViewMode = .always
        let imgView = UIImageView(frame: CGRect(origin: .zero, size: iconSize))
        imgView.tintColor = color
        imgView.image = image.withRenderingMode(.alwaysTemplate)
        self.rightView = imgView
    }
    
    public func placeholderColor(_ color: UIColor){
        var placeholderText = ""
        if self.placeholder != nil{
            placeholderText = self.placeholder!
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
    
    public func setLeftIcon(image: UIImage,  color: UIColor = UIColor.darkGray, iconSize: CGSize = CGSize(width: 16, height: 16)) {
        self.leftViewMode = .always
        let imgView = UIImageView(frame: CGRect(origin: .zero, size: iconSize))
        imgView.tintColor = color
        imgView.contentMode = .scaleAspectFit
        imgView.image = image.withRenderingMode(.alwaysTemplate)
        self.leftView = imgView
    }
    
    func addBottomLine(_ color: UIColor = UIColor(rgba: "#ECECEC")!, lineHeight: CGFloat = 0.5){
        // note: need set height for UITextField at first
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: lineHeight)
        bottomLine.backgroundColor = color.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
    
}

//private var borders = [UITextView: Bool]()
//
//extension UITextView {
//
//  @IBInspectable var showBottomBorder: Bool {
//    get {
//      guard let b = borders[self] else {
//        return true
//      }
//      return b
//    }
//    set {
//      borders[self] = newValue
//      setUpBottomBorder()
//    }
//  }
//
//  func setUpBottomBorder(){
//    let border = UIView()
//
//    border.translatesAutoresizingMaskIntoConstraints = false
//    border.backgroundColor = UIColor.red
//    self.addSubview(border)
//
//    border.heightAnchor.constraint(equalToConstant: 2).isActive = true
//    border.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//    border.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//    border.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//  }
//}

extension UITextView {
    func addBottomLine(_ color: UIColor = UIColor(rgba: "#ECECEC")!, lineHeight: CGFloat = 0.5){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: lineHeight)
        bottomLine.backgroundColor = color.cgColor
        layer.addSublayer(bottomLine)
        layer.masksToBounds = true
    }
}

extension UITextView {
    func addBottomBorderWithColor(color: UIColor, height: CGFloat) {
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        border.frame = CGRect(x: self.frame.origin.x,
                              y: self.frame.origin.y + self.frame.height - height, width: self.frame.width, height: height)
        border.backgroundColor = color
        self.superview!.insertSubview(border, aboveSubview: self)
    }
}

extension UIView {
    func forceEndEditing() {
        findFistResponderTextField(self)?.resignFirstResponder()
    }
    private func findFistResponderTextField(_ view: UIView) -> UIView?
    {
        for childView in view.subviews
        {
            if(childView.isFirstResponder == true)
            {
                return childView
            }
            let result = findFistResponderTextField(childView)
            if(result != nil)
            {
                return result
            }
        }
        return nil
    }
    
    open class func addNonReuseView(subView : UIView, to container : UIView, setConstraint: @escaping (UIView) -> Void) {
        container.addSubview(subView)
        setConstraint(subView)
    }
    
    func addNonReuseView(subView : UIView, setConstraint: @escaping (UIView) -> Void) {
        self.addSubview(subView)
        setConstraint(subView)
    }

}

extension UIWindow {

    /// Fix for http://stackoverflow.com/a/27153956/849645
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {

        let previousViewController = rootViewController

        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }

        rootViewController = newRootViewController

        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }

        if #available(iOS 13.0, *) {
            // In iOS 13 we don't want to remove the transition view as it'll create a blank screen
        } else {
            // The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
            if let transitionViewClass = NSClassFromString("UITransitionView") {
                for subview in subviews where subview.isKind(of: transitionViewClass) {
                    subview.removeFromSuperview()
                }
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}


extension NSDictionary {
    func getInt(forKey key: Any) -> Int? {
        let rawValue = self.object(forKey: key)
        if let iValue = rawValue as? Int {
            return iValue
        }
        if let sValue = rawValue as? String {
            return Int(sValue)
        }
        return nil
    }
    
    func getInt64(forKey key: Any) -> Int64? {
        let rawValue = self.object(forKey: key)
        if let iValue = rawValue as? Int64 {
            return iValue
        }
        if let sValue = rawValue as? String {
            return Int64(sValue)
        }
        return nil
    }
    
    func getDouble(forKey key: Any) -> Double? {
        let rawValue = self.object(forKey: key)
        if let iValue = rawValue as? Double {
            return iValue
        }
        if let sValue = rawValue as? String {
            return Double(sValue)
        }
        return nil
    }
    
    func getDecimal(forKey key: Any) -> Decimal? {
        let rawValue = self.object(forKey: key)
        
        if let double = rawValue as? Double {
            // always convert double to string first
            // can test with double = 7.39
            return Decimal(string: "\(double)")
        }
        
        if let iValue = rawValue as? NSNumber {
            return iValue.decimalValue
        }
        
        if let sValue = rawValue as? String {
            return Decimal(string: sValue)
        }
        return nil
    }
    
    func getString(forKey key: Any) -> String? {
        return object(forKey: key) as? String
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    public static func suggestMoney(inputAmount: Double, availableAmount: Double, maximumSuggestCount: Int = 3) -> [Double] {
        var retVal = [Double]()
        
        
        let inputAmountStr: String = "\(NSNumber(value: inputAmount).int64Value)"
        let numberLength = inputAmountStr.count
        
        var basedAmount = inputAmount
        if basedAmount <= 0 {
            basedAmount = 1
        }
        
        // get maximum unit
        var stepUnit: Double = 1.0
        switch availableAmount {
        case _ where availableAmount >= 100_000_000_000:
            stepUnit = 100_000_000_000
        case _ where availableAmount >= 10_000_000_000:
            stepUnit = 10_000_000_000
        case _ where availableAmount >= 1_000_000_000:
            stepUnit = 1_000_000_000
        case _ where availableAmount >= 100_000_000:
            stepUnit = 100_000_000
        case _ where availableAmount >= 10_000_000:
            stepUnit = 10_000_000
        case _ where availableAmount >= 1_000_000:
            stepUnit = 1_000_000
        case _ where availableAmount >= 100_000:
            stepUnit = 100_000
        default:
            stepUnit = 1_000
        }
        
        //var m = pow(availableAmount, (1.0/numberLength))
        //let newUnit = (m * 1000).rounded() / 1000

        if numberLength > 1 {
            var d = 1
            while d < numberLength {
                print("downStep times \(d)")
                stepUnit = stepUnit / 10
                d += 1
                if stepUnit <= 1 {
                    break
                }
            }
        }
        
        print("customerInput: \(basedAmount)" )
        print("cashAvailable: \(availableAmount)" )
        print("stepUnit: \(stepUnit)" )
        
        var suggest: Double = 1
        var i = 1
        while i <= maximumSuggestCount {
            print("\nscan times \(i) stepUnit: \(stepUnit)" )
            suggest = basedAmount * stepUnit
            
            //valid is not over available amount
            if suggest <= availableAmount {
                print(">>> suggest \(i) = \(suggest)" )
                retVal.append(suggest)
                i += 1
            } else {
                print("===> no suggest, need down round!!!" )
            }
            
            //
            if stepUnit <= 1 {
                break
            }
            
            stepUnit = stepUnit / 10
        }
        
        return retVal
    }

}

extension Date {
    
    func daysCount(withDate: Date) -> Int? {
        //compare with today, added future day count
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: self)
        let date2 = calendar.startOfDay(for: withDate)
        
        return calendar.dateComponents([.day], from: date1, to: date2).day
    }
    
    // compare must over 24h
    func daysBetweenDate(toDate: Date) -> Int {
        let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
        return components.day ?? 0
    }
    
    func totalDistance(from date: Date, resultIn component: Calendar.Component) -> Int? {
        return Calendar.current.dateComponents([component], from: self, to: date).value(for: component)
    }

    func compare(with date: Date, only component: Calendar.Component) -> Int {
        let days1 = Calendar.current.component(component, from: self)
        let days2 = Calendar.current.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        return self.compare(with: date, only: component) == 0
    }
}

extension UIView {
    public func roundCorners(corners: UIRectCorner = [.topLeft, .topRight], cornerRadius: CGSize = CGSize(width: 8, height: 8)) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerRadius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

// From http://stackoverflow.com/questions/21167226/resizing-a-uilabel-to-accomodate-insets/21267507#21267507

@IBDesignable
class EdgeInsetLabel: UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
//    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        let insetRect = UIEdgeInsetsInsetRect(bounds, textInsets)
//        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
//        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
//                                          left: -textInsets.left,
//                                          bottom: -textInsets.bottom,
//                                          right: -textInsets.right)
//        return UIEdgeInsetsInsetRect(textRect, invertedInsets)
//    }
//
//    override func drawText(in rect: CGRect) {
//        super.drawText(in: UIEdgeInsetsInsetRect(rect, textInsets))
//    }
}

extension EdgeInsetLabel {
    @IBInspectable
    var leftTextInset: CGFloat {
        set { textInsets.left = newValue }
        get { return textInsets.left }
    }
    
    @IBInspectable
    var rightTextInset: CGFloat {
        set { textInsets.right = newValue }
        get { return textInsets.right }
    }
    
    @IBInspectable
    var topTextInset: CGFloat {
        set { textInsets.top = newValue }
        get { return textInsets.top }
    }
    
    @IBInspectable
    var bottomTextInset: CGFloat {
        set { textInsets.bottom = newValue }
        get { return textInsets.bottom }
    }
}

extension UIDevice {
    public var hasNotch: Bool {
        var bottom: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        } else {
            // Fallback on earlier versions
        }
        return bottom > 0
    }
}

//extension UIImage {
//
//    public static func fontAwesomeIcon(name: FontAwesome, textColor: UIColor, size: CGSize, backgroundColor: UIColor = UIColor.clear, borderWidth: CGFloat = 0, borderColor: UIColor = UIColor.clear) -> UIImage {
//
//        return UIImage.fontAwesomeIcon(name: name, style: .solid, textColor: textColor, size: size)
//    }
//
//    func fixOrientation() -> UIImage? {
//    if self.imageOrientation == UIImage.Orientation.up {
//    return self
//    }
//
//    UIGraphicsBeginImageContext(self.size)
//    self.draw(in: CGRect(origin: .zero, size: self.size))
//    let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return normalizedImage
//    }
//}

//// Defines types of hash string outputs available
//public enum HashOutputType {
//    // standard hex string output
//    case hex
//    // base 64 encoded string output
//    case base64
//}
//
//extension Data {
//
//    /// Hashing algorithm that prepends an RSA2048ASN1Header to the beginning of the data being hashed.
//    ///
//    /// - Parameters:
//    ///   - type: The type of hash algorithm to use for the hashing operation.
//    ///   - output: The type of output string desired.
//    /// - Returns: A hash string using the specified hashing algorithm, or nil.
//    public func hashWithRSA2048Asn1Header(_ type: HashType, output: HashOutputType = .hex) -> String? {
//
//        let rsa2048Asn1Header:[UInt8] = [
//            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
//            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
//        ]
//
//        var headerData = Data(bytes: rsa2048Asn1Header)
//        headerData.append(self)
//
//        return hashed(type, output: output)
//    }
//
//    /// Hashing algorithm for hashing a Data instance.
//    ///
//    /// - Parameters:
//    ///   - type: The type of hash to use.
//    ///   - output: The type of hash output desired, defaults to .hex.
//    ///   - Returns: The requested hash output or nil if failure.
//
//}

extension CIImage {
    
    /// Combines the currentbounds.inset by: ntered.
    func combined(with image: CIImage) -> CIImage? {
        guard let combinedFilter = CIFilter(name: "CISourceOverCompositing") else { return nil }
        let centerTransform = CGAffineTransform(translationX: extent.midX - (image.extent.size.width / 2), y: extent.midY - (image.extent.size.height / 2))
        combinedFilter.setValue(image.transformed(by: centerTransform), forKey: "inputImage")
        combinedFilter.setValue(self, forKey: "inputBackgroundImage")
        return combinedFilter.outputImage!
    }
}

extension CIImage {
    /// Inverts the colors and creates a transparent image by converting the mask to alpha.
    /// Input image should be black and white.
    var transparent: CIImage? {
        return inverted?.blackTransparent
    }
    
    /// Inverts the colors.
    var inverted: CIImage? {
        guard let invertedColorFilter = CIFilter(name: "CIColorInvert") else { return nil }
        
        invertedColorFilter.setValue(self, forKey: "inputImage")
        return invertedColorFilter.outputImage
    }
    
    /// Converts all black to transparent.
    var blackTransparent: CIImage? {
        guard let blackTransparentFilter = CIFilter(name: "CIMaskToAlpha") else { return nil }
        blackTransparentFilter.setValue(self, forKey: "inputImage")
        return blackTransparentFilter.outputImage
    }
    
    /// Applies the given color as a tint color.
    func tinted(using color: UIColor) -> CIImage?
    {
        guard
            let transparentQRImage = transparent,
            let filter = CIFilter(name: "CIMultiplyCompositing"),
            let colorFilter = CIFilter(name: "CIConstantColorGenerator") else { return nil }
        
        let ciColor = CIColor(color: color)
        colorFilter.setValue(ciColor, forKey: kCIInputColorKey)
        let colorImage = colorFilter.outputImage
        
        filter.setValue(colorImage, forKey: kCIInputImageKey)
        filter.setValue(transparentQRImage, forKey: kCIInputBackgroundImageKey)
        
        return filter.outputImage!
    }
}

extension URL {
    
    /// Creates a QR code for the current URL in the given color.
    func qrImage(using color: UIColor) -> CIImage? {
        return qrImage?.tinted(using: color)
    }
    
    /// Returns a black and white QR code for this URL.
    var qrImage: CIImage? {
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        let qrData = absoluteString.data(using: String.Encoding.ascii)
        qrFilter.setValue(qrData, forKey: "inputMessage")
        
        let qrTransform = CGAffineTransform(scaleX: 12, y: 12)
        return qrFilter.outputImage?.transformed(by: qrTransform)
    }
}

extension DateFormatter {
    convenience init(format: String) {
        self.init()
        self.dateFormat = format
    }
}
extension NSMutableAttributedString {
    
    @discardableResult func custom(_ text: String, font: UIFont? = nil, color: UIColor? = nil) -> NSMutableAttributedString {
        var attrs: [NSAttributedString.Key: Any] = [:]
        if color != nil {
            attrs[.foregroundColor] = color
        }
        if font != nil {
            attrs[.font] = font
        }
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)

        return self
    }
    
    @discardableResult func bold(_ text: String, font: UIFont = UIFont.customOpenSans(14, .bold), color: UIColor = AppColors.textBlack) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)

        return self
    }
    
    @discardableResult func underlineBold(_ text: String, font: UIFont = UIFont.customOpenSans(14, .bold), color: UIColor = AppColors.textBlack) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)

        return self
    }
    
    @discardableResult func underline(_ text: String, font: UIFont = UIFont.openSans(ofSize: 14), color: UIColor = AppColors.textBlack) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
           let normalString = NSMutableAttributedString(string:text, attributes: attrs)
           append(normalString)

           return self
       }
    
    @discardableResult func normal(_ text: String, font: UIFont = UIFont.openSans(ofSize: 14), color: UIColor = AppColors.textBlack) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let normalString = NSMutableAttributedString(string:text, attributes: attrs)
        append(normalString)

        return self
    }
    
    @discardableResult func boldCenter(_ text: String, color: UIColor) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.customOpenSans(14, .bold), .foregroundColor: color, .paragraphStyle: style]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)

        return self
    }
    
    @discardableResult func normalText(_ text: String, font: UIFont = UIFont.openSans(ofSize: 14), color: UIColor = AppColors.textBlack) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let normalString = NSMutableAttributedString(string:text, attributes: attrs)
        append(normalString)

        return self
    }
}

extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        var mask =  CAShapeLayer()
//        if let shape = (self.layer.mask as? CAShapeLayer) {
//            mask = shape
//        }
//        mask.path = path.cgPath
//        self.layer.mask = mask
        
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = corners
        }
    }
}

extension UIButton {
    
    convenience init(title: String = "", font: UIFont, titleColor: UIColor, backColor: UIColor, corner: CGFloat = 0) {
        self.init()
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.accessibilityLabel = title
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backColor
        self.layer.cornerRadius = corner
    }
}

extension UIStackView {
    
    convenience init(axis : NSLayoutConstraint.Axis, distribution : UIStackView.Distribution, alignment : UIStackView.Alignment, spacing : CGFloat, edgeInset : UIEdgeInsets? = nil, custom: ((UIStackView) -> Void)? = nil){
        
        self.init(frame: .zero)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
        
        if (edgeInset != nil) {
            self.layoutMargins = edgeInset ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.isLayoutMarginsRelativeArrangement = true
        }
        custom?(self)
    }
    
    func addArrangedSubview(_ subView : UIView, custom: @escaping (UIView) -> Void) {
        self.addArrangedSubview(subView)
        custom(subView)
    }
}

extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
    
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
    
    static func validBankAccountNo(_ account : String) -> Bool {
        // accept only alphabet and number
        let regex = NSRegularExpression("[^a-zA-Z0-9]")
        let match = regex.matches(account)
        return !match
    }
    
    static func hasSpecialCharacter(_ message : String) -> Bool {
        // accept space,
        // ignore comma, dot, stroke line, under_scroe
        let regex = NSRegularExpression("[^a-zA-Z0-9 ]")
        let match = regex.matches(message)
        return match
    }
}

extension String {
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&# ]{8,32}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}

extension UIFont {
    /*
     Family: Open Sans Font names: ["OpenSans-Regular", "OpenSans-Bold", "OpenSans-SemiBoldItalic", "OpenSans-ExtraBoldItalic", "OpenSans-LightItalic", "OpenSans-BoldItalic", "OpenSans-Light", "OpenSans-SemiBold", "OpenSans-Italic", "OpenSans-ExtraBold"]
 */
    static func trebuchetMSBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "TrebuchetMS-Bold", size: ofSize)!
    }
    
//    static func openSansBold(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-Bold", size: ofSize)!
//    }
//
//    static func openSansSemiBoldItalic(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-SemiBoldItalic", size: ofSize)!
//    }
//
//    static func openSansExtraBoldItalic(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-ExtraBoldItalic", size: ofSize)!
//    }
//
//    static func openSansLightItalic(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-LightItalic", size: ofSize)!
//    }
//
//    static func openSansBoldItalic(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-BoldItalic", size: ofSize)!
//    }
//
//    static func openSansLight(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-Light", size: ofSize)!
//    }
//
//    static func openSansSemiBold(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-SemiBold", size: ofSize)!
//    }
//
//    static func openSansItalic(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-Italic", size: ofSize)!
//    }
//
//    static func openSansExtraBold(ofSize: CGFloat) -> UIFont {
//        return UIFont(name: "OpenSans-ExtraBold", size: ofSize)!
//    }
    
    enum openSansWeight : String {
        case bold = "Bold"
        case regular = "Light"
        case semiBoldItalic = "MediumItalic"
        case extraBoldItalic = "ExtraBoldItalic"
//        case light = "Light"
        case italic = "Italic"
        case semiBold = "Medium"
        case extraBold = "Black"
    }
    
//    enum systemWeight {
//        case regular
//        case bold
//        case italic
//    }
    
    func withWeight(_ weight : openSansWeight) -> (UIFont) {
        return UIFont(name: "Roboto-\(weight.rawValue)", size: self.pointSize) ?? self
    }
    static let customNormal14 : UIFont = UIFont.systemFont(ofSize: 14)
    static let customBig16 = UIFont.systemFont(ofSize: 16)
    static let customSmall12 = UIFont.systemFont(ofSize: 15)
    static func customOpenSans(_ size : CGFloat,_ weight : openSansWeight = .regular) -> (UIFont){
        return UIFont(name: "Roboto-\(weight.rawValue)", size: size)!
    }
    
    static func openSans(ofSize: CGFloat) -> UIFont {
        return UIFont.customOpenSans(ofSize, .regular)
    }
}

extension UIView {
//    convenience init(backColor : UIColor, corner : CGFloat, border : CGFloat, borderColor : UIColor){
//        self.init(frame: .zero)
//        self.backgroundColor = backColor
//        if (corner > 0) {
//            self.clipsToBounds = true
//            self.layer.cornerRadius = corner
//        }
//        self.layer.borderColor = borderColor.cgColor
//        self.layer.borderWidth = border
//    }
    
    convenience init(backColor : UIColor, corner : CGFloat, border : CGFloat, borderColor : UIColor, custom: ((UIView) -> Void)? = nil){
        self.init(frame: .zero)
        self.backgroundColor = backColor
        if (corner > 0) {
//            self.clipsToBounds = true
            self.layer.cornerRadius = corner
        }
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = border
        custom?(self)
    }
    
    convenience init(custom :  (UIView) -> Void){
        self.init(frame: .zero)
        custom(self)
    }
    
    convenience init(edgeInsets : UIEdgeInsets, custom : ((UIView) -> Void)?){
        self.init(frame: .zero)
        self.layoutMargins = edgeInsets
        custom?(self)
    }
    
    func addSubView(_ view : UIView, customView: (UIView) -> Void) {
        self.addSubview(view)
        customView(view)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        dropShadow()
//    }
    
    func dropShadow(){
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 10
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
//        layer.masksToBounds = false
//        layer.shadowColor = UIColor.gray.cgColor
//        layer.shadowOpacity = 0.8
//        layer.shadowOffset = CGSize(width: 2, height: 4)
//        layer.shadowRadius = 3.0
        
//        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//        layer.shouldRasterize = true
//        layer.rasterizationScale = 1
        
        
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowRadius = 3.0
//        self.layer.shadowOffset = CGSize(width: 2, height: 4)
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 5, height: 5)
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowRadius = 4.0
    }
    
    func groupRoundedShadow(cornerRadius: CGFloat = 10) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 6
//        panelAccountFunction.layer.borderWidth = 0.1
//        panelAccountFunction.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = false
    }
}
