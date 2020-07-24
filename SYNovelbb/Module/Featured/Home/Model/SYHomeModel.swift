//
//  SYHomeModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYHomeModel: HandyJSON {

    var slide: [SYIndexModel]!

    var index1: [SYIndexModel]!

    var index2: [SYIndexModel]!

    var index3: [SYIndexModel]!

    required init() {}

    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &index1, name: "index_1")
        mapper.specify(property: &index2, name: "index_2")
        mapper.specify(property: &index3, name: "index_3")
    }
}
