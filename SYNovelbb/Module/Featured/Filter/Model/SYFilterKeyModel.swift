//
//  SYFilterKeyModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYFilterKeyModel: HandyJSON {
    
    var fid: String!
    
    var title: String!
    
    var key: String!
    
    var content: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &fid, name: "id")
    }

}
