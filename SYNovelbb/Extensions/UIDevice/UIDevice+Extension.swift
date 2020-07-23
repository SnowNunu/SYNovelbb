//
//  UIDevice+Extension.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

extension UIDevice {
    
    /**
     判断是否为iPhone X
     */
    public var isX: Bool {
        guard #available(iOS 11.0, *) else {
            return false
        }
        if let top = UIApplication.shared.keyWindow?.safeAreaInsets.top {
            return top > 20
        }
        return false
    }
    
}
