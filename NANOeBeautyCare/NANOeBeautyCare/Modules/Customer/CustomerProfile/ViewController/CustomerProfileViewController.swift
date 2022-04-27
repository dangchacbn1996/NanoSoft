//
//  CustomerProfileViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 9/22/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class CustomerProfileViewController: BaseViewController<CustomerProfilePresenter> {
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnNotify: UIButton!
    // MARK: - IBOutlet
    @IBOutlet weak var backgroudImageview: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    // MARK: - IBOutlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var avartaImageView: UIImageView!
    // Member
    @IBOutlet weak var numberLeverLabel: UILabel!
    @IBOutlet weak var titleLeverLabel: UILabel!
    
    @IBOutlet weak var cardKhaiBao: CardView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var reserveLabel: UILabel!
    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var moreInfomationButton: MyGradientButton!
    @IBOutlet weak var historyButton: MyGradientButton!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var rowTime: UIView!
    @IBOutlet weak var swRemind: UISwitch!
    private let lbNotify = UILabel(text: "", font: UIFont.customOpenSans(12), color: .white)
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = CustomerProfilePresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.presenter?.initDataPresent()
        
//        self.edgesForExtendedLayout = UIRectEdge.top

        self.backgroundView.roundCorners([.topLeft,.topRight], radius: 24.0)
        let gradient = CAGradientLayer()
        let bounds = self.view.bounds
        gradient.frame = bounds
        gradient.colors = [AppColors.gradientStart.cgColor, AppColors.gradientEnd.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        logoutButton.imageView?.contentMode = .scaleAspectFit
        btnEdit.imageView?.contentMode = .scaleAspectFit
        btnNotify.imageView?.contentMode = .scaleAspectFit
        btnNotify.addSubview(lbNotify)
        lbNotify.backgroundColor = AppColors.viewRed
        lbNotify.snp.makeConstraints({
            $0.trailing.top.equalToSuperview()
            $0.height.equalTo(16)
            $0.width.greaterThanOrEqualTo(16)
        })
        lbNotify.textAlignment = .center
        lbNotify.layer.cornerRadius = 8
        lbNotify.clipsToBounds = true
        if let image = getImageFrom(gradientLayer: gradient) {
            self.backgroudImageview.image = image
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.notiChangeCount), name: Notification.Name(NotificationKey.notiCountChange.rawValue), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isHidden = true
//        if let cardBack = UIView.gradientImage(for: cardKhaiBao, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1)) {
//            let imBack = UIImageView(image: cardBack)
//            cardKhaiBao.ins
//        }
        cardKhaiBao.clipsToBounds = true
//        cardKhaiBao.setLinearGradient(startColor: AppColors.gradientStart, endColor: AppColors.gradientEnd)
        if SessionManager.shared.countNoti > 0 {
            lbNotify.text = " \(SessionManager.shared.countNoti) "
            lbNotify.isHidden = false
        } else {
            lbNotify.isHidden = true
        }
        
        notiChangeCount()
    }
    
    

    @objc
    private func notiChangeCount() {
        if SessionManager.shared.countNoti > 0 {
            lbNotify.text = " \(SessionManager.shared.countNoti) "
            lbNotify.isHidden = false
        } else {
            lbNotify.isHidden = true
        }
    }
    
    override func updatePanData(context: RouteContext) {
        super.updatePanData(context: context)
        //        print(context[RVBackContext])
//        self.presenter?.updateBackContextData(context: context)
    }
    
     // MARK: - Update Data IBOutlet
    func updateData(data: ViewCustomerProfile) {

    }

    // MARK: - Action Button
    @IBAction func backButtonAction(_ sender: Any) {
        self.backToPrevScreen()
    }
    @IBAction func moreInfomationButtonAction(_ sender: Any) {
        self.presenter?.goToMore()
    }

    @IBAction func historyButtonAction(_ sender: Any) {
        self.presenter?.goToHistory()
    }
    
    @IBAction func actEditUserInfo() {
        let vc = CustomerChangeInfomationViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func khaibaoyte(_ sender: Any) {
        let vc = KhaiBaoYTeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func actSwitch(_ sender: Any) {
        let target = !swRemind.isOn
        func timeConversion24(time12: String) -> String {
            let dateAsString = time12
            let df = DateFormatter()
            df.dateFormat = "hh:mm:ss a"

            let date = df.date(from: dateAsString)
            df.dateFormat = "HH:mm:ss"

            let time24 = df.string(from: date!)
            print(time24)
            return time24
        }
        if target {
            let currentdate: Date = DateFormatter(format: "HH:mm").date(from: lbTime.text ?? "") ?? Date()
            ActionSheetDatePicker.show(withTitle: "Chọn thời gian nhắc khai báo", datePickerMode: .time, selectedDate: currentdate, doneBlock: { picker, time, code in
                if let date = time as? Date {
                    var dateString = date.toString(format: "HH:mm")
                    if dateString.hasSuffix("M") {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "h:mm a"
                        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // fixes nil if device time in 24 hour format
                        let date = dateFormatter.date(from: dateString)

                        dateFormatter.dateFormat = "HH:mm"
                        dateString = dateFormatter.string(from: date!)
                    }
                    self.presenter?.loadKhaiBao(isOn: target, time: dateString, completion: {
                        self.swRemind.isOn = target
                        self.lbTime.text = dateString
                        UIView.animate(withDuration: 0.3) {
                            self.rowTime.isHidden = !self.swRemind.isOn
                        }
                    })
                    
                }
            }, cancel: { picker in
                
            }, origin: lbTime)
//            CommonView.alertTimeHHmm(title: "Chọn thời gian nhắc khai báo", currentdate: currentdate) { (date) in
//                self.presenter?.loadKhaiBao(isOn: target, time: date, completion: {
//                    self.swRemind.isOn = target
//                    self.lbTime.text = date
//                    UIView.animate(withDuration: 0.3) {
//                        self.rowTime.isHidden = !self.swRemind.isOn
//                    }
//                })
//
//            }
            
        } else {
            self.presenter?.loadKhaiBao(isOn: target, time: nil, completion: {
                self.swRemind.isOn = target
                UIView.animate(withDuration: 0.3) {
                    self.rowTime.isHidden = !self.swRemind.isOn
                }
            })
        }
//        swRemind.isOn = !swRemind.isOn
//        UIView.animate(withDuration: 0.3) {
//            self.rowTime.isHidden = !self.swRemind.isOn
//        }
        
    }
    
    @IBAction func actChangeTime(_ sender: Any) {
        
    }
    
    @IBAction func actChangePassword() {
        self.openChildScreen(.ChangePasswordViewController, fromStoryboard: .CustomerHome)
    }

    @IBAction func logoutButtonAction(_ sender: Any) {
        self.logoutAction()
    }
    
    @IBAction func actEdit() {
        
    }
    
    @IBAction func actNotify() {
        self.navigationController?.pushViewController(HospitalNotificationMainViewController(), animated: true)
    }
}

// MARK: - Protocol of Presenter
extension CustomerProfileViewController: CustomerProfileVC {
    func initData(data: CustomerDetailOptionalResponse) {
        self.avartaImageView.avartaImageView(url: Common.stringToUrlImage(text: data.anhKhachHang ?? ""))

        self.numberLeverLabel.text = "\(data.tongDiemTichLuy ?? 0)"
        self.titleLeverLabel.text = data.tenHangThanhVien

        self.titleLabel.text = data.hoTen
        self.addressLabel.text = data.diaChi
        self.reserveLabel.text = "\(data.soLuongLichHen ?? 0)"
        self.waitingLabel.text = "\(data.choPhucVu ?? 0)"
        self.cancelLabel.text = "\(data.huyLichHen ?? 0)"
        self.birthdayLabel.text = data.ngaySinh
        self.sexLabel.text = data.tenGioiTinh
        self.typeLabel.text = data.loaiKhachHang
        self.noteLabel.text = data.ghiChu
        self.swRemind.isOn = data.IsNhacLichThongBao ?? false
        self.rowTime.isHidden = !self.swRemind.isOn
        self.lbTime.text = data.GioNhacLich ?? "-"
    }
    
    func reloadData() {
    }
}


