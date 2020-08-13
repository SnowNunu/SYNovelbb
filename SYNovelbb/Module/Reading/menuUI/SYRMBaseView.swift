//
//  SYRMBaseView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYRMBaseView: UIView {

    /// 菜单对象
    weak var readMenu:SYReadMenu!
    
    /// 系统初始化
    override init(frame: CGRect) { super.init(frame: frame) }
    
    /// 初始化
    convenience init(readMenu:SYReadMenu!) {
        self.init(frame: CGRect.zero)
        self.readMenu = readMenu
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        backgroundColor = .white
    }
    
    func setupConstraints() {}
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
