//
//  SYMineAboutVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYMineAboutVC: SYBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var headerView: SYMineAboutHeader!
    
    lazy var viewModel: SYMineAboutVM = {
        let vm = SYMineAboutVM.init(self)
        return vm
    }()

    override func setupUI() {
        tableView.tableHeaderView?.height = 242
        tableView.tableFooterView?.height = 170
        headerView.nameLabel.text = Bundle.main.appName
        headerView.versionLabel.text = "Version \(Bundle.main.version)"
        
        let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, SYMineAboutModel>>.init(configureCell: { (datasouce, tableView, indexPath, model) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SYMineAboutCell", for: indexPath) as! SYMineAboutCell
            cell.model = model
            cell.lineView.isHidden = indexPath.row == datasouce.sectionModels[indexPath.section].items.count - 1
            return cell
        })
        
        viewModel.datasource.asDriver()
            .drive(tableView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

}

extension SYMineAboutVC: UITableViewDelegate {
    
    // 设置cell行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
}
