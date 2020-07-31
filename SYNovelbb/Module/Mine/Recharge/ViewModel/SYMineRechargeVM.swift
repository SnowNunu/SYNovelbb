//
//  SYMineRechargeVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYMineRechargeVM: RefreshVM<SectionModel<String, SYMineRechargeModel>> {

    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.productIds)
            .map(resultList: SYAppleProductModel.self)
            .subscribe(onSuccess: { (response) in
                if response.success {
                    if response.data != nil {
                        let data = response.data!.first!
                        var models = [SYMineRechargeModel]()
                        for (index, value) in data.productArray.enumerated() {
                            let model = SYMineRechargeModel.init(productId: value, price: data.moneyArray[index], coins: data.coinsArray[index], vouchers: data.givingArray[index])
                            models.append(model)
                        }
                        self.updateRefresh(true, [SectionModel.init(model: "recharge", items: models)], 1)
                        
                    }
                }
        }) { (error) in
            
        }.disposed(by: disposeBag)
    }
    
}
