//
//  SYGenderModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYGenderModel: HandyJSON {
    
    var slide: [SYIndexModel]!
    
    var index1: SYGenderIndexModel!
    
    var index2: SYGenderIndexModel!
    
    var index3: SYGenderIndexModel!
    
    var updateList: SYGenderIndexModel!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &index1, name: "index_1")
        mapper.specify(property: &index2, name: "index_2")
        mapper.specify(property: &index3, name: "index_3")
    }
}
