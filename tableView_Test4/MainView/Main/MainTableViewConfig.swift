//
//  MainTableViewConfig.swift
//  tableView_Test4
//
//  Created by LeeX on 10/18/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

protocol MainTableViewConfig {
    func setup(_ tableView: UITableView,
               withDataSourceDelegate dataSource: UITableViewDelegate & UITableViewDataSource,
               withSeparator separatorStyle: UITableViewCell.SeparatorStyle,
               withBgColor bgColor: UIColor)
    var tableRows: Int { get }
    func cellInstance(for tableView: UITableView,
                      at indexPath: IndexPath,
                      withCollectionDataSourceDelegate dataSource: UICollectionViewDataSource & UICollectionViewDelegate) -> UITableViewCell
    func setContentOffset(for cell: UITableViewCell, at indexPath: IndexPath)
}

extension MainViewModel: MainTableViewConfig {
    func setup(_ tableView: UITableView,
               withDataSourceDelegate dataSource: UITableViewDelegate & UITableViewDataSource,
               withSeparator separatorStyle: UITableViewCell.SeparatorStyle = .none,
               withBgColor bgColor: UIColor = .lightGray)
    {
        self.tableView = tableView
        self.tableView.register(MainViewModel.Cell.forTable.nib,
                                forCellReuseIdentifier: MainViewModel.Cell.forTable.id)
        self.tableView.dataSource = dataSource
        self.tableView.delegate = dataSource
        self.tableView.separatorStyle = separatorStyle
        self.tableView.backgroundColor = bgColor
    }
    
    var tableRows: Int {
        return handler.dataCount
    }
    
    func cellInstance(for tableView: UITableView,
                      at indexPath: IndexPath,
                      withCollectionDataSourceDelegate dataSource: UICollectionViewDataSource & UICollectionViewDelegate) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainViewModel.Cell.forTable.id, for: indexPath) as! MainCell
        cell.lblTitle.text = "Row \(indexPath.row)"
        cell.isSelecting = handler.isSelected(at: indexPath.row)
        cell.setCollectionDataSourceDelegate(dataSourceDelegate: dataSource, withIndex: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    func setContentOffset(for cell: UITableViewCell, at indexPath: IndexPath) {
        guard let cell = cell as? MainCell else { return }
        cell.setCollectionViewContentOffset(handler.contentOffset(at: indexPath.row))
    }
}

extension MainViewModel: MainCellDelegte {
    func didSelectCell(_ cell: MainCell) {
        handler.didSelect(cell, in: self.tableView)
    }
}
