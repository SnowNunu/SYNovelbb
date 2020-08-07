//
//  SYMineCenterVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RealmSwift

class SYMineCenterVM: RefreshVM<SectionModel<String, SYMineCenterModel>> {
    
    public let enterNextView = PublishSubject<IndexPath>()
    
    var segueIds: [[String]] = []
    
    private weak var owner: SYMineCenterVC!
    
    init(_ owner: SYMineCenterVC) {
        super.init()
        self.owner = owner
        
        enterNextView.subscribe(onNext: { [unowned self] (indexPath) in
                let segueId = self.segueIds[indexPath.section][indexPath.row]
                self.owner.performSegue(withIdentifier: segueId, sender: self.owner)
            })
            .disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        
        let models = [
            SectionModel.init(model: "Section1", items: [
                SYMineCenterModel.init(R.image.mine_center_record(), "Recharge record", nil),
                SYMineCenterModel.init(R.image.mine_center_account(), "My account", nil),
                SYMineCenterModel.init(R.image.mine_center_subscription(), "Automatic subscription", nil)
            ]),
            SectionModel.init(model: "Section2", items: [SYMineCenterModel.init(R.image.mine_center_recharge(), "Recharge", nil)]),
            SectionModel.init(model: "Section3", items: [
                SYMineCenterModel.init(R.image.mine_center_message(), "System messages", nil),
                SYMineCenterModel.init(R.image.mine_center_setting(), "Setting", nil)
            ])
        ]
        segueIds = [
            [
                "enterRecordView",
                "enterMyAccountView",
                "enterSubscriptionView"
            ],
            [
                "enterRechargeView"
            ],
            [
                "enterSystemMsgView",
                "enterSettingView"
            ]
        ]
        
        SYProvider.rx.request(.userInfo)
            .map(result: SYUserModel.self)
            .subscribe(onSuccess: { (response) in
                if response.success {
                    if response.data != nil {
                        let model = response.data!
                        model.token = response.token!
                        let realm = try! Realm()
                        try! realm.write() {
                            realm.add(model, update: .modified)
                        }
                    }
                }
                self.updateRefresh(true, models, 3)
            }) { (error) in
                print(error)
            }
            .disposed(by: disposeBag)
    }

}
