//
//  PresentedViewController.swift
//  SJDatePicker
//
//  Created by Sabrina on 2017/4/12.
//  Copyright © 2017年 Sabrina. All rights reserved.
//

import UIKit

typealias returnDate = (String?) -> ()

enum dateformat:String{
    case yyyy_m_d = "yyyy/MM/dd"
    case d_m_yyyy = "dd/MM/yyyy"
    case m_d_yy = "MM/dd/yy"
    case d_mmmm_yy = "d-MMMM-yy"
    case d_mmmm = "dd-MMMM"
    case mmmm_yy = "MMMM-yy"
    case h_mm_PM = "hh:mm aaa"
    case h_mm_ss = "HH:mm:ss"
    case h_mm = "HH:mm"
    case yyyy_To_ss = "yyyy/MM/dd HH:mm:ss"
    case mm_yyyy = "MM/yyyy"
}

class PresentedViewController: UIViewController {
    
    public var buttonColor:UIColor = UIColor.blue
    public var pickerMode:UIDatePicker.Mode = .date
    public var minimumDate:Date? = nil
    public var maximumDate:Date? = nil
    public var currentdate:Date? = nil
    public var returnDateFormat:dateformat = .d_m_yyyy
    public var titleString:String? = nil
    public var isHideDay: Bool = false
    
    fileprivate var picker:UIDatePicker = UIDatePicker()
    fileprivate var pickerMonthYear:MonthYearPickerView = MonthYearPickerView()
    fileprivate var confirmButton:UIButton = UIButton()
    fileprivate let cornerRadius:CGFloat = 7.5
    fileprivate let highlightedView:UIView = UIView()
    fileprivate let pickerHeight:CGFloat = 216
    fileprivate let pickerWidth:CGFloat = UIScreen.main.bounds.size.width - 10
    
    var block:returnDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if titleString != nil {
            let titleLabel:UILabel = UILabel(frame: CGRect(x: 5, y: 0, width: pickerWidth, height: 40))
            titleLabel.backgroundColor = UIColor.white
            titleLabel.layer.cornerRadius = cornerRadius
            titleLabel.layer.masksToBounds = true
            titleLabel.textColor = buttonColor
            titleLabel.textAlignment = .center
            titleLabel.text = titleString
            titleLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
            self.view.addSubview(titleLabel)
        }

        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
            
        } else {
            // Fallback on earlier versions
        }
        
        if isHideDay == true {
            pickerMonthYear.frame = CGRect(x: 5, y: 43, width: pickerWidth, height: pickerHeight)
            pickerMonthYear.backgroundColor = UIColor.white
            pickerMonthYear.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
            pickerMonthYear.layer.cornerRadius = cornerRadius
            //                   pickerMonthYear.datePickerMode = self.pickerMode
            pickerMonthYear.locale = Locale.init(identifier: "vi_VN")
            
            if let minDate = minimumDate {
                pickerMonthYear.minimumDate = minDate
            }
            
            if let maxDate = maximumDate {
                pickerMonthYear.maximumDate = maxDate
            }
            
            if let minDate = minimumDate, let maxDate = maximumDate {
                assert(minDate < maxDate, "minimum date cannot bigger then maximum date")
            }
            
            if let cuDate = currentdate {
                pickerMonthYear.setDate(cuDate, animated: true)
            }
            
            pickerMonthYear.layer.masksToBounds = true
            self.view.addSubview(pickerMonthYear)
            
            highlightedView.frame = CGRect(x: -5, y: ((pickerHeight - 40) / 2) + 2 , width: pickerWidth + 10, height: 35.5)
            highlightedView.backgroundColor = UIColor.clear
            highlightedView.layer.borderColor = buttonColor.cgColor
            highlightedView.layer.borderWidth = 1.0
            pickerMonthYear.addSubview(highlightedView)
        } else {
            picker.frame = CGRect(x: 5, y: 43, width: pickerWidth, height: pickerHeight)
            picker.backgroundColor = UIColor.white
            picker.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
            picker.layer.cornerRadius = cornerRadius
            picker.datePickerMode = self.pickerMode
            picker.locale = Locale.init(identifier: "vi_VN")
            if let minDate = minimumDate {
                picker.minimumDate = minDate
            }
            
            if let maxDate = maximumDate {
                picker.maximumDate = maxDate
            }
            
            if let minDate = minimumDate, let maxDate = maximumDate {
                assert(minDate < maxDate, "minimum date cannot bigger then maximum date")
            }
            
            if let cuDate = currentdate {
                picker.setDate(cuDate, animated: true)
            }
            
            picker.layer.masksToBounds = true
            self.view.addSubview(picker)
            
            highlightedView.frame = CGRect(x: -5, y: ((pickerHeight - 40) / 2) + 2 , width: pickerWidth + 10, height: 35.5)
            highlightedView.backgroundColor = UIColor.clear
            highlightedView.layer.borderColor = buttonColor.cgColor
            highlightedView.layer.borderWidth = 1.0
            picker.addSubview(highlightedView)
        }
        
        
        confirmButton.frame = CGRect(x: 5, y: CustomPresentationController.viewHeight + 5, width: pickerWidth, height: CustomPresentationController.buttonHeight)
        confirmButton.setTitle("Xác nhận", for: .normal)
        confirmButton.backgroundColor = buttonColor
        confirmButton.setTitleColor(UIColor.white, for: .normal)
        confirmButton.setTitleColor(UIColor.gray, for: .highlighted)
        confirmButton.layer.cornerRadius = cornerRadius
        confirmButton.layer.masksToBounds = true
        confirmButton.addTarget(self, action: #selector(confirmButton_Click), for: .touchUpInside)
        self.view.addSubview(confirmButton)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.initialize()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initialize() {
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    @objc func confirmButton_Click(){
        if block != nil {
            self.dismiss(animated: true, completion: nil)
            let df:DateFormatter = DateFormatter.init()
            if isHideDay == true {
                let string = String(format: "%02d/%d", pickerMonthYear.month, pickerMonthYear.year)
                self.block!(string)
            } else {
                df.dateFormat = returnDateFormat.rawValue
                df.timeZone = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
                let returnDate:String = df.string(from: picker.date)
                block!(returnDate)
            }
            
        }
    }
}

extension PresentedViewController:UIViewControllerTransitioningDelegate{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        if presented == self {
            return  CustomPresentationController(presentedViewController: presented, presenting: presenting)
        }else{
            return nil
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented == self {
            return CustomPresentationAnimationController(isPresenting: true)
        } else {
            return nil
        }
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed == self {
            return CustomPresentationAnimationController(isPresenting: false)
        } else {
            return nil
        }
    }
}

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    var timeZone: TimeZone?
    var locale: Locale?
    var minimumDate: Date?
    var maximumDate: Date?
    
    var months: [String]!
    var years: [Int]!
    
    func setDate(_ date: Date, animated: Bool) {
        let calendar = Calendar.current
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
    }
    
    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            selectRow(month-1, inComponent: 0, animated: false)
        }
    }
    
    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            selectRow(years.index(of: year)!, inComponent: 1, animated: true)
        }
    }
    
    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {
        // population years
        var years: [Int] = []
        if years.count == 0 {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
            for _ in 1...15 {
                years.append(year)
                year += 1
            }
        }
        self.years = years
        
        // population months with localized names
        var months: [String] = []
        var month = 0
        for _ in 1...12 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
            month += 1
        }
        self.months = months
        
        self.delegate = self
        self.dataSource = self
        
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        self.selectRow(currentMonth - 1, inComponent: 0, animated: false)
    }
    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return "\(years[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = self.selectedRow(inComponent: 0)+1
        let year = years[self.selectedRow(inComponent: 1)]
        if let block = onDateSelected {
            block(month, year)
        }
        
        self.month = month
        self.year = year
    }
    
}
