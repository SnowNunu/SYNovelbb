//
//  SYGenderIndexModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYGenderIndexModel: HandyJSON {
    
    var title: String!
    
    var subTitle: String?
    
    var module: String?
    
    var data: [SYIndexModel]!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &title, name: "Title")
        mapper.specify(property: &subTitle, name: "SubTitle")
        mapper.specify(property: &module, name: "Module")
        mapper.specify(property: &data, name: "Data")
    }

}
