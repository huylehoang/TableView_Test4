//
//  MainCollectionConfig.swift
//  tableView_Test4
//
//  Created by LeeX on 10/18/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

protocol MainCollectionConfig {
    static func setup(_ collectionView: UICollectionView,
                      withAllowsSelection allowsSelection: Bool,
                      withBgColor bgColor: UIColor,
                      withShowsHorinzontalIndicator horizontalIndicator: Bool,
                      withFlowLayout flowLayout: UICollectionViewFlowLayout)
    func subItemCount(atRow row: Int) -> Int
    func cellInstance(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell
    func getContentOffset(of scrollView: UIScrollView)
}

extension MainViewModel: MainCollectionConfig {
    static func setup(_ collectionView: UICollectionView,
                      withAllowsSelection allowsSelection: Bool = false,
                      withBgColor bgColor: UIColor = .clear,
                      withShowsHorinzontalIndicator showHorizontalIndicator: Bool = false,
                      withFlowLayout flowLayout: UICollectionViewFlowLayout = MainViewModel.flowLayout)
    {
        collectionView.register(MainViewModel.Cell.forCollection.nib,
                                forCellWithReuseIdentifier: MainViewModel.Cell.forCollection.id)
        collectionView.allowsSelection = allowsSelection
        collectionView.backgroundColor = bgColor
        collectionView.showsHorizontalScrollIndicator = showHorizontalIndicator
        collectionView.collectionViewLayout = flowLayout
    }
    
    func subItemCount(atRow row: Int) -> Int {
        return handler.subItemCount(at: row)
    }
    
    func cellInstance(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewModel.Cell.forCollection.id, for: indexPath) as! ItemCell
        cell.isFirst = indexPath.row == 0 ? true : false
        cell.isSelecting = handler.isSelected(at: collectionView.tag)
        return cell
    }
    
    func getContentOffset(of scrollView: UIScrollView) {
        guard scrollView is UICollectionView else { return }
        handler.setContentOffset(scrollView.contentOffset.x, at: scrollView.tag)
    }
}
