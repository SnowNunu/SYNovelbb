//
//  SYMineAccountVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RealmSwift

class SYMineAccountVC: SYBaseVC {
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var coinsLabel: UILabel!
    
    @IBOutlet weak var vouchersLabel: UILabel!
    
    lazy var viewModel: SYMineAccountVM = {
        let vm = SYMineAccountVM()
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        viewModel.updateUserInfo()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
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
        
        viewModel.userInfo
            .skip(1)
            .subscribe(onNext: { [unowned self] (model) in
                self.coinsLabel.text = "\(model.vipMoney)"
                self.vouchersLabel.text = "\(model.Diamonds)"
            })
            .disposed(by: disposeBag)
    }
    
    @IBAction func enterRechargeView(_ sender: Any) {
        let vc = R.storyboard.mine.mineRechargeVC()!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
