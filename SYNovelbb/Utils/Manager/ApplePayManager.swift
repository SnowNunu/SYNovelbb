//
//  ApplePayManager.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/9/2.
//  Copyright © 2020 Mandora. All rights reserved.
//

import StoreKit
import RxSwift
import RxRelay
import SwiftyStoreKit
import MBProgressHUD
import HandyJSON
import RealmSwift

class ApplePayManager {

    public static let share = ApplePayManager()
    
    // 当次购买的订单号
    fileprivate var orderNumber: String = ""
    
    fileprivate let disposeBag = DisposeBag()
    
    // 发起支付前先判断能否发起支付
    public func checkPay(_ model: SYMineRechargeModel) {
        if SwiftyStoreKit.canMakePayments {
            startPay(model)
        } else {
            MBProgressHUD.show(message: "In-app payment is not allowed", toView: nil)
        }
    }
    
    /// 开始支付流程
    private func startPay(_ model: SYMineRechargeModel) {
        MBProgressHUD.showLoading(message: "Connecting to iTunes,\nplease don't quit!", toView: nil)
        orderNumber = ""    // 重置订单号
        SwiftyStoreKit.retrieveProductsInfo([model.productId]) { [unowned self] (result) in
            if let product = result.retrievedProducts.first {
                self.requestOrderNumber(product, model.price)
            } else if let invalidProductId = result.invalidProductIDs.first {
                print("Invalid product identifier: \(invalidProductId)")
            } else {
                MBProgressHUD.dismiss()
                MBProgressHUD.show(message: "Product identifier is invalid", toView: nil)
                print("Error: \(String(describing: result.error))")
            }
        }
    }
    
    /// 向服务器请求订单号
    private func requestOrderNumber(_ product: SKProduct, _ price: String) {
        SYProvider.rx.request(.orderNum(price: price)).map(result: SYOrderNumModel.self)
            .subscribe(onSuccess: { [unowned self] result in
                if self.orderNumber.isEmpty == false {
                    MBProgressHUD.dismiss()
                    logInfo("已经有这个订单了")
                    return
                }
                guard let model = result.data else {
                    MBProgressHUD.dismiss()
                    MBProgressHUD.show(message: "Failed to get order, please buy again!", toView: nil)
                    return
                }
                if model.orderNumber.isEmpty == true || model.orderNumber == nil {
                    MBProgressHUD.dismiss()
                    MBProgressHUD.show(message: "Failed to get order, please buy again!", toView: nil)
                    return
                }
                self.orderNumber = model.orderNumber
                /// 先记录订单号
                let purchase = SYApplePurchaseModel()
                purchase.orderNum = self.orderNumber
                purchase.price = price
                purchase.productId = product.productIdentifier
                purchase.status = "0"
                let realm = try! Realm()
                try! realm.write() {
                    realm.add(purchase, update: .modified)
                    self.requestApplePay(product, orderNum: self.orderNumber)
                }
            }) { error in
                MBProgressHUD.dismiss()
                MBProgressHUD.show(message: "Failed to get the order number!", toView: nil)
            }
            .disposed(by: disposeBag)
    }
    
    /// 请求iTunes拉起支付
    private func requestApplePay(_ product: SKProduct, orderNum: String) {
        /// 这个方法进入回调后就会完成finishTransaction的操作无论atomically的值是否为真
        let realm = try! Realm()
        let user = realm.objects(SYUserModel.self).first!
        SwiftyStoreKit.purchaseProduct(product, quantity: 1, atomically: false, applicationUsername: "\(user.uid ?? "")#\(orderNum)", simulatesAskToBuyInSandbox: false) { (result) in
            switch result {
                case .success(let purchaseDetails):
                    // 接收到凭证后首先缓存到本地数据库
                    let predicate = NSPredicate(format: "orderNum = %@", orderNum)
                    let purchase = realm.objects(SYApplePurchaseModel.self).filter(predicate).first
                    if purchase != nil {
                        try! realm.write() {
                            purchase!.receiptData = SwiftyStoreKit.localReceiptData!
                            purchase!.transactionId = purchaseDetails.transaction.transactionIdentifier
                            purchase?.status = "1"
                            realm.add(purchase!, update: .modified)
                        }
                    }
                    
                    var string = SwiftyStoreKit.localReceiptData!.base64EncodedString(options: .endLineWithLineFeed)
                    string = string.replacingOccurrences(of: "\n", with: "")
                    string = string.replacingOccurrences(of: "\r", with: "")
                    string = string.replacingOccurrences(of: "+", with: "%2B")
                    self.requestVerifyResult(receiptString: string, transactionId: purchaseDetails.transaction.transactionIdentifier!, orderNum: self.orderNumber)
                    if purchaseDetails.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(purchaseDetails.transaction)
                    }
                    print("Purchase Success: \(purchaseDetails.productId)")
                case .error(let error):
                    MBProgressHUD.dismiss()
                    let predicate = NSPredicate(format: "orderNum = %@", orderNum)
                    let purchase = realm.objects(SYApplePurchaseModel.self).filter(predicate).first
                    if purchase != nil {
                        try! realm.write() {
                            realm.delete(purchase!) // 删除无效订单
                        }
                    }
                    switch error.code {
                        case .unknown:
                            MBProgressHUD.show(message: "Unknown error. Please contact support", toView: nil)
                        case .clientInvalid:
                            MBProgressHUD.show(message: "Not allowed to make the payment", toView: nil)
                        case .paymentCancelled:
                            MBProgressHUD.show(message: "You have cancelled payment!", toView: nil)
                        case .paymentInvalid:
                            MBProgressHUD.show(message: "The purchase identifier was invalid!", toView: nil)
                        case .paymentNotAllowed:
                            MBProgressHUD.show(message: "The device is not allowed to make the payment", toView: nil)
                        case .storeProductNotAvailable:
                            MBProgressHUD.show(message: "The product is not available in the current storefront", toView: nil)
                        case .cloudServicePermissionDenied:
                            MBProgressHUD.show(message: "Access to cloud service information is not allowed", toView: nil)
                        case .cloudServiceNetworkConnectionFailed:
                            MBProgressHUD.show(message: "Could not connect to the network", toView: nil)
                        case .cloudServiceRevoked:
                            MBProgressHUD.show(message: "User has revoked permission to use this cloud service", toView: nil)
                        default:
                            print((error as NSError).localizedDescription)
                    }
                }
        }
    }
    
    /// 校验支付凭证
    private func requestVerifyResult(receiptString: String, transactionId: String, orderNum: String) {
        SYProvider.rx.request(.verifyReceipt(receiptString: receiptString, transactionId: transactionId, orderNum: orderNum))
            .map(resultList: SYAppleVerifyModel.self)
            .subscribe(onSuccess: { result in
                if result.data!.count > 0 {
                    MBProgressHUD.dismiss()
                    for model in result.data! {
                        let realm = try! Realm()
                        let predicate = NSPredicate(format: "orderNum = %@", orderNum)
                        let purchase = realm.objects(SYApplePurchaseModel.self).filter(predicate).first
                        
                        if model.isSuccess {
                            MBProgressHUD.show(message: "Congratulations on your successful recharge!", toView: nil)
                            if purchase != nil {
                                try! realm.write {
                                    purchase!.status = "2"
                                    realm.add(purchase!, update: .modified)
                                }
                            }
                        } else {
                            MBProgressHUD.show(message: "Credential verification failed!", toView: nil)
                            if purchase != nil {
                                try! realm.write {
                                    purchase!.status = "3"
                                    realm.add(purchase!, update: .modified)
                                }
                            }
                        }
                    }
                }
            }).disposed(by: disposeBag)
    }

}
