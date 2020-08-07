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
    
    @objc dynamic var Integration = 0
    
    @objc dynamic var vipMoney = 0
    
    @objc dynamic var Avatar: String!
    
    @objc dynamic var lastLoginTime: String!
    
    @objc dynamic var uservip = 0
    
    @objc dynamic var Diamonds = 0
    
    @objc dynamic var oType = 0
    
    @objc dynamic var isPaying = false
    
    @objc dynamic var groupid = 0
    
    @objc dynamic var bookcase = 0
    
    @objc dynamic var token: String!
    
    required init() {}
    
    
    override class func primaryKey() -> String? {
        return "uid"
    }
    
    /// HandyJSON不支持dynamic，因此mapping会失败
//    func mapping(mapper: HelpingMapper) {
//        mapper.specify(property: &integration, name: "Integration")
//        mapper.specify(property: &avatar, name: "Avatar")
//        mapper.specify(property: &userVip, name: "uservip")
//        mapper.specify(property: &diamonds, name: "Diamonds")
//        mapper.specify(property: &groupId, name: "groupid")
//    }
    
}
