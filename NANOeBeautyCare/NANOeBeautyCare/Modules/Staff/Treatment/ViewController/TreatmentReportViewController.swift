//
//  TreatmentReportViewController.swift
//  NANOeBeautyCare
//
//  Created by Dom on 11/9/20
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import UIKit
import WebKit

class TreatmentReportViewController: BaseViewController<TreatmentReportPresenter> {
    // MARK: - IBOutlet
    
    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
    }
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = TreatmentReportPresenter()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Navigation.Report".localized
        self.backButtonNavigation()
        
        self.presenter?.initDataPresent()
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Update Data IBOutlet
    func updateData(data: ViewTreatmentReport) {
        
    }
    
    // MARK: - Action Button
    
}

// MARK: - Protocol of Presenter
extension TreatmentReportViewController: TreatmentReportVC {
    func initUrlString(url: String, isCustomer: Bool) {
        if isCustomer == true {
            if url.isValidURL == true {
                Loading.startAnimation()
                if let urlData = URL(string: url) {
                    webView.load(URLRequest(url: urlData))
                }
            } else {
                Loading.stopAnimation()
            }
        } else {
            if let urlData = URL(string: Common.stringToUrlReport(text:url)) {
                Loading.startAnimation()
                webView.load(URLRequest(url: urlData))
            } else {
                Loading.stopAnimation()
            }
        }
    }
    
    func initData(data: DetailTreatmentOptionalResponse) {
        if let urlData = URL(string: Common.stringToUrlReport(text:data.urlProcessResult ?? "")) {
            webView.load(URLRequest(url: urlData))
        }
    }
    
    func reloadData() {
    }
}



extension TreatmentReportViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Loading.stopAnimation()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Loading.stopAnimation()
    }
}
