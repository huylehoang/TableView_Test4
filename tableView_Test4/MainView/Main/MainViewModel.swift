//
//  MainViewModel.swift
//  tableView_Test4
//
//  Created by LeeX on 10/14/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

protocol MainHandler {
    var dataCount: Int { get }
    func subItemCount(at index: Int) -> Int
    func contentOffset(at index: Int) -> CGPoint
    func setContentOffset(_ x: CGFloat, at index: Int)
    func isSelected(at index: Int) -> Bool
    func didSelect(_ cell: MainCell, in tableView: UITableView!)
}

class MainViewModel {
    
    lazy var handler: MainHandler = {
        return MainViewModelHandler()
    }()
    var tableView: UITableView!
    
    init() {
        setupFakeData()
    }
    
    private func setupFakeData() {
        for _ in 0...15 {
            (handler as! MainViewModelHandler).appendNew(CellModel())
        }
    }
    
}

private class MainViewModelHandler: MainHandler {
    
    private var data: [CellModel] = [CellModel]()
    
    private var selectingIndex: Int? {
        get {
            return data
                .enumerated()
                .filter({$0.element.isSelected})
                .map({$0.offset})
                .first
        }
    }
    
    var dataCount: Int {
        get {
            return data.count
        }
    }
    
    func appendNew(_ cellModel: CellModel) {
        data.append(cellModel)
        if data.count == 1 {
            self.toggle(at: 0)
        }
    }
    
    private func valid(_ index: Int) -> Bool {
        return index > -1 && index < data.count
    }

    
    func subItemCount(at index: Int) -> Int {
        guard valid(index) else { return 0 }
        return data[index].subItemCount
    }
    
    func contentOffset(at index: Int) -> CGPoint {
        guard valid(index) else { return CGPoint.zero }
        return data[index].contentOffset
    }
    
    func setContentOffset(_ x: CGFloat, at index: Int) {
        guard valid(index) else { return }
        data[index].setContentOffset(x: x)
    }
    
    func isSelected(at index: Int) -> Bool {
        guard valid(index) else { return false }
        return data[index].isSelected
    }
    
    private func toggle(at index: Int) {
        guard valid(index) else { return }
        data[index].toggleSelect()
    }
    
    private func canSelect(at index: Int) -> Bool {
        guard valid(index) else { return false }
        return !isSelected(at: index)
    }
     
    func didSelect(_ cell: MainCell, in tableView: UITableView!) {
        guard tableView != nil
            , let newSelectIndex = tableView.indexPath(for: cell)
            , canSelect(at: newSelectIndex.row)
            else { return }
        if let currentSelectingIndex = selectingIndex {
            toggle(at: currentSelectingIndex)
            tableView.reloadRows(at: [IndexPath(row: currentSelectingIndex, section: newSelectIndex.section)],
                                 with: .none)
        }
        toggle(at: newSelectIndex.row)
        tableView.reloadRows(at: [newSelectIndex], with: .none)
    }
}

