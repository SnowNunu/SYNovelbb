//
//  SYAppConfigs.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/22.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

/// 屏幕宽度
let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width

/// 屏幕高度
let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height

/// 导航栏高度
let NavgationBarHeight:CGFloat = 64

/// TabBar高度
let TabBarHeight:CGFloat = 49

/// StatusBar高度
let StatusBarHeight:CGFloat = 20

struct Configs {
    
    struct Network {
        // 开发环境
        static let dev_url = "https://api.novelbb.com"
        // 生产环境
        static let pro_url = "https://api.novelbb.com"
    }
    
    struct Dimensions {

        static let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        static let screenHeight: CGFloat = UIScreen.main.bounds.size.height
        static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        static let naviBarHeight: CGFloat = 44
        static let topHeight: CGFloat = statusBarHeight + naviBarHeight
    }
    
}
