//
//  SYMineSubscriptionVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYMineSubscriptionVM: RefreshVM<SYAutoSubscriptionModel> {
    
    override init() {
        super.init()
        let model = SYAutoSubscriptionModel()
        model.booktitle = "I wait for you with acacia"
        model.author = "Daydreaming"
        model.cover = "https://api.novelbb.com/cover/0/78.jpg"
        datasource.accept([model, model, model, model])
    }

}
