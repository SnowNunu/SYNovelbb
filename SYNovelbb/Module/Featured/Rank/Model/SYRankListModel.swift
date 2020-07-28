
//
//  SYRankListModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYRankListModel: SYBaseBookModel {
    
    var type: SYRankType?
    
    // 累计查阅人数
    var mhits: String?
    
    // 累计推荐人数
    var mrecomm: String?
    
    // 累计阅读人数
    var saveNumber: String?
    
    // 累计打赏人数
    var extcredits2: String?
    
    func getDescription() -> String {
        switch type {
        case .popular:
            return "\(mhits ?? "") people viewed"
        case .recommend:
            return "\(mrecomm ?? "") people recommend"
        case .fellow:
            return "\(saveNumber ?? "") people reading"
        default:
            return "\(extcredits2 ?? "") people rewards"
        }
    }

}
