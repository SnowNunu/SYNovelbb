//
//  SYIndexModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYIndexModel: HandyJSON {
    
    var bid: String!
    
    var readTxt: String!
    
    var readLabel: String?
    
    var bookTitle: String!
    
    var author: String?
    
    var cover: String!
    
    var intro: String?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &bid, name: "id")
        mapper.specify(property: &readLabel, name: "readLable")
        mapper.specify(property: &intro, name: "Introduction")
    }

}
