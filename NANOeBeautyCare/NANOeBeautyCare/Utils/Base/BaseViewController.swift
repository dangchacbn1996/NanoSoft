//
//  BaseViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 5/31/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import DropDown

let keySaveDomain = "ListsDomain"
let kPushNotification = "kPushNotification"
class BaseViewController<P>: UIViewController, RoutableScreen {
    let service = BaseService()
    var context: RouteContext?
    var presenter: P?
    var router: Router {
        return Router(viewController: self)
    }
    func updatePanData(context: RouteContext) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
        initPresenter(with: context)
        self.hideKeyboardWhenTappedAround()
        updateShowHideTabbar()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateRouterPush), name: Notification.Name(kPushNotification), object: nil)
    }
    
    @objc func updateRouterPush(_ notification: NSNotification) {
        if let model = notification.userInfo?[kPushNotification] as? PushNotificationModel {
            if let typeString = model.type {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    if typeString == kPushNotificationAppointment {
                        self.tabBarController?.selectedIndex = 1
                        
                    } else if typeString == kPushNotificationTreatment {
                        
                        self.tabBarController?.selectedIndex = 3
                    } else if typeString == kPushNotificationNews {
                        self.openChildScreen(.CustomerHomeNewsFilterViewController, fromStoryboard: .CustomerHome)
                    } else if typeString == kPushNotificationOther {
                        self.tabBarController?.selectedIndex = 4
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) { // As soon as vc appears
        super.viewWillAppear(true)
        updateShowHideTabbar()
    }
    
    override func viewWillDisappear(_ animated: Bool) { // As soon as vc disappears
        super.viewWillDisappear(true)
        updateShowHideTabbar()
    }
    
    func updateShowHideTabbar() {
        if let dat = UIApplication.topViewController() {
            if (dat.isKind(of: HomeViewController.self)) ||
                (dat.isKind(of: AppointmentViewController.self)) ||
                (dat.isKind(of: SalesViewController.self)) ||
                (dat.isKind(of: TreatmentViewController.self)) ||
                (dat.isKind(of: ReportViewController.self)) ||
                (dat.isKind(of: CustomerHomeViewController.self)) ||
                (dat.isKind(of: CustomerAppointmentViewController.self)) ||
                (dat.isKind(of: CustomerSocialViewController.self)) ||
                (dat.isKind(of: CustomerTreatmentViewController.self)) ||
                (dat.isKind(of: MoreWebViewViewController.self)) ||
                (dat.isKind(of: HospitalMainViewController.self)) ||
//                (dat.isKind(of: CreateAppointmentViewController.self)) ||
                (dat.isKind(of: CustomerProfileViewController.self))
//                (dat.isKind(of: HospitalNotificationMainViewController.self))
            {
                self.tabBarController?.tabBar.isHidden = false
            } else {
                self.tabBarController?.tabBar.isHidden = true
            }
        }
    }
    
    func initPresenter(with context: RouteContext?) {
        fatalError("Subclasses must implement initPresenter()")
    }
    
    func setupStyle() {
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func configNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = AppColors.gradientMid
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    
    func backButtonNavigation() {
        self.navigationController?.navigationItem.leftBarButtonItem = UIBarButtonItem.button(image: UIImage(named: "ic-back")!, title: "", target: self, action: #selector(self.callAction))
    }
    
    func backButtonTitleNavigation(title: String) {
        let first = UIBarButtonItem.button(image: UIImage(named: "ic-back")!, title: "", target: self, action: #selector(self.callAction))
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .boldSystemFont(ofSize: 17.0)
        label.text = title
        let secornd = UIBarButtonItem(customView: label)
        self.navigationItem.leftBarButtonItems = [first, secornd]
    }
    
    func rightButtonNavigation(isFiltterItem:Bool, actionFiltter: Selector,actionSearch: Selector) {
        let filtterItem = UIBarButtonItem.button(image: UIImage(named: "ic-filter")!, title: "", target: self, action: actionFiltter)
        let searchItem = UIBarButtonItem.button(image: UIImage(named: "ic-search")!, title: "", target: self, action: actionSearch)
        let moreItem = UIBarButtonItem.button(image: UIImage(named: "ic-more")!, title: "", target: self, action: #selector(self.dropdownMenu))
        if isFiltterItem == true {
            self.navigationItem.rightBarButtonItems = [moreItem,searchItem, filtterItem]
        } else {
            self.navigationItem.rightBarButtonItems = [searchItem]
        }
    }
    
    func alertGuest() {
        self.alertTwoActionButton(cancelAction: "Đăng ký", description: "Bạn cần đăng nhập để sử dụng tính năng này", titleAction: "Đăng nhập") {
            guard let rootVC = UIStoryboard.init(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
                return
            }
            
            let navigationController = UINavigationController(rootViewController: rootVC)
            
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } actionCancel: {
            self.openChildScreen(.CustomerSignUpViewController, fromStoryboard: .CustomerHome)
            
        }
    }
    
    func rightMoreButtonNavigation() {
        let moreItem = UIBarButtonItem.button(image: UIImage(named: "ic-more")!, title: "", target: self, action: #selector(self.dropdownMenu))
        self.navigationItem.rightBarButtonItems = [moreItem]
    }
    
    @objc func callAction() {
        //        Utils.makeCallPhoneNumbers(phone: BaseShareDataModel.shared.rawCommon?.data?.information?.hotline ?? "")
        self.backToPrevScreen()
    }
    
    @objc
    func dropdownMenu() {
        let logoutAction = ContextMenuAction(title: "Common.SignOut".localize(),
                                             image: UIImage(named: "ic-logout"),
                                             tintColor: AppColors.dangerColor,
                                             action: { _ in
                                                self.alertTwoButton(description: "Bạn chắc chắn muốn đăng xuất không?", titleAction: "Đăng xuất") {
                                                    self.logoutAction()
                                                }
                                             })
        let actions = [logoutAction]
        let contextMenu = ContextMenu(title: "Common.QuickSupport".localized, actions: actions)
        self.navigationItem.rightBarButtonItem?.plainView.addContextMenu(contextMenu, for: .tap(numberOfTaps: 1))
        
        //        let actionSheet = MyActionSheet(cancelButtonTitle: "Filter.Cancel".localize())
        //
        //        let title =  MyActionSheetItem(title: "Common.QuickSupport".localized)
        //        title.font = UIFont.boldSystemFont(ofSize: 24.0)
        //        title.titleColor = UIColor(hex: "00791F")
        //        actionSheet.add(title)
        //        actionSheet.add(MyActionSheetItem(title: "Common.SignOut".localize(), handler: { _ in
        //
        //        }))
        //        actionSheet.show()
    }
    
    func dropdownView(anchorView:AnchorView, dataSource: [String], selectionAction: @escaping (Index, String) -> Void) {
        let dropDown = DropDown()
        // The view to which the drop down will appear on
        dropDown.anchorView = anchorView
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = dataSource
        dropDown.selectionAction = selectionAction
        dropDown.show()
    }
    
    @objc func logoutAction() {
        service.logoutMoreService(requestData: MoreWebViewRequest(), callBack: { (response, status, code) in
            self.service.handleObjectStatus(modelOptionalResponse: MoreWebViewOptionalResponse.self, response: response, status, code, successBlock: { (repo) in
                //                    self.viewController?.alertVC(title: repo.msg ?? "")
            }) { (repo) in
                
            }
        })
        UserDefaults.standard.removeObject(forKey: "SignInRequest")
        UserDefaults.standard.removeObject(forKey: "CustomerProfileOptionalResponse")
        UserDefaults.standard.removeObject(forKey: "SignInResponseDataClass")
        guard let rootVC = UIStoryboard.init(name: "SignIn", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else {
            return
        }
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func makeSearchBar(delegate: UISearchBarDelegate) {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItems = nil
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.delegate = delegate
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.tintColor = .black
            searchBar.searchTextField.becomeFirstResponder()
        } else {
            // Fallback on earlier versions
            for view : UIView in (searchBar.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    textField.backgroundColor = .white
                    textField.tintColor = .black
                    textField.becomeFirstResponder()
                }
            }
        }
        self.navigationItem.titleView = searchBar
    }
}

// MARK: - Alert
extension BaseViewController {
    func alertOneButton(description:String) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: description.localized, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "Common.OK".localized, style: .default, action: { () -> Void in
            print("Cancel")
        }))
        alertVC.modalPresentationStyle = .overFullScreen
        tabBarController?.tabBar.isUserInteractionEnabled = false
        self.present(alertVC, animated: true, completion: nil)
    }
    func alertOneActionButton(title:String, description:String,action: @escaping (() -> Void)) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: description.localized, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: title, style: .default, action: action))
        alertVC.modalPresentationStyle = .overFullScreen
        tabBarController?.tabBar.isUserInteractionEnabled = false
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func alertTwoButton(description:String,titleAction: String,action: @escaping (() -> Void)) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: description, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: "\(CommonString)Back".localized, style: .cancel, action: { () -> Void in
            print("Cancel")
            self.tabBarController?.tabBar.isUserInteractionEnabled = true
        }))
        alertVC.addAction(PMAlertAction(title: titleAction.localized, style: .default, action: action))
        alertVC.modalPresentationStyle = .overFullScreen
        tabBarController?.tabBar.isUserInteractionEnabled = false
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func alertTwoActionButton(cancelAction: String,description:String,titleAction: String,action: @escaping (() -> Void), actionCancel:@escaping (() -> Void)) {
        let alertVC = PMAlertController(title: "\(CommonString)Alert".localized, description: description, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: cancelAction, style: .cancel, action: actionCancel))
        alertVC.addAction(PMAlertAction(title: titleAction.localized, style: .default, action: action))
        alertVC.modalPresentationStyle = .overFullScreen
        tabBarController?.tabBar.isUserInteractionEnabled = false
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func alertFullButton(title: String, cancelAction: String,description:String,titleAction: String,action: @escaping (() -> Void), actionCancel:@escaping (() -> Void)) {
        let alertVC = PMAlertController(title: title, description: description, image: nil, style: .alert)
        
        alertVC.addAction(PMAlertAction(title: cancelAction, style: .cancel, action: actionCancel))
        alertVC.addAction(PMAlertAction(title: titleAction.localized, style: .default, action: action))
        alertVC.modalPresentationStyle = .overFullScreen
        tabBarController?.tabBar.isUserInteractionEnabled = false
        self.present(alertVC, animated: true, completion: nil)
    }
    func goRoot() {
        Loading.stopAnimation()
        let rootVC = UIStoryboard(name:"SignIn", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        //            let rootVC = UIStoryboard(name:"Splash", bundle: nil).instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        let navi = UINavigationController(rootViewController: rootVC)
        UIApplication.shared.keyWindow?.rootViewController = navi
    }
}
extension UIBarButtonItem {
    static func button(title: String, titleColor: UIColor,target: Any, action: Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: UIControl.State.normal)
        // button.sizeToFit()
        return UIBarButtonItem(customView: button)
    }
    static func button(image: UIImage, title: String, target: Any, action: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24.auto()).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24.auto()).isActive = true
        
        return menuBarItem
        //
        //        let button = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 40.0.auto(), height: 40.0.auto()))
        //        button.setImage(image, for: .normal)
        //        button.contentHorizontalAlignment = .center
        //        button.addTarget(target, action: action, for: .touchUpInside)
        //        button.setTitle(title, for: .normal)
        //        //        button.sizeToFit()
        //        return UIBarButtonItem(customView: button)
    }
}

extension BaseViewController: BaseView {
    func backToPrevToVC(with vc: UIViewController.Type, context: RouteContext? = nil) {
        Router(viewController: self).backToPrevToVC(with: vc, context: context)
    }
    func openViewController(_ nextViewController: UIViewController, isChildScreen: Bool, withContext context: RouteContext?) {
        Router(viewController: self).openViewController(nextViewController, isChildScreen: isChildScreen, withContext: context)
    }
    
    func panScreen(_ screen: Screen,
                   fromStoryboard storyboard: Storyboard,
                   withContext context: RouteContext? = nil) {
        Router(viewController: self).panScren(screen, fromStoryboard: storyboard, withContext: context)
    }
    
    func setRootScreen(_ screen: Screen,
                       isUseRootNavigation: Bool,
                       fromStoryboard storyboard: Storyboard,
                       withContext context: RouteContext? = nil) {
        Router(viewController: self)
            .setRootScreen(screen, isUseRootNavigation: isUseRootNavigation, fromStoryboard: storyboard, withContext: context)
    }
    
    func setRootScreen(_ viewController: UIViewController,
                       isUseRootNavigation: Bool,
                       withContext context: RouteContext? = nil) {
        Router(viewController: self)
            .setRootScreen(viewController, isUseRootNavigation: isUseRootNavigation, withContext: context)
    }
    
    func openScreen(_ screen: Screen,
                    fromStoryboard storyboard: Storyboard,
                    withContext context: RouteContext? = nil) {
        Router(viewController: self).openScreen(screen, fromStoryboard: storyboard, isChildScreen: false, withContext: context)
    }
    
    func openScreen(_ screen: UIViewController,
                    withContext context: RouteContext? = nil) {
        Router(viewController: self).openScreen(screen, isChildScreen: false, withContext: context)
    }
    
    func openChildScreen(_ screen: Screen,
                         fromStoryboard storyboard: Storyboard,
                         withContext context: RouteContext? = RouteContext([:])) {
        Router(viewController: self)
            .openScreen(screen, fromStoryboard: storyboard, isChildScreen: true, withContext: context)
    }
    
    func openChildScreen(_ screen: UIViewController,
                         withContext context: RouteContext? = RouteContext([:])) {
        Router(viewController: self)
            .openScreen(screen, isChildScreen: true, withContext: context)
    }
    
    func backToPrevScreen(with context: RouteContext? = nil) {
        Router(viewController: self).backToPrevScreen(with: context)
    }
    
    func panDismissScreen(with context: RouteContext? = nil) {
        Router(viewController: self).panDismissScreen(with: context)
    }
    
    func setIconLeftNavigation(with context: RouteContext? = nil) {
        Router(viewController: self).setIconLeftNavigation()
    }
    
    func setIconRightNavigation(with listButton: [UIBarButtonItem]? = []) {
        Router(viewController: self).setIconRightNavigation(listButton: listButton ?? [])
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
