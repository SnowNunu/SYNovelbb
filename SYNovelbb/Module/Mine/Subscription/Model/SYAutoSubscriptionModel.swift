
//
//  SYAutoSubscriptionModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYAutoSubscriptionModel: HandyJSON {
    
    var bid         : String!
    
    var booktitle   : String!
    
    var addtime     : String!
    
    var isAuto      : Bool!
    
    var uid         : String!
    
    var author      : String?
    
    // 需要自己组装url
    var cover       : String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &bid, name: "id")
    }

}
