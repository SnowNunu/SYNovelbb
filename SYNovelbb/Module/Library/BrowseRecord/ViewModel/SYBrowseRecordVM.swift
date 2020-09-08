
//
//  SYBrowseRecordVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/9/4.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RealmSwift

class SYBrowseRecordVM: RefreshVM<SYBrowseRecordModel> {
    
    override init() {
        super.init()
    }
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        let realm = try! Realm()
        let array = realm.objects(SYBrowseRecordModel.self)
        var temp = [SYBrowseRecordModel]()
        for model in array {
            temp.append(model)
        }
        self.updateRefresh(refresh, temp, temp.count)
//        if array.count > 0 {
//
//        }
    }

}
