//
//  MainComponents.swift
//  tableView_Test4
//
//  Created by LeeX on 10/18/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

extension MainViewModel {
    enum Cell {
        case forCollection, forTable
    }
    
    static var cellHeight: CGFloat {
        get {
            return 106
        }
    }
    
    static var flowLayout: UICollectionViewFlowLayout {
        get {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - UIScreen.main.bounds.width/4 - 48,
                                     height: MainViewModel.cellHeight - 16)
            layout.minimumInteritemSpacing = 8
            layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
            return layout
        }
    }
}

extension MainViewModel.Cell {
    var id: String {
        switch self {
        case .forTable:  return "MainCell"
        case .forCollection:return "ItemCell"
        }
    }
    
    var nib: UINib {
        return UINib(nibName: self.id, bundle: nil)
    }
}
