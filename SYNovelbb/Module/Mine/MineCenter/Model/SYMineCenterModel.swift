//
//  SYMineCenterModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

enum SYCellCornerRadiusType {
    // 不设置圆角
    case none
    // 上面两个角设置圆角
    case top
    // 下面两个角设置圆角
    case bottom
    // 四角都设置圆角
    case all
}

struct SYMineCenterModel {
    
    var icon: UIImage?
    
    var title: String!
    
    var content: String?
    
    var type: SYCellCornerRadiusType?
    
    var showLine: Bool = true
    
    init(_ icon: UIImage?, _ title: String, _ content: String?) {
        self.icon = icon
        self.title = title
        self.content = content
    }
}
