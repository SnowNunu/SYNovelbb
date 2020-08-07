//
//  SYSearchModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYSearchModel: HandyJSON, Codable {
    
    var readTxt: String?
    
    var readLable: String?
    
    var sid: String?
    
    var bookTitle: String?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &sid, name: "id")
        mapper.specify(property: &bookTitle, name: "booktitle")
    }
}
