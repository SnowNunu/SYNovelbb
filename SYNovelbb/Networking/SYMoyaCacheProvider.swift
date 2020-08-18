//
//  SYMoyaCacheProvider.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Moya
import RxSwift
import RealmSwift

public extension Reactive where Base: MoyaProviderType {
    
    /*
        缓存部分不会经常变化的接口
        直接返回缓存结果，不会再去请求接口后刷新缓存
     */
    func cacheRequest(_ token: Base.Target, cacheType: CacheKeyType, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        let realm = try! Realm()
        var hasCache: Bool
        let predicate = NSPredicate(format: "key = %@", token.fetchCacheKey(cacheType).md5)
        let result = realm.objects(CacheObject.self).filter(predicate)
        if result.count == 1 {
            // 有数据
            let object = result.first!
            if object.expireTime.compare(Date()) == .orderedAscending {
                // 当前对象已经失效
                hasCache = false
            } else {
                hasCache = true
            }
        } else {
            hasCache = false
        }
        if hasCache {
            // 有缓存数据且在有效时间内
            let predicate = NSPredicate(format: "key = %@", token.fetchCacheKey(cacheType).md5)
            let result = realm.objects(CacheObject.self).filter(predicate)
            let data = result.first?.data
            if data == nil {
                logError("缓存读取出错")
                return getResponse(token, cacheType: cacheType, callbackQueue: callbackQueue)
            } else {
                let cacheResp = Response(statusCode: 230, data: data!)
                return Single.just(cacheResp)
            }
        } else {
            return getResponse(token, cacheType: cacheType, callbackQueue: callbackQueue)
        }
    }
    
    func getResponse(_ token: Base.Target, cacheType: CacheKeyType, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return Single.create { [weak base] single in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    let object = CacheObject()
                    object.key = token.fetchCacheKey(cacheType).md5
                    object.data = response.data
                    object.expireTime = Date().addingTimeInterval(3600)
                    let realm = try! Realm()
                    try! realm.write() {
                        realm.add(object, update: .modified)
                        single(.success(response))
                    }
                case let .failure(error):
                    single(.error(error))
                }
            }
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    
}

class CacheObject: Object {
    
    @objc dynamic var key: String!
    
    @objc dynamic var data: Data!
    
    @objc dynamic var expireTime: Date!
    
    override class func primaryKey() -> String? {
        return "key"
    }
    
}
