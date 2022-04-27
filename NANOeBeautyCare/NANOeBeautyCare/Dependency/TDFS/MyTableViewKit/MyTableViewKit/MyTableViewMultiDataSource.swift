//
//  MyTableViewMultiDataSource.swift
//  NANOeBeautyCare
//
//  Created by Dom on 8/7/20.
//  Copyright © 2020 ToDu ForSharing Company Limited. All rights reserved.
//

import Foundation

import UIKit
//
///// DataSource
//public typealias MultiDataSource<K,T> = [K:[T]]
//
///// FilteredDataSource
//public typealias FilteredMultiDataSource<K,T> = [K:[T]]
//
///// SearchHandler
//public typealias MultiSearchResultHandler<K,T> = ((String, MultiDataSource<K,T>) -> ())
//
///// MyTableViewDataSource
//open class MyTableViewMultiDataSource<K,T>: NSObject, UITableViewDataSource {
//
//    // MARK: - Properties
//
//    /// data source for tableview
//    var dataSource: MultiDataSource<K,T> = [:] {
//        didSet {
//            filteredDataSource = dataSource
//        }
//    }
//
//    /// filtered data source for tableView
//    var filteredDataSource: FilteredMultiDataSource<K,T> = [:]
//
//    // MARK: - Public
//
//    /// get datasource array
//    public var array: FilteredMultiDataSource<K,T> {
//        return Array(arrayLiteral: self.filteredDataSource) as! FilteredMultiDataSource
//    }
//
//    /// Search Result Handler
//    public var searchResultHandler: MultiSearchResultHandler<K,T>?
//
//    /// get datasource count
//    public var count: Int {
//        return filteredDataSource.count
//    }
//
//    // MARK: - Private
//
//    /// datasource update delegate
//    private weak var dataSourceUpdateDelegate: MyTableViewDataSourceUpdate?
//
//    /// cell configuration - (cell, dataObject, indexPath)
//    private var cellConfiguration: UITableViewCellConfiguration<T>?
//
//    /// cell identifier
//    private var cellIdentifier: String!
//
//    /// tableview for datasource
//    private weak var tableView: MyTableView?
//
//
//    // MARK: - Initialize
//
//    public init(tableView: MyTableView, identifier: String, cellConfiguration: @escaping UITableViewCellConfiguration<T>) {
//        super.init()
//
//        tableView.dataSource = self
//        tableView.tableViewDataSourceDelegate = self
//        dataSourceUpdateDelegate = tableView
//
//        self.tableView = tableView
//        self.cellIdentifier = identifier
//        self.cellConfiguration = cellConfiguration
//    }
//
//    // MARK: - UITableViewDataSource
//
//    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.filteredDataSource.count
//    }
//
//    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        // deque tableview cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
//
//        // cell configuration
//        if let config = cellConfiguration {
//
//            let dataObject = self.objectAt(indexPath: indexPath)
//            config(cell, dataObject, indexPath)
//        }
//        return cell
//    }
//}
//
//// MARK: - Public
//extension MyTableViewMultiDataSource {
//
//    /// returns the object present in dataSourceArray at specified indexPath
//    public func objectAt(indexPath: IndexPath) -> T {
//        return self.filteredDataSource[indexPath.row]
//    }
//
//    /// sets data in datasource
//    public func setData(data: MultiDataSource<T>) {
//        self.dataSource = data
//        self.dataSourceUpdateDelegate?.didSetDataSource(count: data.count)
//    }
//
//    /// append data in datasource
//    public func appendData(data: MultiDataSource<T>) {
//
//        let startIndex = self.dataSource.count
//        self.dataSource.append(contentsOf: data)
//        self.dataSourceUpdateDelegate?.didAddedToDataSource(start: startIndex, withTotalCount: data.count)
//    }
//
//    /// insert data at top
//    public func prependData(data: MultiDataSource<T>) {
//        for i in 0..<data.count {
//            self.dataSource.insert(data[i], at: i)
//        }
//        self.dataSourceUpdateDelegate?.didAddedToDataSource(start: 0, withTotalCount: data.count)
//    }
//
//    /// update data at index
//    public func updateData(_ data: T, atIndex index: Int) {
//        self.dataSource[index] = data
//        self.dataSourceUpdateDelegate?.didUpdatedDataSourceAt(index: index)
//    }
//
//    /// delete data at index
//    public func deleteData(_ data: T, atIndex index: Int) {
//        self.dataSource.remove(at: index)
//        self.dataSourceUpdateDelegate?.didDeletedDataDataSourceAt(index: index)
//    }
//
//    /// set search result data
//    public func setSearchResultData(_ data: MultiDataSource<T>, replace: Bool = false) {
//        if replace {
//            self.dataSource = data
//        }else {
//            self.filteredDataSource = data
//        }
//        self.dataSourceUpdateDelegate?.didSetSearchResultData(count: data.count, replace: replace)
//    }
//
//    /// clear all data
//    public func clearData(showEmptyState: Bool = false) {
//        self.dataSource = []
//        self.dataSourceUpdateDelegate?.didRemovedData(showEmptyState: showEmptyState)
//    }
//}
//
//// MARK:- MyTableviewDataSourceDelegate
//extension MyTableViewMultiDataSource: MyTableviewDataSourceDelegate {
//
//    /// Update search
//    func updateSearch(_ searchText: String) {
//        if let handler = searchResultHandler {
//            handler(searchText, self.dataSource)
//        }gẻn
//    }
//
//    /// To get datasource array count
//    func getCount() -> Int {
//        return count
//    }
//}
