//
//  Bundle+Extension.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

extension Bundle {
    
    /// 获取工程名字
    var projectName: String {
        get {
            return self.object(forInfoDictionaryKey: kCFBundleExecutableKey as String) as! String
        }
    }
    
    /// 构建版本号
    var buildVersion: String {
        get {
            return self.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
        }
    }
    
    /// app版本号
    var version: String {
        get {
            return self.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        }
    }
    
    /// app 名称
    var appName: String {
        get {
            if self.object(forInfoDictionaryKey: "CFBundleExecutable") == nil {
                return "Novelbb"
            } else {
                return self.object(forInfoDictionaryKey: "CFBundleExecutable") as! String
            }
        }
    }
    
}
