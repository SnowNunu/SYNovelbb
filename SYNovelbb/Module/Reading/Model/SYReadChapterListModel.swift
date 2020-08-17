//
//  SYReadChapterListModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadChapterListModel: NSObject,NSCoding {
    
    /// 章节ID
    @objc var id: NSNumber!

    /// 小说ID
    var bookID: String!
    
    /// 章节名称
    var name: String!
    
    /// 是否付费章节
    var isVip: Bool!
    
    /// 章节价格
    var chapterMoney: Int!
    
    /// 下一章id
    var nextID: String!
    
    /// 上一章id
    var prevID: String!
    
    // MARK: -- NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        bookID = aDecoder.decodeObject(forKey: "bookID") as? String
        id = aDecoder.decodeObject(forKey: "id") as? NSNumber
        name = aDecoder.decodeObject(forKey: "name") as? String
        isVip = aDecoder.decodeObject(forKey: "isVip") as? Bool
        chapterMoney = aDecoder.decodeObject(forKey: "chapterMoney") as? Int
        nextID = aDecoder.decodeObject(forKey: "nextID") as? String
        prevID = aDecoder.decodeObject(forKey: "prevID") as? String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(bookID, forKey: "bookID")
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(isVip, forKey: "isVip")
        aCoder.encode(chapterMoney, forKey: "chapterMoney")
        aCoder.encode(nextID, forKey: "nextID")
        aCoder.encode(prevID, forKey: "prevID")
    }
    
    init(_ dict:Any? = nil) {
        
        super.init()
        
        if dict != nil { setValuesForKeys(dict as! [String : Any]) }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
