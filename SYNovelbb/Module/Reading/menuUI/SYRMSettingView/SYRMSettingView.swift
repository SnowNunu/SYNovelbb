//
//  SYRMSettingView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

/// 子视图高度
let DZM_READ_MENU_SETTING_SUB_VIEW_HEIGHT:CGFloat = DZM_SPACE_SA_50

/// settingView 内容高度
let DZM_READ_MENU_SETTING_VIEW_HEIGHT:CGFloat = DZM_READ_MENU_SETTING_SUB_VIEW_HEIGHT * 6

/// settingView 总高度(内容高度 + iphoneX情况下底部间距)
let DZM_READ_MENU_SETTING_VIEW_TOTAL_HEIGHT:CGFloat = SA(isX: DZM_READ_MENU_SETTING_VIEW_HEIGHT + DZM_SPACE_SA_20, DZM_READ_MENU_SETTING_VIEW_HEIGHT)

class SYRMSettingView: SYRMBaseView {
    
    /// 亮度
    private var lightView:SYRMLightView!
    
    /// 字体大小
    private var fontSizeView:SYRMFontSizeView!
    
    /// 背景
    private var bgColorView:SYMRMBGColorView!
    
    /// 翻页效果
    private var effectTypeView:SYRMEffectTypeView!
    
    /// 字体
    private var fontTypeView:SYRMFontTypeView!
    
    /// 间距
    private var spacingView:SYRMSpacingView!

    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        
        super.setupUI()
        
        let x = DZM_SPACE_SA_15
        let w = SY_READ_CONTENT_VIEW_WIDTH - DZM_SPACE_SA_30
        let h = DZM_READ_MENU_SETTING_SUB_VIEW_HEIGHT
        
        lightView = SYRMLightView(readMenu: readMenu)
        addSubview(lightView)
        lightView.frame = CGRect(x: x, y: 0, width: w, height: h)
        
        fontSizeView = SYRMFontSizeView(readMenu: readMenu)
        addSubview(fontSizeView)
        fontSizeView.frame = CGRect(x: x, y: lightView.frame.maxY, width: w, height: h)
        
        effectTypeView = SYRMEffectTypeView(readMenu: readMenu)
        addSubview(effectTypeView)
        effectTypeView.frame = CGRect(x: x, y: fontSizeView.frame.maxY, width: w, height: h)
        
        fontTypeView = SYRMFontTypeView(readMenu: readMenu)
        addSubview(fontTypeView)
        fontTypeView.frame = CGRect(x: x, y: effectTypeView.frame.maxY, width: w, height: h)
        
        bgColorView = SYMRMBGColorView(readMenu: readMenu)
        addSubview(bgColorView)
        bgColorView.frame = CGRect(x: x, y: fontTypeView.frame.maxY, width: w, height: h)
        
        spacingView = SYRMSpacingView(readMenu: readMenu)
        addSubview(spacingView)
        spacingView.frame = CGRect(x: x, y: bgColorView.frame.maxY, width: w, height: h)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
