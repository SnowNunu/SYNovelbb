//
//  SYRMTopView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

/// topView 高度
let DZM_READ_MENU_TOP_VIEW_HEIGHT:CGFloat = NavgationBarHeight

class SYRMTopView: SYRMBaseView {
    
    /// 返回
    private var back:UIButton!

    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func addSubviews() {
        
        super.addSubviews()
        
        // 返回
        back = UIButton(type:.custom)
        back.setImage(UIImage(named:"navigation_back")!.withRenderingMode(.alwaysTemplate), for: .normal)
        back.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        back.tintColor = DZM_READ_COLOR_MENU_COLOR
        addSubview(back)
    }
    
    /// 点击返回
    @objc private func clickBack() {
        
        readMenu?.delegate?.readMenuClickBack?(readMenu: readMenu)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let y = StatusBarHeight
        
        let wh = NavgationBarHeight - y
        
        back.frame = CGRect(x: 0, y: y, width: wh, height: wh)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
