//
//  HospitalIntroduceTableViewCell.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 17/04/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalIntroduceTableViewCell: UITableViewCell {
    
    static let id = "HospitalIntroduceTableViewCell"
    
    private let scrollPage = UIScrollView()
    private let stackPage = UIStackView(axis: .horizontal, distribution: .equalSpacing, alignment: .fill, spacing: 0)
    private var listImage: [String] = [] {
        didSet {
            if listImage.isEmpty {
                scrollPage.snp.makeConstraints({
                    $0.height.equalTo(0)
                })
                return
            }
            stackPage.arrangedSubviews.forEach({$0.removeFromSuperview()})
            pageControl.numberOfPages = listImage.count
            for i in 0..<listImage.count {
                let imageView = UIImageView(image: UIImage(named: listImage[i]))
                stackPage.addArrangedSubview(imageView)
                imageView.snp.makeConstraints({
                    $0.width.equalTo(scrollPage)
                })
                imageView.clipsToBounds = true
                imageView.contentMode = .scaleToFill
//                imageView.kf.setImage(with: url) { result in
//                    switch result {
//                    case .success(let value):
//                        print(value.source)
//
//                    case .failure(let error):
//                        print(error) // The error happens
//                    }
//                }
                imageView.pictureSquareImageView(url: "https://pkcongnghe.quanlyphongkham.net/Images/" + listImage[i])
                imageView.tag = i
//                imageView.isUserInteractionEnabled = true
//                imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actOpenWeb)))
            }
            startTimer()
        }
    }
    private let pageControl = UIPageControl()
    private var isVi = true
    private var timer: Timer?
    var selectedNotify: (() -> Void)? = nil
    let btnNotify = UIButton()
    private let lbNotify = UILabel(text: "", font: UIFont.customOpenSans(12), color: .white)
//    private var listImgUrl: [String] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(self.notiChangeCount), name: Notification.Name(NotificationKey.notiCountChange.rawValue), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        self.contentView.setLinearGradient(startColor: AppColors.gradientStart, endColor: AppColors.gradientMid)
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
    
    @objc private func actCall() {
        if let url = URL(string: "tel://\(DataManager.shared.companyModel?.DienThoai ?? "")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    func setupUI() {
        
        let vHeader = UIView()
        func setContact() {
            self.contentView.addSubview(vHeader)
            vHeader.snp.makeConstraints({
                $0.top.centerX.width.equalToSuperview()
            })
            let btnHome = UIButton(title: "Trang chủ", font: UIFont.systemFont(ofSize: 20, weight: .bold), titleColor: .white, backColor: .clear, corner: 0)
            vHeader.addSubview(btnHome)
            btnHome.snp.makeConstraints {
                $0.centerY.height.equalToSuperview()
                $0.leading.equalToSuperview().offset(10)
            }
            
            let vContact = UIView()
            vHeader.addSubview(vContact)
            vContact.snp.makeConstraints({
                $0.trailing.equalToSuperview().offset(-10)
                $0.centerY.height.equalToSuperview()
            })
            let icContact = UIImageView(image: UIImage(named: AssetsName.icCall)?.withRenderingMode(.alwaysTemplate))
            vContact.addSubview(icContact)
            icContact.snp.makeConstraints({
                $0.centerY.height.equalToSuperview()
                $0.leading.equalToSuperview()
                $0.width.equalTo(36)
            })
            icContact.tintColor = .white
            icContact.contentMode = .scaleAspectFit
            let lbContact = UILabel(text: "Hotline\n\(DataManager.shared.companyModel?.DienThoai ?? "")", font: .systemFont(ofSize: 16, weight: .bold), color: .white, breakable: true)
            vContact.addSubview(lbContact)
            lbContact.snp.makeConstraints({
                $0.centerY.height.equalToSuperview()
                $0.height.equalTo(68)
                $0.leading.equalTo(icContact.snp.trailing).offset(8)
            })
            lbContact.textAlignment = .center
            vContact.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actCall)))
            
            vContact.addSubview(btnNotify)
            btnNotify.snp.makeConstraints({
                $0.centerY.trailing.equalToSuperview()
                $0.leading.equalTo(lbContact.snp.trailing).offset(4)
                $0.size.equalTo(32)
            })
            btnNotify.setImage(UIImage(named: "ic_notification")?.withRenderingMode(.alwaysTemplate), for: .normal)
            btnNotify.tintColor = .white
            btnNotify.imageView?.contentMode = .scaleAspectFit
            btnNotify.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actOpenNotification)))
            
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
            if SessionManager.shared.countNoti > 0 {
                lbNotify.text = " \(SessionManager.shared.countNoti) "
                lbNotify.isHidden = false
            } else {
                lbNotify.isHidden = true
            }
        }
        setContact()
        
        let vSignal = UIView()
        self.contentView.addSubview(vSignal)
        vSignal.backgroundColor = .white
        vSignal.snp.makeConstraints({
            $0.top.equalTo(vHeader.snp.bottom)
            $0.width.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
        //        vSignal.backgroundColor = .white
        vSignal.roundCorners([.topLeft, .topRight], radius: 20)
        vSignal.backgroundColor = .white
        
        let icLogo = UIImageView(image: UIImage(named: AssetsName.icLogo))
        vSignal.addSubview(icLogo)
        icLogo.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.size.equalTo(96)
        })
        let lbTitle = UILabel(text: DataManager.shared.companyModel?.TenCongTy ?? "Phòng khám công nghệ 4.0", font: .customOpenSans(18, .semiBold), color: UIColor(hex: "1A6CEE"))
        vSignal.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.top.equalTo(icLogo.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        })
        
        let lbSubtitle = UILabel(text: DataManager.shared.companyModel?.TenThuongHieu ?? "Niềm tin vào cuộc sống", font: .customOpenSans(16, .semiBoldItalic), color: UIColor(hex: "54C0FF"))
        vSignal.addSubview(lbSubtitle)
        lbSubtitle.snp.makeConstraints({
            $0.top.equalTo(lbTitle.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
//            $0.bottom.equalToSuperview()
        })
        
        vSignal.addSubview(scrollPage)
        scrollPage.snp.makeConstraints({
            $0.height.equalTo(scrollPage.snp.width).multipliedBy(325.0/850)
            $0.top.equalTo(lbSubtitle.snp.bottom).offset(8)
            $0.width.centerX.equalToSuperview()
        })
        scrollPage.clipsToBounds = true
        scrollPage.addSubview(stackPage)
        scrollPage.showsHorizontalScrollIndicator = false
        scrollPage.isPagingEnabled = true
        stackPage.snp.makeConstraints({
            $0.edges.height.equalToSuperview()
        })
        scrollPage.delegate = self
        pageControl.pageIndicatorTintColor = AppColors.primaryColor.withAlphaComponent(0.3)
        pageControl.currentPageIndicatorTintColor = AppColors.primaryColor
        pageControl.currentPage = 0
        pageControl.numberOfPages = 0
        vSignal.addSubview(pageControl)
        pageControl.snp.makeConstraints({
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scrollPage.snp.bottom)
            $0.bottom.equalToSuperview().offset(-4)
        })
        var listImg: [String] = []
        let listUrl = [DataManager.shared.companyModel?.AnhSlider1,
                       DataManager.shared.companyModel?.AnhSlider2,
                       DataManager.shared.companyModel?.AnhSlider3,
                       DataManager.shared.companyModel?.AnhSlider4]
        listUrl.forEach({
            if let img = $0 {
                listImg.append(img)
            }
        })
        self.listImage = listImg
    }
    
    @objc func actOpenWeb(_ gesture: UITapGestureRecognizer) {
//        if let tag = gesture.view?.tag {
//            if let module = listImage[tag].moduleInapp {
//                if let parent = self.parent {
//                    Coordinator.actPresentFunction(parent, module: ModuleModel(key: module))
//                } else {
//                    Coordinator.actPresentFunction(self, module: ModuleModel(key: module))
//                }
//                return
//            }
//            if let url = URL(string: isVi ? listImage[tag].link_url_vi : listImage[tag].link_url_en) {
//                UIApplication.shared.open(url, options: [String: Any](), completionHandler: nil)
//            }
//        }
    }
    
    @objc func actOpenNotification() {
        selectedNotify?()
    }
    
    @objc private func nextPage() {
        var nextPage = pageControl.currentPage + 1
        if nextPage > (listImage.count - 1) {
            nextPage = 0
        }
        scrollPage.setContentOffset(CGPoint(x: scrollPage.frame.width * CGFloat(nextPage), y: 0), animated: true)
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.nextPage), userInfo: nil, repeats: true)
        timer?.fireDate = Date().adding(second: 5)
    }
}

extension HospitalIntroduceTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollPage.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        timer?.invalidate()
//        timer?.fire()
        startTimer()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
//        timer?.invalidate()
//        timer?.fire()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
}
