//
//  HospitalNotificationMainViewController.swift
//  NANOeBeautyCare
//
//  Created by Ngo Dang Chac on 02/08/2021.
//  Copyright © 2021 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation
import UIKit

class HospitalNotificationMainViewController: BaseViewController<HospitalNotificationPresent> {
    private let tableView = UITableView()
    private let btnReadAll = UIButton()
    private let services = HospitalService()
    private var listData: [HospitalNotifiItem] = []
    private let pageSize = 20
    private var pages = 1
    private let lbNotify = UILabel(text: "", font: UIFont.customOpenSans(12), color: .white)
    
    // MARK: - Connect Presenter
    override func initPresenter(with context: RouteContext?) {
        presenter = HospitalNotificationPresent()
        presenter?.attachView(vc: self)
        presenter?.setContext(to: context)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Thông báo"
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HospitalNotifiTableCell.self, forCellReuseIdentifier: HospitalNotifiTableCell.id)
        tableView.separatorStyle = .none
        
//        let btnDoneAll = UIButton(image: UIImage(named: "ic_done_all")?.withInset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)), style: .done, target: self, action: #selector(self.actDoneAll))
//        btnDoneAll.tintColor = .white
        let btnDoneAll = UIButton()
        btnDoneAll.setImage(UIImage(named: "ic_done_all")?.withInset(UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)), for: .normal)
        btnDoneAll.addSubview(lbNotify)
        btnDoneAll.imageView?.contentMode = .scaleAspectFit
        lbNotify.backgroundColor = AppColors.viewRed
        lbNotify.snp.makeConstraints({
            $0.trailing.top.equalToSuperview()
            $0.height.equalTo(12)
        })
        lbNotify.layer.cornerRadius = 6
        lbNotify.clipsToBounds = true
        if SessionManager.shared.countNoti > 0 {
            lbNotify.text = " \(SessionManager.shared.countNoti) "
        }
        let rightItem = UIBarButtonItem(customView: btnDoneAll)
        
        self.navigationItem.rightBarButtonItem = rightItem
        NotificationCenter.default.addObserver(self, selector: #selector(self.notiChangeCount), name: Notification.Name(NotificationKey.notiCountChange.rawValue), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func notiChangeCount() {
        lbNotify.text = " \(SessionManager.shared.countNoti) "
    }
    
    @objc
    private func actDoneAll() {
        services.hospitalNotiReadPage(requestData: HospitalService.HosNotiReadPage(SoDienThoai: SessionManager.shared.soDienThoai, IsView: true, page_num: pages, page_size: listData.count)) { response, value, code in
            if (response as? ResponseGetMS)?.code == 1 {
                self.listData.forEach({$0.IsView = true})
                self.tableView.reloadData()
            }
        }
    }
    
    private func loadData() {
        services.hospitalNotiList(requestData: HospitalService.HosNotiListRequest(SoDienThoai: SessionManager.shared.soDienThoai, page_num: pages, page_size: pageSize) ) { response, statusMess, statusCode in
            if let list = ((response as? ModelBaseOptionalResponseService<[HospitalNotifiItem]>)?.data) {
                self.listData.append(contentsOf: list)
                self.tableView.reloadData()
            }
        }
    }
}

extension HospitalNotificationMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HospitalNotifiTableCell.id, for: indexPath) as! HospitalNotifiTableCell
        cell.selectionStyle = .none
        cell.bind(listData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var item = listData[indexPath.row]
//        if !(listData[indexPath.row].IsView ?? false) {
            HospitalService().hospitalNotiReadNoti(id: listData[indexPath.row].NotificationID ?? 0)
//        }
        item.IsView = true
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
        if item.data_type == "answer" {
            let vcSocial = UIStoryboard(name: "CustomerHome", bundle: nil).instantiateViewController(withIdentifier: "CustomerSocialViewController") as! CustomerSocialViewController
            let navSocial = MyNavigationController(rootViewController: vcSocial)
            //        self.navigationController?.pushViewController(vcSocial, animated: true)
            self.present(navSocial, animated: true, completion: nil)
        } else {
            let vc = KhaiBaoYTeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listData.count - 1 {
            pages += 1
            loadData()
        }
    }
}

class HospitalNotifiTableCell: UITableViewCell {
    static let id = "HospitalNotifiTableCell"
    
    private let lbTime = UILabel(text: "02/08/2021", font: UIFont.customOpenSans(14), color: AppColors.textGray)
    private let lbTitle = UILabel(text: "Khai báo thông tin sức khoẻ", font: UIFont.customOpenSans(16, .bold), color: AppColors.textBlack, breakable: true)
    private let lbContent = UILabel(text: "Hôm nay bạn vẫn chưa khai báo thông tin sức khoẻ", font: UIFont.customOpenSans(14), color: AppColors.textBlack, breakable: true)
    private let icRead = UIImageView(image: UIImage(named: "ic_done")?.withRenderingMode(.alwaysTemplate))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ item: HospitalNotifiItem) {
        lbTime.text = item.NgayTao
        lbTitle.text = item.TieuDe
        lbContent.text = item.NoiDung
        icRead.alpha = (item.IsView ?? false) ? 1 : 0
    }
    
    private func setupUI() {
        let vContainer = CardView()
        self.addSubview(vContainer)
        vContainer.snp.makeConstraints({
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().offset(-24)
        })
        vContainer.backgroundColor = .white
        vContainer.cornerradius = 8
//        vContainer.dropShadow()
        vContainer.addSubview(lbTime)
        lbTime.snp.makeConstraints({
            $0.leading.top.equalToSuperview().offset(8)
        })
        
        vContainer.addSubview(lbTitle)
        lbTitle.snp.makeConstraints({
            $0.leading.trailing.equalTo(lbTime)
            $0.top.equalTo(lbTime.snp.bottom).offset(12)
        })
        
        vContainer.addSubview(lbContent)
        lbContent.snp.makeConstraints({
            $0.leading.trailing.equalTo(lbTime)
            $0.top.equalTo(lbTitle.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().offset(-8)
        })
        lbContent.numberOfLines = 2
        
        vContainer.addSubview(icRead)
        icRead.snp.makeConstraints({
            $0.trailing.equalToSuperview().offset(-8)
            $0.top.equalTo(lbTime)
            $0.size.equalTo(28)
            $0.leading.equalTo(lbTime.snp.trailing).offset(8)
        })
        icRead.contentMode = .scaleAspectFit
        icRead.tintColor = AppColors.viewBlue
    }
}

class HospitalNotificationPresent: BasePresenter<BaseView> {
}
