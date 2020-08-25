//
//  SYCommentModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/25.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYCommentModel: HandyJSON {
    
    var commentId: String!
    
    var bid: String!
    
    var cid: String!
    
    var uid: String!
    
    var username: String!
    
    var title: String!
    
    var replyCount: Int!
    
    var viewCount: Int!
    
    var postTime: String!
    
    var isDigset: Bool!
    
    var isTop: Bool!
    
    var contents: String!
    
    var replay: [SYReplayModel]?
    
    var isVip: Bool!
    
    var isAuthor: Bool!
    
    var vip: String!
    
    var avatar: String!
    
    var goupTitle: String!
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &commentId, name: "id")
        mapper.specify(property: &title, name: "Title")
        mapper.specify(property: &replay, name: "Replay")
        mapper.specify(property: &isVip, name: "IsVip")
        mapper.specify(property: &isAuthor, name: "IsAuthor")
        mapper.specify(property: &vip, name: "Vip")
        mapper.specify(property: &avatar, name: "Avatar")
    }

}
