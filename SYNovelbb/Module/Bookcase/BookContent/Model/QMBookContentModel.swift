//
//  QMBookContentModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class QMBookContentModel: HandyJSON {
    
    var id: NSInteger!
    
    var bookId: NSInteger!
    
    var bookPageNum: NSInteger!
    
    var bookPageName: String!
    
    var bookPageContent: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &bookId, name: "book_id")
        mapper.specify(property: &bookPageNum, name: "book_page_num")
        mapper.specify(property: &bookPageName, name: "book_page_name")
        mapper.specify(property: &bookPageContent, name: "book_page_content")
    }

}
