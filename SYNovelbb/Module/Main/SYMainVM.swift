//
//  SYMainVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/5.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RealmSwift
import RxRelay

class SYMainVM: SYBaseVM {
    
    var userIsOK = BehaviorRelay<Bool>(value: false)
    
    override init() {
        super.init()
        reloadSubject.subscribe(onNext: { (bool) in
                self.requestData()
            })
            .disposed(by: disposeBag)
    }

    // 检查本地用户信息
    func checkLocalUserInfo() {
        let realm = try! Realm()
        try! realm.write() { [unowned self] in
            let results = realm.objects(SYUserModel.self)
            if results.count == 0 {
                // 尚未注册
                requestData()
            } else {
                self.userIsOK.accept(true)
            }
        }
    }
    
    // 执行游客登录流程
    func requestData() {
        SYProvider.rx.request(.touristLogin)
            .map(result: SYUserModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.data != nil {
                    let model = response.data!
                    model.token = response.token ?? ""
                    let realm = try! Realm()
                    try! realm.write() {
                        realm.add(model, update: .error)
                        self.requestStatus.accept((true, ""))
                        self.userIsOK.accept(true)
                    }
                }
            }) { [unowned self] (error) in
                print(error)
                self.requestStatus.accept((false, self.errorMessage(error)))
            }
            .disposed(by: disposeBag)
    }
    
}
