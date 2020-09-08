//
//  SYBrowseRecordVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/9/4.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBrowseRecordVC: SYBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: SYBrowseRecordVM = {
        let vm = SYBrowseRecordVM()
        return vm
    }()
    
    override func setupUI() {
        tableView.rowHeight = 125
    }
    
    override func rxBind() {
        tableView.prepare(viewModel, SYBrowseRecordModel.self)
        tableView.headerRefreshing()
        
        viewModel.datasource
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: "SYBrowseRecordCell", cellType: SYBrowseRecordCell.self)) { (row,model,cell) in
                cell.model = model
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { (indexPath) in
                
            })
            .disposed(by: disposeBag)
    }

}
