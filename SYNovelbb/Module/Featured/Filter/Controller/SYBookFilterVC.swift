//
//  SYBookFilterVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/18.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYBookFilterVC: SYBaseVC {
    
    lazy var headerView: SYBookFilterHeaderView = {
        let view = SYBookFilterHeaderView()
        return view
    }()
    
    lazy var viewModel: SYBookFilterVM = {
        let vm = SYBookFilterVM.init(self)
        return vm
    }()

    override func setupUI() {
        title = "Bookshelf"
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        headerView.snp.makeConstraints { (make) in
            make.centerX.width.top.equalToSuperview()
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
    
    override func rxBind() {
        viewModel.requestStatus
            .skip(1)
            .subscribe(onNext: { [unowned self] (bool, message) in
                if self.activityIndicatorView.isAnimating {
                    self.activityIndicatorView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        tableView.prepare(viewModel, SYBaseBookModel.self, true)
        
        headerView.chooseBtn.rx
            .tap
            .bind { [unowned self] in
                UIView.animate(withDuration: 0.5, animations: {
                    self.tableView.tableHeaderView?.height = self.tableView.tableHeaderView?.height == 0 ? 130 : 0
                    self.tableView.reloadData()
                }) { (bool) in
                    if bool {
                        self.headerView.chooseBtn.setImage(self.tableView.tableHeaderView?.height == 0 ? R.image.home_choose_down() : R.image.home_choose_up(), for: .normal)
                    }
                }
            }
            .disposed(by: headerView.disposeBag)

        viewModel.datasource.asDriver()
            .drive(tableView.rx.items(cellIdentifier: SYBookFilterCell.className(), cellType: SYBookFilterCell.self)) { (row, model, cell) in
                cell.model = model
            }
            .disposed(by: disposeBag)
        
        activityIndicatorView.startAnimating()
        viewModel.requestFilterInfo()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(SYBookFilterCell.self, forCellReuseIdentifier: SYBookFilterCell.className())
        tableView.rowHeight = 130
        tableView.tableHeaderView = self.optionsView
        return tableView
    }()
    
    lazy var optionsView: SYBookFilterOptionsView = {
        let view = SYBookFilterOptionsView()
        return view
    }()

}
