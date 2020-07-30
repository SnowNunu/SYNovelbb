//
//  SYMineAccountModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

struct SYMineAccountModel {
    
    var title: String!
    
    var type: SYCellCornerRadiusType!
    
    init(title: String!, type: SYCellCornerRadiusType!) {
        self.title = title
        self.type = type
    }

}
