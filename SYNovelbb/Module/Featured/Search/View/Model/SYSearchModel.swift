//
//  SYSearchModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON
import RealmSwift

class SYSearchModel: Object, HandyJSON, Codable {
    
    @objc dynamic var readTxt: String?
    
    @objc dynamic var readLable: String?
    
    @objc dynamic var id: String?
    
    @objc dynamic var booktitle: String?
    
    @objc dynamic var keyword: String?
    
    required init() {}
    
    override class func primaryKey() -> String? {
        return "keyword"
    }
    
}
