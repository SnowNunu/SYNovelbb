//
//  SYBookFilterVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/18.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import DZNEmptyDataSet

class SYBookFilterVC: SYBaseVC {
    
    lazy var headerView: SYBookFilterHeaderView = {
        let view = SYBookFilterHeaderView()
        return view
    }()
    
    lazy var viewModel: SYBookFilterVM = {
        let vm = SYBookFilterVM.init(self)
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

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
                    if self.tableView.tableHeaderView?.height == 0 {
                        self.tableView.tableHeaderView?.height = 150
                        self.optionsView.collectionView.snp.updateConstraints { (make) in
                            make.height.equalTo(145)
                        }
                    } else {
                        self.tableView.tableHeaderView?.height = 0
                        self.optionsView.collectionView.snp.updateConstraints { (make) in
                            make.height.equalTo(0)
                        }
                    }
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
        
        let optionsDatasources = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYFilterKeyModel>>.init(configureCell: { [unowned self] (_, collectionView, indexPath, model) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYBookFilterOptionsCell.className(), for: indexPath) as! SYBookFilterOptionsCell
            cell.contentLabel.text = model.title
            if indexPath.row != 0 && self.viewModel.filterParams.value[model.key] != nil && self.viewModel.filterParams.value[model.key]! == model.fid {
                cell.contentLabel.textColor = UIColor(177, 143, 0)
            } else {
                cell.contentLabel.textColor = UIColor(115, 115, 115)
            }
            return cell
        })
        
        optionsView.datasource.asDriver()
            .drive(optionsView.collectionView.rx.items(dataSource: optionsDatasources))
            .disposed(by: disposeBag)
        
        optionsView.collectionView.rx
            .itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                if indexPath.row != 0 {
                    let model = self.optionsView.datasource.value[indexPath.section].items[indexPath.row]
                    var params = self.viewModel.filterParams.value
                    if params[model.key] == model.fid {
                        let old = self.optionsView.datasource.value[indexPath.section].items.filter { (temp) -> Bool in
                            temp.fid == params[model.key]
                        }
                        self.headerView.datasource.acceptUpdate(byMutating: { $0.removeAll { (string) -> Bool in old.first!.title == string }})
                        params.removeValue(forKey: model.key)
                    } else {
                        if params[model.key] != nil {
                            // 先删除后添加
                            let old = self.optionsView.datasource.value[indexPath.section].items.filter { (temp) -> Bool in
                                temp.fid == params[model.key]
                            }
                            self.headerView.datasource.acceptUpdate(byMutating: { $0.removeAll { (string) -> Bool in old.first!.title == string }})
                        }
                        self.headerView.datasource.acceptUpdate(byMutating: { $0.append(model.title)})
                        params[model.key] = model.fid
                    }
                    self.viewModel.filterParams.acceptUpdate(byReplace: {_ in params})
                    self.optionsView.collectionView.reloadData()
                }
            })
            .disposed(by: optionsView.disposeBag)
        
        activityIndicatorView.startAnimating()
        viewModel.requestFilterInfo()
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                let model = self.viewModel.datasource.value[indexPath.row]
                let vc = SYBookInfoVC()
                vc.bookId = model.bid
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(SYBookFilterCell.self, forCellReuseIdentifier: SYBookFilterCell.className())
        tableView.rowHeight = 130
        tableView.tableHeaderView = self.optionsView
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        return tableView
    }()
    
    lazy var optionsView: SYBookFilterOptionsView = {
        let view = SYBookFilterOptionsView()
        return view
    }()

}

// MARK: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
extension SYBookFilterVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    // 设置占位图显示图片内容
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return R.image.search_no_books()!
    }

    // 设置占位图图片下文字显示内容
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString.init(string: "There is no content you are searching for")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(51, 51, 51), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString.init(string: "Try choosing other books you like")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(198, 189, 172), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }

}
