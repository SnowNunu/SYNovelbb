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
    
    var bookTitle       : String!
    
    var cover           : String?
    
    var bid             : String!
    
    var author          : String?
    
    var readTxt         : String?
    
    var readLable       : String?
    
    var intro           : String?
    
    var isVip           : Bool!
    
    var isMark          : Bool!
    
    var vipUpdateTitle  : String?
    
    var bookLength      : String?
    
    var lastUpdate      : String?
    
    var lastUpdateId    : String?
    
    var lastUpdateTitle : String?
    
    var readDate        : String?
    
    var tclass          : String?
    
    var Labels          : String?
    
    var state           : Int?
    
    var info            : SYBookIntroModel?
    
    var bookcase        : SYBookcaseModel?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &bid, name: "id")
        mapper.specify(property: &bookLength, name: "booklength")
        mapper.specify(property: &bookTitle, name: "booktitle")
        mapper.specify(property: &intro, name: "Introduction")
    }
    
}

class SYBookIntroModel: HandyJSON {
    
    var introduction: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &introduction, name: "Introduction")
    }
    
}


class SYBookcaseModel: HandyJSON {
    
    var title: String!
    
    var cid: String!
    
    var orders: Int!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &title, name: "Title")
        mapper.specify(property: &orders, name: "Orders")
    }
    
}
