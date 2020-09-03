//
//  SYApplePurchaseModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/9/2.
//  Copyright © 2020 Mandora. All rights reserved.
//

import RealmSwift

class SYApplePurchaseModel: Object {
    
    /// 用户id
    @objc dynamic var uid: String!
    
    /// 订单id(服务端)
    @objc dynamic var orderNum: String!
    
    /// 交易凭证
    @objc dynamic var receiptData: Data!
    
    /// 订购时间
    @objc dynamic var purchaseDate: Date!
    
    /// 商品价格
    @objc dynamic var price: String!
    
    /// 商品id
    @objc dynamic var productId: String!
    
    /// 交易id(Itunes)
    @objc dynamic var transactionId: String!
    
    /// 订单状态(0->尚未支付,1->已支付未校验,2->已支付且校验成功,3->已支付校验失败)
    @objc dynamic var status: String!
    
    override class func primaryKey() -> String? {
        return "orderNum"
    }

}
