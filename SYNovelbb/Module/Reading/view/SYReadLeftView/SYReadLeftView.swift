//
//  SYReadLeftView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

/// leftView 宽高度
let SY_READ_LEFT_VIEW_WIDTH: CGFloat = ScreenWidth * 0.66
let SY_READ_LEFT_VIEW_HEIGHT: CGFloat = ScreenHeight

class SYReadLeftView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(headerView)
        headerView.addSubview(volumeTitle)
        headerView.addSubview(scrollBtn)
        headerView.addSubview(lineView)
        addSubview(catalogView)
        updateUI()
    }
    
    var isTop: Bool = false
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(StatusBarHeight)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(44)
        }
        volumeTitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        scrollBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(44)
        }
        lineView.snp.makeConstraints { (make) in
            make.bottom.width.centerX.equalToSuperview()
            make.height.equalTo(0.5)
        }
        catalogView.snp.makeConstraints { (make) in
            make.centerX.bottom.width.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    /// 刷新UI 例如: 日夜间可以根据需求判断修改目录背景颜色,文字颜色等等
    func updateUI() {
        // 刷新分割线颜色(如果不需要刷新分割线颜色可以去掉,目前我是做了日夜间修改分割线颜色的操作)
        catalogView.tableView.reloadData()
        
        if isTop {
            scrollBtn.setImage(R.image.reading_to_top()!, for: .normal)
        } else {
            scrollBtn.setImage(R.image.reading_to_bottom()!, for: .normal)
        }
    }
    
    @objc func scroll() {
        if isTop {
            catalogView.tableView.scrollToTop()
        } else {
            catalogView.tableView.scrollToBottom()
        }
        isTop = !isTop
        updateUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var volumeTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(52, 52, 52)
        return label
    }()
    
    lazy var scrollBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.reading_to_bottom(), for: .normal)
        btn.titleLabel?.textAlignment = .right
        btn.addTarget(self, action: #selector(scroll), for: .touchUpInside)
        return btn
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(224, 224, 224)
        return view
    }()
    
    /// 目录
    lazy var catalogView: SYReadCatalogView = {
        let view = SYReadCatalogView()
        return view
    }()
    
}
