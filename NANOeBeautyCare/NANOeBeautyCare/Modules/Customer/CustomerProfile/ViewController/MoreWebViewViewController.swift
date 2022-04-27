//
//  MoreWebViewViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 10/01/2021
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import WebKit

class MoreWebViewViewController: BaseViewController<MoreWebViewPresenter> {
    // MARK: - IBOutlet
    @IBOutlet weak var signInButton: MyGradientButton!
    @IBOutlet weak var viewGuest: UIView!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var webView: WKWebView!

    override func loadView() {
        super.loadView()
    }
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = MoreWebViewPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Tính năng mở rộng"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        //        self.navigationItem.title = "Navigation.Report".localized
        self.presenter?.initDataPresent()
        if Common.IS_GUEST == true {

        } else {
//            Loading.startAnimation()
            webView.uiDelegate = self
            webView.navigationDelegate = self
            if let urlData = URL(string: Common.stringToUrlExt()) {
                webView.load(URLRequest(url: urlData))
            }
        }
        
        let searchItem = UIBarButtonItem.button(image: UIImage(named: "ic_change_pass")!, title: "", target: self, action: #selector(self.changePasswordAction))
        let moreItem = UIBarButtonItem.button(image: UIImage(named: "ic-logout")!, title: "", target: self, action: #selector(self.logoutAlert))
        
        self.navigationItem.rightBarButtonItems = [moreItem,searchItem]
    }
    
    @objc func changePasswordAction() {
        if Common.IS_GUEST == true {
            self.alertGuest()

        } else {
            self.openChildScreen(.ChangePasswordViewController, fromStoryboard: .CustomerHome)
        }
    }
    
    @objc func logoutAlert() {
        self.alertTwoButton(description: "Bạn chắc chắn muốn đăng xuất không?", titleAction: "Đăng xuất") {
            self.logoutAction()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        self.viewGuest.isHidden = !Common.IS_GUEST
    }
    
    // MARK: - Action Button
    @IBAction func signupButtonAction(_ sender: Any) {
        self.openChildScreen(.CustomerSignUpViewController, fromStoryboard: .CustomerHome)
    }
    
    @IBAction func signinButtonAction(_ sender: Any) {
        self.logoutAction()
    }
}


// MARK: - Protocol of Presenter
extension MoreWebViewViewController: MoreWebViewVC {
    func initData(data: ViewMoreWebView) {
    }
    
    func reloadData() {
    }
}



extension MoreWebViewViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loading.stopAnimation()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Loading.stopAnimation()
    }
}
