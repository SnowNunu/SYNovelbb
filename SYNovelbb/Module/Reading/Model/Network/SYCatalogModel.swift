//
//  SYCatalogModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/17.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYCatalogModel: HandyJSON {
    
    var catalogId: String!
    
    var volumeTitle: String!
    
    var volumeOrder: String!

    var volumeLength: String!
    
    var chapters: [SYChapterModel]!

    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &catalogId, name: "id")
        mapper.specify(property: &volumeLength, name: "volumeLenght")
    }
    
}
