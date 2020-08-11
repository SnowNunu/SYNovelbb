//
//  SYReadViewStatusTopView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

/// topView 高度
let DZM_READ_STATUS_TOP_VIEW_HEIGHT:CGFloat =  DZM_SPACE_SA_40

class SYReadViewStatusTopView: UIView {

    /// 书名
    private(set) var bookName:UILabel!
    
    /// 章节名
    private(set) var chapterName:UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
    }
    
    private func addSubviews() {
        
        // 书名
        bookName = UILabel()
        bookName.font = DZM_FONT_SA_10
        bookName.textColor = SYReadConfigure.shared().statusTextColor
        bookName.textAlignment = .left
        addSubview(bookName)
        
        // 章节名
        chapterName = UILabel()
        chapterName.font = DZM_FONT_SA_10
        chapterName.textColor = SYReadConfigure.shared().statusTextColor
        chapterName.textAlignment = .right
        addSubview(chapterName)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let w = frame.size.width
        let h = frame.size.height
        let labelW = (w - DZM_SPACE_SA_15) / 2
        
        // 书名
        bookName.frame = CGRect(x: 0, y: 0, width: labelW, height: h)
        
        // 章节名
        chapterName.frame = CGRect(x: w - labelW, y: 0, width: labelW, height: h)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
