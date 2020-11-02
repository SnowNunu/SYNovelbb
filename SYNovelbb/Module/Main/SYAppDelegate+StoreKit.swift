//
//  SYAppDelegate+StoreKit.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/9/3.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Foundation
import SwiftyStoreKit
import RxSwift
import RealmSwift

extension SYAppDelegate {
    
    /// 启动内购单据监听
    func setupStoreKit() {
        SwiftyStoreKit.completeTransactions(atomically: false) { purchases in
            for purchase in purchases {
                switch purchase.transaction.transactionState {
                    case .purchased, .restored:
                        // 这里先得查找本地的预订单号
                        if purchase.needsFinishTransaction {
                            let realm = try! Realm()
                            let predicate = NSPredicate(format: "productId = %@ AND status = '0'", purchase.productId)
                            let model = realm.objects(SYApplePurchaseModel.self).filter(predicate).sorted(byKeyPath: "purchaseDate", ascending: false).first
                            if model != nil {
                                model!.receiptData = SwiftyStoreKit.localReceiptData!
                                model!.status = "1"
                                model!.transactionId = purchase.transaction.transactionIdentifier
                                realm.add(model!, update: .modified)
                            } else {
                                // 数据库中未找到相符合的订单
                            }
                            SwiftyStoreKit.finishTransaction(purchase.transaction)
                        }
                    case .failed, .purchasing, .deferred:
                        break // do nothing
                }
            }
        }
        startOrderMonitor()
    }
    
    /// 监听支付成功未校验的订单
    func startOrderMonitor() {
        timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(60))
        timer.setEventHandler(handler: { [unowned self] in
            let realm = try! Realm()
            let predicate = NSPredicate(format: "status = '1'")
            let purchases = realm.objects(SYApplePurchaseModel.self).filter(predicate)
            if purchases.count > 0 {
                for purchase in purchases {
                    var string = purchase.receiptData.base64EncodedString(options: .endLineWithLineFeed)
                    string = string.replacingOccurrences(of: "\n", with: "")
                    string = string.replacingOccurrences(of: "\r", with: "")
                    string = string.replacingOccurrences(of: "+", with: "%2B")
                    self.requestVerifyResult(receiptString: string, transactionId: purchase.transactionId, orderNum: purchase.orderNum)
                }
            }
        })
        timer.resume()
    }
    
    /// 校验支付凭证
    func requestVerifyResult(receiptString: String, transactionId: String, orderNum: String) {
        SYProvider.rx.request(.verifyReceipt(receiptString: receiptString, transactionId: transactionId, orderNum: orderNum))
            .debug()
            .map(resultList: SYAppleVerifyModel.self)
            .subscribe(onSuccess: { result in
                if result.data!.count > 0 {
                    for model in result.data! {
                        let realm = try! Realm()
                        let predicate = NSPredicate(format: "orderNum = %@", orderNum)
                        let purchase = realm.objects(SYApplePurchaseModel.self).filter(predicate).first
                        
                        if model.isSuccess {
                            if purchase != nil {
                                try! realm.write {
                                    purchase!.status = "2"
                                    realm.add(purchase!, update: .modified)
                                }
                            }
                        } else {
                            if purchase != nil {
                                try! realm.write {
                                    purchase!.status = "3"
                                    realm.add(purchase!, update: .modified)
                                }
                            }
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
}
