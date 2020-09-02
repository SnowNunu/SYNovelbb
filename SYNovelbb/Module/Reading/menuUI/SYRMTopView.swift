//
//  SYRMTopView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

/// topView 高度
let SY_READ_MENU_TOP_VIEW_HEIGHT: CGFloat = StatusBarHeight + 44

class SYRMTopView: SYRMBaseView {
    
    /// 返回
    private var back:UIButton!

    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        super.setupUI()
        addSubview(backBtn)
        addSubview(titleLabel)
        addSubview(bookcaseBtn)
    }
    
    override func setupConstraints() {
        backBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        bookcaseBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
    }
    
    /// 点击返回
    @objc private func clickBack() {
        readMenu.delegate?.readMenuClickBack?(readMenu: readMenu)
    }
    
    /// 点击书架
    @objc private func clickBookcase() {
        readMenu.delegate.readMenuClickBookcase?(readMenu: readMenu)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 返回按钮
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.navigation_back()!, for: .normal)
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        return btn
    }()
    
    // 书籍标题文本
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(51, 51, 51)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    // 添加/移出书架按钮
    lazy var bookcaseBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.reading_del_bookcase(), for: .normal)
        btn.setImage(R.image.reading_add_bookcase(), for: .selected)
        btn.contentHorizontalAlignment = .right
        btn.addTarget(self, action: #selector(clickBookcase), for: .touchUpInside)
        return btn
    }()
    
}
