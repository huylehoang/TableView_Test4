//
//  CellStyleBuilder.swift
//  tableView_Test4
//
//  Created by LeeX on 10/14/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import Foundation
import UIKit

private extension CellStyleComponents {
    typealias SetupClosure = (CellStyleComponents) -> ()
    
    init(setupClosure: SetupClosure) {
        setupClosure(self)
    }
}

private extension UIColor {
    var notClear: Bool {
        return self != .clear
    }
}

private class CellStyleBuilder: CellStyleProtocol {
    var bgColor: UIColor!
    var mainTextColor: UIColor!
    var subTextColor: UIColor!
    
    typealias BuilderClosure = (CellStyleBuilder) -> ()
    
    init(builderClosure: BuilderClosure? = nil) {
        if builderClosure != nil {
            builderClosure?(self)
        } else {
            let _ = CellStyleComponents { (components) in
                bgColor = components.bgColor
                mainTextColor = components.mainTextColor
                subTextColor = components.subTextColor
            }
        }
    }
}

extension CellStyleBuilder {
    static var selected: CustomCellStyle {
        return CustomCellStyle(builder: CellStyleBuilder { (builder) in
            builder.bgColor = .darkGray
            builder.mainTextColor = .white
            builder.subTextColor = UIColor.white.withAlphaComponent(0.7)
        })
    }
    
    static var unselect: CustomCellStyle {
        return CustomCellStyle(builder: CellStyleBuilder { (builder) in
            builder.bgColor = UIColor.darkGray.withAlphaComponent(0.7)
            builder.mainTextColor = UIColor.white.withAlphaComponent(0.7)
            builder.subTextColor = UIColor.white.withAlphaComponent(0.5)
        })
    }
    
    static var unselectFromSecondSubItem: CustomCellStyle {
        let unselect = CellStyleBuilder.unselect
        unselect.bgColor = UIColor.darkGray.withAlphaComponent(0.5)
        return unselect
    }
}

private class CustomCellStyle: CellStyleProtocol {
    var bgColor: UIColor!
    var mainTextColor: UIColor!
    var subTextColor: UIColor!
    
    init(builder: CellStyleBuilder = CellStyleBuilder()) {
        self.bgColor = builder.bgColor
        self.mainTextColor = builder.mainTextColor
        self.subTextColor = builder.subTextColor
    }
    
    func change(components: CellStyleComponents) -> CustomCellStyle {
        if components.bgColor.notClear {
            bgColor = components.bgColor
        }
        if components.mainTextColor.notClear {
            mainTextColor = components.mainTextColor
        }
        if components.subTextColor.notClear {
            subTextColor = components.subTextColor
        }
        return self
    }
}

extension CustomCell {
    var type: CellStyleProtocol {
        switch self {
        case .selected:
            return CellStyleBuilder.selected
        case .unselect:
            return CellStyleBuilder.unselect
        case .unselectFromSecondSubItem:
            return CellStyleBuilder.unselectFromSecondSubItem
        case .new(let custom, let style):
            return (style.type as! CustomCellStyle).change(components: custom)
        default:
            return CustomCellStyle()
        }
    }
}
