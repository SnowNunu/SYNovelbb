//
//  CacheManager.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import YYCache

class CacheManager: NSObject {
    
    static let shared = CacheManager()
    
    var cache: YYCache! {
        let cache = YYCache(name: "SYNovelbbCache")
        cache?.memoryCache.countLimit = 50      // 内存最大缓存数据个数
        cache?.memoryCache.ageLimit = 60 * 30     // 设置缓存失效时间
        cache?.diskCache.costLimit = 10 * 1024  // 磁盘最大缓存开销
        cache?.diskCache.countLimit = 50        //磁盘最大缓存数据个数
        cache?.diskCache.autoTrimInterval = 60
        cache?.diskCache.ageLimit = 60 * 30     // 设置缓存失效时间
        return cache
    }

}
