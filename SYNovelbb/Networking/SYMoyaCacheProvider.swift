//
//  SYMoyaCacheProvider.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Moya
import RxSwift
import Cache

public extension Reactive where Base: MoyaProviderType {
    
    /*
        缓存部分不会经常变化的接口
        直接返回缓存结果，不会再去请求接口后刷新缓存
     */
    func cacheRequest(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        let hasCache = try! CacheManager().storage?.transformData().existsObject(forKey: token.baseURL.absoluteString + token.path)
        if hasCache! {
            var cacheResponse: Response? = nil
            cacheResponse = fetchResponseCache(token: token)
            return Single.just(cacheResponse!)
        } else {
            return Single.create { [weak base] single in
                let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                    switch result {
                    case let .success(response):
                        
                        try? CacheManager().storage?.transformData().setObject(response.data, forKey: token.baseURL.absoluteString + token.path)
                        single(.success(response))
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
    
    func fetchResponseCache(token: TargetType) -> Moya.Response? {
        let data = try? CacheManager().storage?.transformData().object(forKey: token.baseURL.absoluteString + token.path)
        let cacheResp = Response(statusCode: 230, data: data ?? Data())
        return cacheResp
    }
    
}
