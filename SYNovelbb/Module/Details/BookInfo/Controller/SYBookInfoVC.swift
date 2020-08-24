//
//  SYBookInfoVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBookInfoVC: SYBaseVC {
    
    var bookId: String!
    
    lazy var viewModel: SYBookInfoVM = {
        let vm = SYBookInfoVM(self)
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func setupUI() {
        view.addSubview(tableView)
        view.addSubview(backBtn)
        view.addSubview(collectBtn)
        view.addSubview(readBtn)
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.snp.makeConstraints { (make) in
            make.top.centerX.width.equalToSuperview()
            make.bottom.equalTo(collectBtn.snp.top)
        }
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.height.width.equalTo(44)
            make.top.equalToSuperview().offset(StatusBarHeight)
        }
        collectBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(49)
            make.bottom.equalToSuperview().offset(-BottomSafeAreaHeight)
        }
        readBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.bottom.height.equalTo(collectBtn)
        }
    }
    
    override func rxBind() {
        viewModel.requestStatus
            .skip(1)
            .subscribe(onNext: { [unowned self] (result, message) in
                if self.activityIndicatorView.isAnimating {
                    self.activityIndicatorView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.reloadSubject.onNext(true)
        activityIndicatorView.startAnimating()
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableHeaderView = self.headerView
        tableView.tableHeaderView?.height = 1000
        return tableView
    }()
    
    lazy var headerView: SYBookInfoHeaderView = {
        let header = SYBookInfoHeaderView()
        return header
    }()
    
    /// 返回按钮
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.navigation_back()!, for: .normal)
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    /// 添加到书架按钮
    lazy var collectBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Put it on the shelf", for: .normal)
        btn.setTitleColor(UIColor(178, 143, 0), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return btn
    }()
    
    /// 去阅读按钮
    lazy var readBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(244, 209, 67)
        btn.setTitle("Reading now", for: .normal)
        btn.setTitleColor(UIColor(52, 52, 52), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return btn
    }()

}

//extension SYBookInfoVC { /**控制导航栏显示与隐藏动画*/
//
//    //MARK: UIScrollowViewDelegate
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let _alpha = scrollView.contentOffset.y / 64
//        let alpha: CGFloat = (scrollView.contentOffset.y <= -64) ? 0 : (_alpha > 1.0 ? 1 : _alpha)
//        navigationView.alpha = alpha
////
////        navTitleOutlet.isHidden = alpha == 1 ? false : true
//    }
//
//}
