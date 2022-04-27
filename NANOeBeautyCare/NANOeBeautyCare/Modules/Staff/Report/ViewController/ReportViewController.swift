//
//  ReportViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 6/8/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import WebKit

class ReportViewController: BaseViewController<ReportPresenter> {
    // MARK: - IBOutlet
    
    @IBOutlet weak var webView: WKWebView!

    override func loadView() {
        super.loadView()
    }
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = ReportPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "Navigation.Report".localized
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        //        self.navigationItem.title = "Navigation.Report".localized
        self.presenter?.initDataPresent()
//        Loading.startAnimation()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        if let urlData = URL(string: Common.urlReport) {
            webView.load(URLRequest(url: urlData))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewReport) {
        
    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension ReportViewController: ReportVC {
    func initData(data: ViewReport) {
    }
    
    func reloadData() {
    }
}



extension ReportViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loading.stopAnimation()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Loading.stopAnimation()
    }
}
