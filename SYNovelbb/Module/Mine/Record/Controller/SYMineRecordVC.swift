//
//  SYMineRecordVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit


class SYMineRecordVC: SYBaseVC {
    
    @IBOutlet weak var tableView: UITableView!

    lazy var viewModel: SYMineRecordVM = {
        let vm = SYMineRecordVM()
        return vm
    }()
    
    override func setupUI() {
//        tableView.emptyDataSetSource = self
//        tableView.emptyDataSetDelegate = self
    }
    
    override func rxBind() {
        tableView.prepare(viewModel, SYMineRecordModel.self)
//        tableView.headerRefreshing()
//        activityIndicatorView.startAnimating()
        
        viewModel.requestStatus.asDriver()
            .skip(1)
            .drive(onNext: { (result, message) in
                
            })
            .disposed(by: disposeBag)
    }

}
