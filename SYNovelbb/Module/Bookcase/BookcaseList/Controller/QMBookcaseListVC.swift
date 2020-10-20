//
//  QMBookcaseListVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class QMBookcaseListVC: SYBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: QMBookcaseListVM = {
        let vm = QMBookcaseListVM()
        return vm;
    }()
    
    var selectedModel: QMBookcaseListModel?
    
    override func setupUI() {
        tableView.prepare(viewModel, QMBookcaseListModel.self, true)
        tableView.headerRefreshing()
        
        viewModel.datasource.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "QMBookcaseListCell", cellType: QMBookcaseListCell.self)) { (row, model, cell) in
                cell.model = model
            }
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.selectedModel = self.viewModel.datasource.value[indexPath.row]
                self.performSegue(withIdentifier: "enterBookContentView", sender: self)
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! QMBookContentVC;
        vc.title = selectedModel?.bookName ?? ""
        vc.bookId = selectedModel?.bookId
    }

}

extension QMBookcaseListVC: UITableViewDelegate {
    
    // 设置cell行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
