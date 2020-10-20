//
//  SYMineCenterVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RealmSwift

class SYMineCenterVC: SYBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: SYMineCenterHeader!
    
    var token: NotificationToken?
    
    lazy var viewModel: SYMineCenterVM = {
        let vm = SYMineCenterVM.init(self)
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func setupUI() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.tableHeaderView?.height = 192.5 + StatusBarHeight
        tableView.tableFooterView?.height = 42
        
        let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, SYMineCenterModel>>.init(configureCell: {(datasouce, tableView, indexPath, element) in
            var model = element
            if datasouce.sectionModels[indexPath.section].items.count == 3 {
                if indexPath.row == 0 {
                    model.type = .top
                } else if indexPath.row == 1 {
                    model.type = SYCellCornerRadiusType.none
                } else {
                    model.type = .bottom
                }
            } else if datasouce.sectionModels[indexPath.section].items.count == 2 {
                if indexPath.row == 0 {
                    model.type = .top
                } else {
                    model.type = .bottom
                }
            } else {
                model.type = .all
            }
            model.showLine = indexPath.row != datasouce.sectionModels[indexPath.section].items.count - 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "SYMineCenterCell", for: indexPath) as! SYMineCenterCell
            cell.model = model
            return cell
        })
        viewModel.datasource
            .asDriver()
            .drive(tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asDriver()
            .drive(viewModel.enterNextView)
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        tableView.prepare(viewModel, SectionModel<String, SYMineCenterModel>.self)
        tableView.headerRefreshing()
        
        let realm = try! Realm()
        token = realm.objects(SYUserModel.self).observe(on: .main, { [unowned self] (change: RealmCollectionChange) in
            switch change {
                case .update(let results, _, _, _):
                    let model = results.first!
                    self.headerView.nickname.text = model.nickname
                    self.headerView.headImage.kf.setImage(with: URL(string: model.Avatar))
                    self.headerView.welcome.text = "Welcome back!"
                    self.headerView.coinsLabel.text = "\(model.vipMoney)"
                    self.headerView.vouchersLabel.text = "\(model.Diamonds)"
                break
            default:
                break
            }
        })
    }
    
    deinit {
        token?.invalidate()
    }

}

extension SYMineCenterVC: UITableViewDelegate {
    
    // 设置cell行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // 设置header高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 25 : 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(244, 241, 244)
        return view
    }
    
}
