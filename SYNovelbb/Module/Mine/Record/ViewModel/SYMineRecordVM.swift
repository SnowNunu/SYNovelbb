//
//  SYMineRecordVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYMineRecordVM: RefreshVM<SYMineRecordModel> {
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
//        https://api.novelbb.com/1/qw/logPay?PageSize=10&pageIndex=1&token=ff314716fb66ea6e830934d1ec7ce648%2C164%2C1596453719&uid=164
    }
    
}
