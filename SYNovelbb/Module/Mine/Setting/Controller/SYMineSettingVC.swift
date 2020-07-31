//
//  SYMineSettingVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYMineSettingVC: SYBaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var footerView: SYMineSettingFooter!
    
    lazy var viewModel: SYMineSettingVM = {
        let vm = SYMineSettingVM.init(self)
        return vm
    }()
    
    override func setupUI() {
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        tableView.tableFooterView?.height = 69
    }
    
    override func rxBind() {
        let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String, SYMineSettingModel>>.init(configureCell: {(datasouce, tableView, indexPath, model) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "SYMineSettingCell", for: indexPath) as! SYMineSettingCell
            cell.model = model
            cell.lineView.isHidden = indexPath.row == datasouce.sectionModels[indexPath.section].items.count - 1
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
        
        footerView.switchBtn.rx
            .tap
            .subscribe(onNext: { [unowned self] _ in
                let vc = R.storyboard.mine.mineBindingVC()!
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            })
            .disposed(by: footerView.disposeBag)
    }

}

extension SYMineSettingVC: UITableViewDelegate {
    
    // 设置cell行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
