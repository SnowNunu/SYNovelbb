//
//  SYMineAccountVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RealmSwift
import RxRelay

class SYMineAccountVM: RefreshVM<SYMineAccountModel> {
    
    var userInfo = BehaviorRelay<SYUserModel>(value: SYUserModel())

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
    
    func updateUserInfo() {
        SYProvider.rx.request(.userInfo)
            .map(result: SYUserModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let model = response.data!
                        model.token = response.token!
                        let realm = try! Realm()
                        try! realm.write() {
                            realm.add(model, update: .modified)
                        }
                        self.userInfo.accept(model)
                    }
                }
            }) { (error) in
                print(error)
            }
            .disposed(by: disposeBag)
    }

}
