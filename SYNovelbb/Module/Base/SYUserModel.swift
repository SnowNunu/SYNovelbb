//
//  SYUserModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/5.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RealmSwift
import HandyJSON

class SYUserModel: Object, HandyJSON {
    
    @objc dynamic var uid: String!
    
    @objc dynamic var account: String!
    
    @objc dynamic var nickname: String!
    
    @objc dynamic var integration = 0
    
    @objc dynamic var vipMoney = 0

    @objc dynamic var avatar: String!
    
    @objc dynamic var lastLoginTime: String!
    
    @objc dynamic var userVip = 0
    
    @objc dynamic var diamonds = 0
    
    @objc dynamic var oType = 0
    
    @objc dynamic var isPaying = false
    
    @objc dynamic var groupId = 0
    
    @objc dynamic var bookcase = 0
    
    @objc dynamic var token: String!
    
    required init() {}
    
    override class func primaryKey() -> String? {
        return "uid"
    }
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &integration, name: "Integration")
        mapper.specify(property: &avatar, name: "Avatar")
        mapper.specify(property: &userVip, name: "uservip")
        mapper.specify(property: &diamonds, name: "Diamonds")
        mapper.specify(property: &groupId, name: "groupid")
    }
    
}
