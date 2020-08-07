//
//  CacheManager.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Cache

class CacheManager: NSObject {

    let storage = try? Storage(
        diskConfig: DiskConfig(
            name: "Novellbb",
            expiry: .date(Date().addingTimeInterval(2 * 3600)),
            maxSize: 10000,
            directory: try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Cache"),
            protectionType: .complete
        ),
        memoryConfig: MemoryConfig(
            expiry: .date(Date().addingTimeInterval(30 * 60)),
            countLimit: 50,
            totalCostLimit: 0
        ),
        transformer: TransformerFactory.forCodable(ofType: SYSearchModel.self)
    )

}
