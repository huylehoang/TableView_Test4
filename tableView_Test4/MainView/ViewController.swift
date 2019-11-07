//
//  ViewController.swift
//  tableView_Test4
//
//  Created by LeeX on 10/10/19.
//  Copyright © 2019 LeeX. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var mainVM = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        mainVM.setup(tableView, withDataSourceDelegate: self)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainVM.tableRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return mainVM.cellInstance(for: tableView, at: indexPath, withCollectionDataSourceDelegate: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        mainVM.setContentOffset(for: cell, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainViewModel.cellHeight
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainVM.subItemCount(atRow: collectionView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return mainVM.cellInstance(for: collectionView, at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mainVM.getContentOffset(of: scrollView)
    }
}
