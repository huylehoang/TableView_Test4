//
//  Extension+UIVIew.swift
//  tableView_Test4
//
//  Created by LeeX on 10/11/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

enum ViewCorners {
    case left, right, top, bottom, all
    
    fileprivate var cornerMasks: CACornerMask {
        switch self {
        case .left: return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        case .right: return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .top: return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .bottom: return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .all: return [ViewCorners.right.cornerMasks, ViewCorners.left.cornerMasks]
        }
    }
}

extension UIView {
    func roundCorners(_ corners: ViewCorners, withRadius radius: CGFloat = 5) {
        layer.cornerRadius = radius
        layer.maskedCorners = corners.cornerMasks
    }
}
