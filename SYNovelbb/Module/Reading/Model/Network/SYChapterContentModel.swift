//
//  SYChapterContentModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/13.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYChapterContentModel: HandyJSON {
    
    var chapter: [SYChapterModel]!
    
    var vipMoney: Int!
    
    var diamonds: Int!
    
    var tClass: Int!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &diamonds, name: "Diamonds")
        mapper.specify(property: &tClass, name: "tclass")
    }

}
