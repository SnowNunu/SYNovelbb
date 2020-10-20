//
//  QMRedirectModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class QMRedirectModel: HandyJSON {
    
    var id: NSInteger!
    
    var bookPageId: NSInteger!
    
    var redirectType: NSInteger!
    
    var redirectUrl: String!

    var time: String?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &bookPageId, name: "book_page_id")
        mapper.specify(property: &redirectType, name: "redirect_type")
        mapper.specify(property: &redirectUrl, name: "redirect_url")
    }

}
