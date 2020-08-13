//
//  SYChapterModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/13.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYChapterModel: HandyJSON {
    
    /// 章节id
    var cid: String!
    
    /// 卷名
    var volumeTitle: String?
    
    /// 章节名
    var title: String!
    
    /// 是否VIP才能阅读(暂时无用)
    var isVip: Bool!
    
    /// 章节内容长度
    var length: Int!
    
    /// 订阅人数
    var orders: Int!
    
    /// 最近更新时间
    var lastUpdate: String!
    
    /// 当前章节价格(0为免费为已付费过)
    var chapterMoney: Int!
    
    /// 下一章id
    var nextID: String!
    
    /// 上一章id
    var prevID: String!
    
    /// 章节内容
    var contents: String?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &cid, name: "id")
        mapper.specify(property: &title, name: "Title")
        mapper.specify(property: &length, name: "chargeLength")
        mapper.specify(property: &orders, name: "Orders")
        mapper.specify(property: &nextID, name: "NextID")
        mapper.specify(property: &prevID, name: "PrevID")
        mapper.specify(property: &contents, name: "Contents")
    }

}
