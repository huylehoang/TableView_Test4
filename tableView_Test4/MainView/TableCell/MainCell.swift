//
//  MainCell.swift
//  tableView_Test4
//
//  Created by LeeX on 10/10/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import UIKit

protocol MainCellDelegte {
    func didSelectCell(_ cell: MainCell)
}

class MainCell: UITableViewCell {

    @IBOutlet weak var mainContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy private var tapGesture: UIGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tap.numberOfTapsRequired = 1
        return tap
    }()
    
    private var _cellStyle = CustomCell.unselect {
        didSet {
            mainContainer.backgroundColor = _cellStyle.bgColor
            lblTitle.textColor = _cellStyle.mainTextColor
        }
    }
    
    var delegate: MainCellDelegte?
    
    var isSelecting = false {
        didSet {
            _cellStyle = isSelecting ? .selected : .unselect
            contentView.isUserInteractionEnabled = true
            contentView.addGestureRecognizer(tapGesture)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        mainContainer.roundCorners(.left)
        lblTitle.font = .systemFont(ofSize: 17.0, weight: .bold)
        MainViewModel.setup(collectionView)
    }
    
    @objc private func tapped() {
        delegate?.didSelectCell(self)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}

extension MainCell {
    func setCollectionDataSourceDelegate(dataSourceDelegate dataSource: UICollectionViewDataSource & UICollectionViewDelegate,
                                         withIndex index: Int)
    {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.tag = index
    }
    
    func setCollectionViewContentOffset(_ contentOffset: CGPoint, animated: Bool = false) {
        collectionView.setContentOffset(contentOffset, animated: animated)
        collectionView.reloadData()
    }
}
