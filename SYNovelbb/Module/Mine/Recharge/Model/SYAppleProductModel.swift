//
//  SYAppleProductModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/31.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYAppleProductModel: HandyJSON {
    
    /// 提交下单接口时需传的值
    var key: String!
    
    /// 支付类型
    var value: String!
    
    var level: String!
    
    var ids: String!
    
    var money: String!
    
    var give: String!
    
    /// 得到的金币数百分比
    var percent: Float! {
        get {
            return NSString(string: level).floatValue / 100.0
        }
    }
    
    /// 商品id数组
    var productArray: [String] {
        get {
            return ids.components(separatedBy: ",")
        }
    }
    
    // 金币数组
    var coinsArray: [String] {
        get {
            let moneys = money.components(separatedBy: ",")
            var array = [String]()
            for money in moneys {
                let coins = (ceil(NSString(string: money).floatValue) * 100) * percent
                array.append("\(Int(coins))")
            }
            return array
        }
    }
    
    /// 赠送金币数组
    var givingArray: [String] {
        get {
            return give.components(separatedBy: ",")
        }
    }
    
    /// 价格数组
    var moneyArray: [String] {
        get {
            return money.components(separatedBy: ",")
        }
    }
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &key, name: "Key")
        mapper.specify(property: &value, name: "Value")
        mapper.specify(property: &ids, name: "id")
        mapper.specify(property: &money, name: "Moneys")
        mapper.specify(property: &give, name: "Give")
    }

}
