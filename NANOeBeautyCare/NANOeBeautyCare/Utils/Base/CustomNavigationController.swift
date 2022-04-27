////
////  CustomNavigationController.swift
////
////  Created by Ngo Dang Chac on 09/03/2021.
////  Copyright © 2021 com.ifs. All rights reserved.
////
//
//import Foundation
//import UIKit
//
//class CustomNavigationController: UINavigationController {
//
//    private var showImgBack = true
//    private var showNavi = true
////    private var rootBackStyle = BackNaviButton.LeftBarStyle.back
//
//    private let TAG_FIRST = 1001
//    private let TAG_SECOND = 1002
//    private var backCustomAction: UITapGestureRecognizer? = nil
//
////    private var lbNavigationTitle = UILabel(font: .customOpenSans(16, .semiBold), color: .white, breakable: true)
//
//    convenience init(rootViewHideNavi: UIViewController) {
//        self.init(rootViewController: rootViewHideNavi, showImgBar: false)
//        self.setNavigationBarHidden(true, animated: false)
//    }
//
//    static func newNavOverFullscreen(vc: UIViewController) -> (CustomNavigationController){
//        let custom = CustomNavigationController(rootViewController: vc, showImgBar: true)
//        custom.modalTransitionStyle = .crossDissolve
//        custom.modalPresentationStyle = .overFullScreen
//        return custom
//    }
//
//    convenience override init(rootViewController: UIViewController) {
//        self.init(rootViewController: rootViewController, showImgBar: true)
//    }
//
//    init(rootViewController: UIViewController, showImgBar: Bool) {
//        super.init(rootViewController: rootViewController)
//        self.showImgBack = showImgBar
//        self.delegate = self
//        self.navigationBar.tintColor = UIColor.white
//        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.clear]
////        if #available(iOS 11.0, *) {
////            self.navigationItem.backButtonTitle = nil
////        }
//        if showImgBack {
//            self.navigationBar.isTranslucent = true
//            self.navigationBar.setBackgroundImage(UIImage(), for: .default)
//            self.navigationBar.shadowImage = UIImage()
//            self.navigationBar.barTintColor = UIColor.clear
//            rootViewController.edgesForExtendedLayout = UIRectEdge()
//            if rootViewController.view.backgroundColor == nil {
//                rootViewController.view.backgroundColor = .white
//            }
//            rootViewController.view.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
//
//            let vImage = UIView()
//            self.view.insertSubview(vImage, belowSubview: self.view.subviews[0])
//            vImage.snp.makeConstraints({
//                $0.top.centerX.width.equalToSuperview()
//                $0.height.equalTo(vImage.snp.width).multipliedBy(0.85)
//            })
//            let icon = UIImageView(image: UIImage(named: "im_login_back")?.withRenderingMode(.alwaysTemplate))
//            vImage.addSubview(icon)
//            icon.snp.makeConstraints({
//                $0.centerX.equalToSuperview()
//                $0.width.equalToSuperview().multipliedBy(1.2)
//                $0.height.equalTo(icon.snp.width)
//                $0.bottom.equalToSuperview()
//            })
//            icon.contentMode = .scaleAspectFit
//            icon.tintColor = UIColor(hex: "AA122C")
//            icon.backgroundColor = UIColor(hex: "A00A23")
//
//        } else {
//            self.navigationBar.isHidden = true
//            self.navigationBar.isTranslucent = false
//            self.navigationBar.barTintColor = AppColors.gradientMid
//        }
//
////        if rootViewController is BaseViewController {
//            let leftBarStyle = (rootViewController as? BaseViewController)?.backStyle ?? .back
////            self.rootBackStyle = leftBarStyle
//            let backItem = addBackButton(into: rootViewController, tag: TAG_FIRST, backStyle: leftBarStyle)
//            if rootViewController is StockMainTabViewController || rootViewController is FinanceDashboardViewController || rootViewController is AssetOverviewViewController {
//                backItem?.clickable.gestureRecognizers?.removeAll()
//                backItem?.clickable.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.actGoHome)))
//            }
////        }
//    }
//
//    func changeBackAction(gesture: UITapGestureRecognizer) {
//        self.backCustomAction = gesture
//    }
//
//    @objc private func actGoHome() {
////        AppDelegate.current()?.mainTabbar?.selectedIndex = 0
//    }
//
//    @objc private func close(_ gesture: UITapGestureRecognizer) {
//        if let tag = gesture.view?.tag {
//            if tag == TAG_SECOND {
//                self.popViewController(animated: true)
//                return
//            }
//        }
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    override init(rootViewController: UIViewController) {
//        super.init(rootViewController: rootViewController)
//    }
//
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    //Cần set tag == TAG_FIRST || TAG_SECOND. Xem tại self.close()
//    private func addBackButton(into rootView: UIViewController, tag: Int, backStyle: BackNaviButton.LeftBarStyle) -> (BackNaviButton?) {
//        if backStyle == .custom {
//            return nil
//        }
//        if rootView.navigationItem.leftBarButtonItem is BackNaviButton {
//            return nil
//        }
//        if let items = rootView.navigationItem.leftBarButtonItems {
//            if (items.contains(where: {$0 is BackNaviButton})) {
//                return nil
//            }
//        }
//        rootView.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let backButton = BackNaviButton(backStyle: backStyle)
//        backButton.clickable.tag = tag
//        if backStyle != .noneIcon {
//            if backCustomAction == nil {
//                backButton.clickable.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.close(_:))))
//            } else {
//                backButton.clickable.addGestureRecognizer(backCustomAction!)
//            }
//        }
//        var minX = self.view.frame.width - 16 - 8 - 16
//        for item in (rootView.navigationItem.leftBarButtonItems ?? []) {
//            minX -= (item.width + 12)
//        }
//        for item in (rootView.navigationController?.navigationBar.subviews ?? []) {
//            if item is UIButton {
//                if !item.isHidden {
//                    minX -= 30
//                }
//                continue
//            }
//
//            if item.tag == StockBaseViewController.stockAccountTag {
//                if !item.isHidden {
//                    minX -= 84
//                }
//                continue
//            }
//        }
//        for item in (rootView.navigationItem.rightBarButtonItems ?? []) {
//            if item.customView is UIButton {
//                minX -= 30
//                continue
//            }
//
//            if item.customView != nil {
//                minX -= 30
//                continue
//            }
//        }
//        if rootView.navigationItem.leftBarButtonItem == nil {
//            rootView.navigationItem.leftBarButtonItem = backButton
//        } else if rootView.navigationItem.leftBarButtonItems == nil {
//            rootView.navigationItem.leftBarButtonItems = []
//            rootView.navigationItem.leftBarButtonItems?.append(backButton)
//        } else {
//            rootView.navigationItem.leftBarButtonItems?.append(backButton)
//        }
//        backButton.customView?.snp.makeConstraints({
//            $0.width.lessThanOrEqualTo(minX - 16)
//        })
//        backButton.title = rootView.title ?? rootView.navigationItem.title ?? ""
//        return backButton
//    }
//}
//
//extension CustomNavigationController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//
//        if showImgBack && !self.navigationBar.isHidden {
//            viewController.edgesForExtendedLayout = UIRectEdge()
//            if viewController.view.backgroundColor == nil {
//                viewController.view.backgroundColor = .white
//            }
//            viewController.view.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 20)
//        } else {
//            viewController.view.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: 0)
//        }
//        if viewController != self.viewControllers.first && !self.viewControllers.isEmpty {
//            let leftBarStyle = (viewController as? BaseViewController)?.backStyle ?? .back
//            addBackButton(into: viewController, tag: TAG_SECOND, backStyle: leftBarStyle)
//            return
//        }
//        if let items = viewController.navigationItem.leftBarButtonItems {
//            for item in items {
//                if item is BackNaviButton {
//                    (item as? BackNaviButton)?.title = viewController.title ?? viewController.navigationItem.title ?? ""
//                }
//            }
//        }
//    }
//
//}
