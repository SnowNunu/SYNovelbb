//
//  SYReadRecordModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        
        super.init(frame: frame, style: style)
        
        backgroundColor = UIColor.clear
        
        separatorStyle = .none
        
        if #available(iOS 11.0, *) {
            
            contentInsetAdjustmentBehavior = .never
            estimatedRowHeight = 0
            estimatedSectionFooterHeight = 0
            estimatedSectionHeaderHeight = 0
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
