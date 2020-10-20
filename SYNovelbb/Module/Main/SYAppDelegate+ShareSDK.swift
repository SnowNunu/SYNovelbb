//
//  SYAppDelegate+ShareSDK.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Foundation

extension SYAppDelegate {
    
    
    func setupShareSDK() {
        WXApi.startLog(by: .detail) { (string) in
            print(string)
        }
        print(WXApi.registerApp("wxa948d75243236892", universalLink: "https://fdgs6.share2dlink.com/"))    // 注册微信
//        WXApi.checkUniversalLinkReady { (step, result) in
//            print(step)
//            print(result)
//        }
        
    }
    
    
}
