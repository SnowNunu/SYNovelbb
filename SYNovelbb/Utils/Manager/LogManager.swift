//
//  LogManager.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Foundation
import CocoaLumberjack
import RxSwift

public func logDebug(_ message: @autoclosure () -> String) {
    DDLogDebug(message())
}

public func logError(_ message: @autoclosure () -> String) {
    DDLogError(message())
}

public func logInfo(_ message: @autoclosure () -> String) {
    DDLogInfo(message())
}

public func logVerbose(_ message: @autoclosure () -> String) {
    DDLogVerbose(message())
}

public func logWarn(_ message: @autoclosure () -> String) {
    DDLogWarn(message())
}
