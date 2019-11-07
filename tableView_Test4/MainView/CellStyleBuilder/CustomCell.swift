//
//  CellType.swift
//  tableView_Test4
//
//  Created by LeeX on 10/14/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

protocol CellStyleProtocol {
    var bgColor: UIColor! {get}
    var mainTextColor: UIColor! {get}
    var subTextColor: UIColor! {get}
}

struct CellStyleComponents: CellStyleProtocol {
    var bgColor: UIColor! = .clear
    var mainTextColor: UIColor! = .clear
    var subTextColor: UIColor! = .clear
}

indirect enum CustomCell {
    case selected, unselect, unselectFromSecondSubItem, `default`
    case new(custom: CellStyleComponents, fromStyle: CustomCell = .default)
}

extension CustomCell: CellStyleProtocol {
    var bgColor: UIColor! {
        return self.type.bgColor
    }
    
    var mainTextColor: UIColor! {
        return self.type.mainTextColor
    }
    
    var subTextColor: UIColor! {
        return self.type.subTextColor
    }
}
