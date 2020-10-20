//
//  SYResponseModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

// 基类
class SYModel: NSObject, HandyJSON {
    
    func mapping(mapper: HelpingMapper) {}
    
    required override init() {}
}

// MARK: 响应类
class SYResponseModel<T>: SYModel {
    
    var message: MessageModel!
    
    var success: Bool!
    
    var token: String?
    
    var total: NSInteger? = 0
    
    var data: T?
        
    override func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &message, name: "Message")
        mapper.specify(property: &success, name: "Success")
        mapper.specify(property: &token, name: "Token")
        mapper.specify(property: &total, name: "Total")
    }
}

// MARK: 超级书架响应类
class QMResponseModel<T>: SYModel {
    
    /// 响应码
    var code: NSInteger!
    
    /// (分页时总数量)
    var count: NSInteger? = 0
    
    /// 核心数据
    var data: T?
    
}

// MARK: 请求返回错误信息类model
class MessageModel: SYModel {
   
    var code: Int? = 0
    var content: String = "未知错误"

    override func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &code, name: "Code")
        mapper.specify(property: &content, name: "Content")
    }
}
