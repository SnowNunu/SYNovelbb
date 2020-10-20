//
//  QMBookcaseListModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Foundation
import HandyJSON

class QMBookcaseListModel: HandyJSON {
    
    var bookId: NSInteger!
    
    var bookName: String!
    
    var bookDescript: String!
    
    var bookAuthor: String!
    
    var bookType: NSInteger!
    
    var bookImaUrl: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &bookId, name: "book_id")
        mapper.specify(property: &bookName, name: "book_name")
        mapper.specify(property: &bookDescript, name: "book_descript")
        mapper.specify(property: &bookAuthor, name: "book_author")
        mapper.specify(property: &bookType, name: "book_type")
        mapper.specify(property: &bookImaUrl, name: "book_img_url")
    }
    
}
