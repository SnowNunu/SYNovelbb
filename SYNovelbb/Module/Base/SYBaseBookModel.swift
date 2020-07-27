//
//  SYBaseBookModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYBaseBookModel: HandyJSON {
    
    var bookTitle      : String!
    
    var cover          : String?
    
    var bid            : String!
    
    var author         : String?
    
    var readTxt        : String?
    
    var readLable      : String?
    
    var intro   : String?
    
    var isVip          : Bool!
    
    var isMark         : Bool!
    
    var vipUpdateTitle : String?
    
    var bookLength      : String?
    
    var lastUpdate     : String?
    
    var lastUpdateId   : String?
    
    var lastUpdateTitle: String?
    
    var readDate       : String?
    
    var tclass         : String?
    
    var Labels         : String?
    
    var state          : Int?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &bid, name: "id")
        mapper.specify(property: &bookLength, name: "booklength")
        mapper.specify(property: &bookTitle, name: "booktitle")
        mapper.specify(property: &intro, name: "Introduction")
    }
    
}
