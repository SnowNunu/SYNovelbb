//
//  SYPageModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYPageModel: NSObject {
    
    // 当前页数
    lazy var currentPage  = 1
    
    // 总共分页数
    lazy var totalPage    = 1
    
    // 每页多少条数据
    lazy var pageSize     = 20
    
    // 总共数据条数
    lazy var total        = 1

    public var hasNext: Bool {
        get {
            totalPage = (total / pageSize) + (total % pageSize == 0 ? 0 : 1)
            return currentPage < totalPage
        }
    }
    
    // 发起请求前调用
    public func setupCurrentPage(refresh: Bool = true) {
        currentPage = refresh ? 1 : currentPage + 1
    }
}
