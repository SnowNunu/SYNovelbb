//
//  SYMineAccountVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineAccountVC: SYBaseVC {
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: SYMineAccountVM = {
        let vm = SYMineAccountVM()
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func setupUI() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.tableHeaderView?.height = StatusBarHeight + 210
    }

    override func rxBind() {
        viewModel.datasource
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: "SYMineAccountCell", cellType: SYMineAccountCell.self)) { [unowned self] (row, model, cell) in
                cell.model = model
                cell.underLine.isHidden = row == self.viewModel.datasource.value.count - 1
            }
            .disposed(by: disposeBag)
        
        backBtn.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }

}
