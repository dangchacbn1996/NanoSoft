//
//  TableDataSource.swift
//  GenericTableDataSource
//
//  Created by Sandeep Kumar on 13/07/19.
//  Copyright © 2019 SandsHellCreations. All rights reserved.
//

import UIKit
import JXSegmentedView

class TableDataSource<T : HeaderFooterModelProvider, U: CellModelProvider, Z>: NSObject, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    typealias DidSelectedRow = (_ indexPath : IndexPath, _ item: U?) -> Void
    typealias ViewForHeaderFooterInSection = (_ section : Int, _ headerFooterItem: T, _ view: UIView) -> Void
    typealias ListCellConfigureBlock = (_ cell : UITableViewCell , _ item : U?, _ indexpath: IndexPath) -> Void
    typealias DirectionForScroll = (_ direction: ScrollDirection) -> Void
    typealias InfiniteScroll = (_ page: Int) -> Void
    typealias Pulled = () -> Void
    typealias EditActionForRow = (_ indexPath: IndexPath, _ identifier: String, _ editAction: EditAction) -> Void
    
    private var tableView: UITableView?
    private var items = Array<T>()
    private var tableType: TableType<T, U, Z>?
    private var identifier: String?
    private var height: CGFloat?
    private var infiniteLoadingStatus: InfiniteScrollStatus = .FinishLoading
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColors.primaryColor
        return refreshControl
    }()
    private var isReloadingFinished = false
    private var isLoadMoreComplete = false
    private var isNumberOfPage = Int(kDefaultStartPage)
    
    //MARK:- only used for single listing during updating items
    private var leadingSwipe: SKSwipeActionConfig?
    private var trailingSwipe: SKSwipeActionConfig?
    
    
    public var didSelectRow: DidSelectedRow?
    public var configureHeaderFooter: ViewForHeaderFooterInSection?
    public var configureCell: ListCellConfigureBlock?
    public var scrollDirection: DirectionForScroll?
    public var addInfiniteScrolling: InfiniteScroll?
    public var addPullToRefresh: Pulled?
    public var editActionForRow: EditActionForRow?
    
    init(_ _type: TableType<T, U, Z>, _ _tableView: UITableView, _ withPullToRefresh: Bool? = true) {
        super.init()
        tableType = _type
        tableView = _tableView
        switch _type {
        case .SingleListing(let _items, let _identifier, let _height, let _leadingSwipe, let _trailingSwipe):
            identifier = _identifier
            height = _height
            leadingSwipe = _leadingSwipe
            trailingSwipe = _trailingSwipe
            items = DefaultHeaderFooterModel<Z>.getSingleListingItems(array: _items, identifer: _identifier, height: _height) as! [T]
        case .MultipleSection(let _items):
            items = _items
        }
        if withPullToRefresh ?? false {
            tableView?.addSubview(refreshControl)
        }
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.reloadData(success: { [weak self] in
            self?.isReloadingFinished = true
        })
        self.refreshProgrammatically()
    }
    
    public func updateAndReload(for type: UpdateType<T, U, Z>, _ reloadType: ReloadType) {
        isReloadingFinished = false
        switch type {
        case .SingleListing(let _items):
            items = DefaultHeaderFooterModel<Z>.getSingleListingItems(array: _items, identifer: identifier ?? "", height: height ?? 0.0) as! [T]
        case .MultipleSection(let _items):
            items = _items
        }
        reloadTableView(type: reloadType)
    }
    
    public func stopInfiniteLoading(_ status: InfiniteScrollStatus) {
        infiniteLoadingStatus = status
        refreshControl.endRefreshing()
    }
    
    public func refreshProgrammatically() {
        infiniteLoadingStatus = .LoadingContent
        refreshControl.beginRefreshing()
        let offsetPoint = CGPoint.init(x: 0, y: -refreshControl.frame.size.height)
        tableView?.setContentOffset(offsetPoint, animated: true)
        addPullToRefresh?()
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        infiniteLoadingStatus = .LoadingContent
        addPullToRefresh?()
    }
    
    private func reloadTableView(type: ReloadType) {
        switch type {
        case .FullReload:
            self.isLoadMoreComplete = false
            tableView?.reloadData(success: { [weak self] in
                self?.isReloadingFinished = true
            })
        case .Reload(let indexPaths, let animation):
            tableView?.reloadRows(at: indexPaths, with: animation)
            isReloadingFinished = true
        case .ReloadSectionAt(let indexSet, let animation):
            tableView?.reloadSections(indexSet, with: animation)
            isReloadingFinished = true
        case .ReloadSectionTitles:
            tableView?.reloadSectionIndexTitles()
            isReloadingFinished = true
        case .None:
            isReloadingFinished = true
        case .DeleteRowsAt(let indexPaths, let animation):
            tableView?.beginUpdates()
            tableView?.deleteRows(at: indexPaths, with: animation)
            tableView?.endUpdates()
            tableView?.reloadData(success: { [weak self] in
                self?.isReloadingFinished = true
            })
        case .AddRowsAt(let indexPaths, let animation, let moveToLastIndex):
            tableView?.insertRows(at: indexPaths, with: animation)
            if moveToLastIndex {
                tableView?.scrollToRow(at: (indexPaths.last)!, at: .bottom, animated: true)
            }
        case .InsertSection(let indexSet, let animation):
            tableView?.insertSections(indexSet, with: animation)
        case .DeleteSection(let indexSet, let animation):
            tableView?.deleteSections(indexSet, with: animation)
        case .Complete:
            tableView?.reloadData(success: { [weak self] in
                self?.isReloadingFinished = true
                self?.isLoadMoreComplete = true
                self?.isNumberOfPage = Int(kDefaultStartPage)
            })
        }
    }
    
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].items?.count ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let item = items[section]
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.headerProperty?.identifier ?? "") else {
            return nil
        }
        configureHeaderFooter?(section, item, headerView)
        return headerView
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.section].items?[indexPath.row] as? U
        let cell = tableView.dequeueReusableCell(withIdentifier: item?.property?.identifier ?? "", for: indexPath)
        configureCell?(cell, item, indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let item = items[section]
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.footerProperty?.identifier ?? "") else {
            return nil
        }
        configureHeaderFooter?(section, item, footerView)
        return footerView
    }
    
    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return items[section].headerProperty?.height ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return items[section].footerProperty?.height ?? 0
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return items[indexPath.section].items?[indexPath.row].property?.height ?? UITableView.automaticDimension
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.section].items?[indexPath.row] as? U
        didSelectRow?(indexPath, item)
    }
    
    
//    internal func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let leadingConfig = items[indexPath.section].items?[indexPath.row].leadingSwipeConfig
//
//        leadingConfig?.didSelectAction = { [weak self] (identifier) in
//            self?.editActionForRow?(indexPath, identifier, .Leading)
//        }
//
//        return leadingConfig?.getConfig() ?? UISwipeActionsConfiguration(actions: [])
//    }
//
//    internal func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let trailingConfig = items[indexPath.section].items?[indexPath.row].trailingSwipeConfig
//
//        trailingConfig?.didSelectAction = { [weak self] (identifier) in
//            self?.editActionForRow?(indexPath, identifier, .Trailing)
//        }
//
//        return trailingConfig?.getConfig() ?? UISwipeActionsConfiguration(actions: [])
//    }
    
    internal func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        switch velocity {
        case _ where velocity.y < 0:
            // swipes from top to bottom of screen -> down
            scrollDirection?(.Down)
        case _ where velocity.y > 0:
            // swipes from bottom to top of screen -> up
            scrollDirection?(.Up)
        default: break
        }
    }
    
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isReloadingFinished {
            return
        }
        
        if refreshControl.isRefreshing {
            return
        }
        
        switch infiniteLoadingStatus {
        case .LoadingContent, .NoContentAnyMore:
            return
        case .FinishLoading:
            // calculates where the user is in the y-axis
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if offsetY > contentHeight - scrollView.frame.size.height {
                infiniteLoadingStatus = .LoadingContent
                if isLoadMoreComplete == true {

                } else {
                    if self.items.count == 1 {
                        if self.items.first?.items?.count ?? 0 >= Int(kDefaultPageSize) {
                            self.isNumberOfPage += 1
                            addInfiniteScrolling?(self.isNumberOfPage)
                        }
                    } else {
                        var itemCount = 0
                        for item in self.items {
                            let counter = item.items?.count ?? 0
                            itemCount += counter
                        }
                        
                        if itemCount >= Int(kDefaultPageSize) {
                            self.isNumberOfPage += 1
                            addInfiniteScrolling?(self.isNumberOfPage)
                        }
                    }
                }
            }
        }
        
    }
}
