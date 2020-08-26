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
    
    var bookName: String!
    
    
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
        chapterView.frame = .init(x: 0, y: ScreenHeight, width: ScreenWidth, height: 390)
        view.addSubview(chapterView)
        
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
        tableView.prepare(viewModel, SYCommentModel.self, true)
        viewModel.requestStatus
            .skip(1)
            .subscribe(onNext: { [unowned self] (result, message) in
                if self.activityIndicatorView.isAnimating {
                    self.activityIndicatorView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)

        viewModel.datasource
            .asDriver()
            .drive(tableView.rx.items(cellIdentifier: SYBookCommentCell.className(), cellType: SYBookCommentCell.self)) { (row, model, cell) in
                cell.selectionStyle = .none
                cell.model = model
            }
            .disposed(by: disposeBag)
        
        viewModel.reloadSubject.onNext(true)
        activityIndicatorView.startAnimating()
        
        readBtn.rx.tap
            .bind { [unowned self] in
                let readModel = SYReadModel.model(bookID: self.bookId)
                readModel.bookName = self.bookName
                let vc  = SYReadController()
                vc.readModel = readModel
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        headerView.seeAllBtn.addTarget(self, action: #selector(showChapterListView), for: .touchUpInside)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 从底部弹出章节列表
    @objc func showChapterListView() {
        chapterBgView.frame = view.frame
        chapterView.frame = .init(x: 0, y: ScreenHeight, width: ScreenWidth, height: 390)
        view.addSubview(chapterBgView)
        view.addSubview(chapterView)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideChapterListView))
        chapterBgView.addGestureRecognizer(gesture)
        
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.chapterView.frame = .init(x: 0, y: ScreenHeight - 390, width: ScreenWidth, height: 390)
        }
    }
    
    /// 从底部移出章节列表
    @objc func hideChapterListView() {
        UIView.animate(withDuration: 0.3) {
            self.chapterView.frame = .init(x: 0, y: ScreenHeight, width: ScreenWidth, height: 390)
                    
            // 提交一个延时任务线程
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.chapterView.removeFromSuperview()
                self.chapterBgView.removeFromSuperview()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableHeaderView = self.headerView
        tableView.tableHeaderView?.height = 1000
        tableView.register(SYBookCommentCell.self, forCellReuseIdentifier: SYBookCommentCell.className())
        tableView.rowHeight = 148
        tableView.separatorStyle = .none
        
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
    
    lazy var chapterBgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.6)
        return view
    }()
    
    lazy var chapterView: SYBookChapterListView = {
        let view = SYBookChapterListView.init(frame: .init(x: 0, y: ScreenHeight, width: ScreenWidth, height: 390))
        view.backgroundColor = .white
        return view
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
