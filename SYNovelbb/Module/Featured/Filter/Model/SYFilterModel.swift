//
//  SYFilterModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYFilterModel: HandyJSON {
    
    var category: [SYFilterKeyModel]!
    
    var rank: [SYFilterKeyModel]!
    
    var status: [SYFilterKeyModel]!
    
    var other: [SYFilterKeyModel]!
    
    required init() {}
    
}
