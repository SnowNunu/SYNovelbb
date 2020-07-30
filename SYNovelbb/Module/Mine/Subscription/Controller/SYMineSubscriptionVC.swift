//
//  SYMineSubscriptionVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineSubscriptionVC: SYBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: SYMineSubscriptionVM = {
        let vm = SYMineSubscriptionVM()
        return vm
    }()
    
    override func rxBind() {
        viewModel.datasource
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: "SYMineSubscriptionCell", cellType: SYMineSubscriptionCell.self)){ (row, model, cell) in
                cell.model = model
            }
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
}

extension SYMineSubscriptionVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
}
