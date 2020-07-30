//
//  SYMineSystemMsgVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineSystemMsgVM: RefreshVM<SYSystemMsgModel> {
    
    override init() {
        super.init()
        
        let model1 = SYSystemMsgModel()
        model1.isRead = true
        model1.contents = "You have 3 yuan cash reward to the account, enter my account to check the details, continue to invite friends, get up to 30 yuan reward!"
        model1.sendTime = "7-27 11:30"
        model1.fusername = "Official announcement"
        
        let model2 = SYSystemMsgModel()
        model2.isRead = false
        model2.contents = "You have 3 yuan cash reward to the account, enter my account to check the details, continue to invite friends, get up to 30 yuan reward!"
        model2.sendTime = "7-26 10:30"
        model2.fusername = "Official announcement"
    
        let model3 = SYSystemMsgModel()
        model3.isRead = false
        model3.contents = "You have 3 yuan cash reward to the account, enter my account to check the details, continue to invite friends, get up to 30 yuan reward!"
        model3.sendTime = "7-26 10:30"
        model3.fusername = "Official announcement"
        
        let models = [model1, model2, model3]
        datasource.accept(models)
    }

}
