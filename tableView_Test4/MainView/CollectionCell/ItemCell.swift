//
//  ItemCell.swift
//  tableView_Test4
//
//  Created by LeeX on 10/11/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblSchedule: UILabel!
    
    private var _cellStyle = CustomCell.unselect {
        didSet {
            mainContainer.backgroundColor = _cellStyle.bgColor
            lblTitle.textColor = _cellStyle.mainTextColor
            lblSubTitle.textColor = _cellStyle.subTextColor
            lblSchedule.textColor = _cellStyle.subTextColor
        }
    }
    
    private var roundCorners: ViewCorners = .all {
        didSet {
            mainContainer.roundCorners(self.roundCorners)
        }
    }
    
    var isFirst = false {
        didSet {
            roundCorners = self.isFirst ? .right : .all
        }
    }
    
    var isSelecting = false {
        didSet {
            _cellStyle = isSelecting ? .selected : isFirst ? .unselect : .unselectFromSecondSubItem
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }
    
    private func commonInit() {
        contentView.backgroundColor = .clear
        lblTitle.font = .systemFont(ofSize: 14, weight: .regular)
        lblTitle.text = Global.sampleText
        lblSubTitle.font = .systemFont(ofSize: 12, weight: .regular)
        lblSubTitle.text = Global.sampleText
        lblSchedule.font = .systemFont(ofSize: 12, weight: .regular)
        lblSchedule.text = Global.sampleText
    }
}
