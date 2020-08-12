//
//  SYRMBottomView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

/// funcView 高度
let DZM_READ_MENU_FUNC_VIEW_HEIGHT:CGFloat = DZM_SPACE_SA_55

/// progressView 高度
let DZM_READ_MENU_PROGRESS_VIEW_HEIGHT:CGFloat = DZM_SPACE_SA_55

/// bottomView 高度
let SY_READ_MENU_BOTTOM_VIEW_HEIGHT:CGFloat = BottomSafeAreaHeight + 100

class SYRMBottomView: SYRMBaseView {
    
    /// 进度
    private(set) var progressView:SYRMProgressView!
    
    /// 功能
    private var funcView:SYRMFuncView!

    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        
        super.setupUI()
        
        progressView = SYRMProgressView(readMenu: readMenu)
        addSubview(progressView)
        
        funcView = SYRMFuncView(readMenu: readMenu)
        addSubview(funcView)
    }
    
    override func setupConstraints() {
        progressView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-136)
            make.centerX.top.equalToSuperview()
            make.height.equalTo(40)
        }
        funcView.snp.makeConstraints { (make) in
            make.width.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.top.equalTo(progressView.snp_bottom)
            make.height.equalTo(60)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
