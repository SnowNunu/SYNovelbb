//
//  QMUserLoginModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/21.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class QMUserLoginModel: HandyJSON {
    
    var id: String!
    
    var phoneCode: String!
    
    var ua: String!
    
    var ip: String!
    
    var adParams: String?
    
    var phoneTime: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &phoneCode, name: "phone_code")
        mapper.specify(property: &adParams, name: "ad_params")
        mapper.specify(property: &phoneTime, name: "phone_time")
    }

}
