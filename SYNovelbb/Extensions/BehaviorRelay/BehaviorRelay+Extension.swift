//
//  BehaviorRelay+Extension.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import RxRelay

extension BehaviorRelay {

    /// Accept update of current value
    /// - Parameter update: mutate current value in closure
    func acceptUpdate(byMutating update: (inout Element) -> Void) {
        var newValue = value
        update(&newValue)
        accept(newValue)
    }

    /// Accept new value generated from current value
    /// - Parameter update: generate new value from current, and return it
    func acceptUpdate(byReplace update: (Element) -> Element) {
        accept(update(value))
    }

}
