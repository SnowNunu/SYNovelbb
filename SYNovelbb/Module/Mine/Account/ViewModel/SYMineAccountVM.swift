//
//  SYMineAccountVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineAccountVM: RefreshVM<SYMineAccountModel> {

    override init() {
        super.init()
        let models = [
            SYMineAccountModel.init(title: "Recward record", type: .top),
            SYMineAccountModel.init(title: "Subscription records", type: .none),
            SYMineAccountModel.init(title: "My comments", type: .none),
            SYMineAccountModel.init(title: "Gift money record", type: .bottom)
        ]
        datasource.accept(models)
    }

}
