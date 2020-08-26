//
//  SYBookChapterListView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/25.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxRelay
import RxDataSources
import RxSwift

class SYBookChapterListView: UIView {
    
    var disposeBag = DisposeBag()
    
    var datasources = BehaviorRelay<[SYChapterModel]>(value: [SYChapterModel]())
    
    var isTop = BehaviorRelay<Bool>(value: true)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        rxBind()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(actionBtn)
        addSubview(underline)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
        actionBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.top.equalToSuperview()
            make.width.height.equalTo(44)
        }
        underline.snp.makeConstraints { (make) in
            make.height.equalTo(0.5)
            make.centerX.width.equalToSuperview()
            make.top.equalTo(actionBtn.snp.bottom)
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(underline.snp.bottom)
            make.centerX.width.bottom.equalToSuperview()
        }
    }
    
    private func rxBind() {
        datasources.skip(1)
            .subscribe(onNext: { [unowned self] (array) in
                self.titleLabel.text = "All \(array.count) chapters"
            })
            .disposed(by: disposeBag)
        
        datasources.asDriver()
            .drive(tableView.rx.items(cellIdentifier: SYBookChapterListCell.className(), cellType: SYBookChapterListCell.self)) { (row, model, cell) in
                cell.model = model
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        isTop.subscribe(onNext: { [unowned self] (bool) in
                if bool {
                    self.actionBtn.setImage(R.image.reading_to_bottom(), for: .normal)
                    self.tableView.scrollToTop()
                } else {
                    self.actionBtn.setImage(R.image.reading_to_top(), for: .normal)
                    self.tableView.scrollToBottom()
                }
            })
            .disposed(by: disposeBag)
        
        actionBtn.rx
            .tap
            .bind { [unowned self] in
                self.isTop.accept(!self.isTop.value)
            }
            .disposed(by: disposeBag)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var actionBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.reading_to_bottom()!, for: .normal)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    lazy var underline: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(242, 242, 242)
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SYBookChapterListCell.self, forCellReuseIdentifier: SYBookChapterListCell.className())
        tableView.separatorStyle = .none
        tableView.height = 42.5
        return tableView
    }()
    
}
