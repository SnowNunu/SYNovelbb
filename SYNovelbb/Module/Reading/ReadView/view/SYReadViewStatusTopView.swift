//
//  SYReadViewStatusTopView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadViewStatusTopView: UIView {
    
    /// 章节名
    private(set) var chapterName:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    private func addSubviews() {
        // 章节名
        chapterName = UILabel()
        chapterName.font = .systemFont(ofSize: 12, weight: .regular)
        chapterName.textColor = SYReadConfigure.shared().statusTextColor
        chapterName.textAlignment = .left
        addSubview(chapterName)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        chapterName.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
