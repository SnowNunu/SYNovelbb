//
//  SYReplayModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/25.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYReplayModel: HandyJSON {
    
    var rid: String!
    
    var tid: String!
    
    var bid: String!
    
    var uid: String!
    
    var username: String!
    
    var contents: String!
    
    var postTime: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &rid, name: "id")
    }

}
