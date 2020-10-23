//
//  QMJPushModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/21.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class QMJPushModel: HandyJSON {
    
    var userId: NSInteger!
    
    var phoneCode: String!
    
    var ip: String!
    
    var ua: String!
    
    var phoneTime: String!
    
    var wxSmallStatus: NSInteger!
    
    var wxSmallTime: NSInteger!
    
    var lastReadBookId: NSInteger!
    
    var lastReadBookNum: NSInteger!
    
    var adParams: String!
    
    var jpushId: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &phoneCode, name: "phone_code")
        mapper.specify(property: &userId, name: "user_id")
        mapper.specify(property: &phoneTime, name: "phone_time")
        mapper.specify(property: &wxSmallStatus, name: "wx_small_status")
        mapper.specify(property: &wxSmallTime, name: "wx_small_time")
        mapper.specify(property: &lastReadBookId, name: "last_read_book_id")
        mapper.specify(property: &lastReadBookNum, name: "last_read_book_num")
        mapper.specify(property: &adParams, name: "ad_params")
        mapper.specify(property: &jpushId, name: "jpush_id")
    }

}
