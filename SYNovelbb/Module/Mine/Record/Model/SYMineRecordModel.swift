//
//  SYMineRecordModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/3.
//  Copyright © 2020 Mandora. All rights reserved.
//

import HandyJSON

class SYMineRecordModel: HandyJSON {
    
    var rid: String!
    
    var payAmount: String!
    
    var orderNumber: String!
    
    var isSuccess: Bool!
    
    var pType: String!
    
    var addtime: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &rid, name: "id")
    }

}
