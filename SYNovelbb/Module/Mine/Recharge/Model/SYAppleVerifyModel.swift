//
//  SYAppleVerifyModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/9/2.
//  Copyright © 2020 Mandora. All rights reserved.
//

import HandyJSON

class SYAppleVerifyModel: HandyJSON {
    
    /// apple支付订单号
    var trade_no: String!
    
    /// 订单校验结果
    var isSuccess: Bool!
    
    required init() {}

}
