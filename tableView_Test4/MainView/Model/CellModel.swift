//
//  CellModel.swift
//  tableView_Test4
//
//  Created by LeeX on 10/10/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

struct CellModel {
    var isSelected: Bool =  false
    var contentOffset: CGPoint = CGPoint.zero
    var subItemCount: Int = 5
}

extension CellModel {
    mutating func setContentOffset(x: CGFloat) {
        self.contentOffset = CGPoint(x: x, y: 0)
    }
    
    mutating func toggleSelect() {
        self.isSelected.toggle()
    }
}
