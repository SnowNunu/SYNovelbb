//
//  SYMineRechargeModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/31.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

struct SYMineRechargeModel {
    
    var productId: String!
    
    var price: String!
    
    var content: String!
    
    var selected = true
    
    init(productId: String!, price: String!, coins: String!, vouchers: String) {
        self.price = price
        if vouchers == "0" {
            self.content = "\(String(describing: coins!)) coins"
        } else {
            self.content = "\(String(describing: coins!)) coins + \(vouchers) vouchers"
        }
    }
}

