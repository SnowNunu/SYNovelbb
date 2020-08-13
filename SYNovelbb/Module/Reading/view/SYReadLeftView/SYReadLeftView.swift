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

/// leftView headerView 高度
let DZM_READ_LEFT_HEADER_VIEW_HEIGHT:CGFloat = DZM_SPACE_SA_50

class SYReadLeftView: UIView {
    
    // 分割线
    private var spaceLine:UIView!
    
    // 目录
    private(set) var catalogView:SYReadCatalogView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
    }
    
    private func addSubviews() {
        
        // 分割线
        spaceLine = SpaceLine(self, DZM_COLOR_230_230_230)
        spaceLine.frame = CGRect(x: 0, y: 50, width: SY_READ_LEFT_VIEW_WIDTH, height: DZM_SPACE_LINE)
        
        // 目录
        catalogView = SYReadCatalogView()
        addSubview(catalogView)
        catalogView.frame = CGRect(x: 0, y: spaceLine.frame.maxY, width: SY_READ_LEFT_VIEW_WIDTH, height: SY_READ_LEFT_VIEW_HEIGHT - spaceLine.frame.maxY)
        
        // 更新当前UI
        updateUI()
    }
    
    /// 刷新UI 例如: 日夜间可以根据需求判断修改目录背景颜色,文字颜色等等
    func updateUI() {
        
        // 刷新分割线颜色(如果不需要刷新分割线颜色可以去掉,目前我是做了日夜间修改分割线颜色的操作)
        catalogView.tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
