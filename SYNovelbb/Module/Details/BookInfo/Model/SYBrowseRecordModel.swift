
//
//  SYBrowseRecordModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RealmSwift

class SYBrowseRecordModel: Object {
    
    /// 书籍id
    @objc dynamic var bookId: String!
    
    /// 书籍类型
    @objc dynamic var tClass: String!
    
    /// 书籍名称
    @objc dynamic var bookTitle: String!
    
    /// 书籍作者
    @objc dynamic var author: String?
    
    /// 书籍长度
    @objc dynamic var bookLength: String!
    
    /// 书籍状态
    @objc dynamic var state: Int = 0
    
    /// 书籍封面
    @objc dynamic var cover: String!
    
    /// 是否会员书籍
    @objc dynamic var isVip: Bool = true
    
    /// 上次浏览时间
    @objc dynamic var lastBrowse: NSDate!
    
    /// 书籍标签
    @objc dynamic var labels: String?
    
    /// 当前阅读到的章节id
    @objc dynamic var chapterId: String?
    
    /// 当前阅读到的章节标题
    @objc dynamic var chapterTitle: String?
    
    /// 用户id
    @objc dynamic var uid: String!
    
    /// 当前阅读到的具体页码
    @objc dynamic var page: Int = 0
    
    override class func primaryKey() -> String? {
        return "bookId"
    }

}
