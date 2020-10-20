
//
//  UserDefaults+Cache.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/5.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Foundation

let userDefault = UserDefaults.standard

extension UserDefaults {
    
    var isBookcase: Bool {
        get {
            guard let result = (object(forKey: "isBookcase") as? Bool) else {
                return false
            }
            return result
        }
        set {
            set(newValue, forKey: "isBookcase")
            synchronize()
        }
    }
        
}
