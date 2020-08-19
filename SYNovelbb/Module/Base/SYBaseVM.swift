//
//  SYBaseVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import Moya

protocol ViewModelType {
    
    associatedtype Input
    
    associatedtype Output

    func transform(input: Input) -> Output
}

class SYBaseVM: NSObject {
    
    public let disposeBag = DisposeBag()
    
    // 重新加载数据
    public var reloadSubject = PublishSubject<Bool>()
    
    // 返回上一个界面
    public let popSubject = PublishSubject<Bool>()
    
    // 监听网络请求是否成功
    public var requestStatus = BehaviorRelay<(Bool, String)>(value: (true, ""))
    
    // 获取错误信息
    public func errorMessage(_ error: Swift.Error) -> String {
        if let _error = error as? SYMapperError {
            return _error.message
        }
        guard let _error = error as? MoyaError else {
            return "operation failed"
        }
        
        if let response = _error.response {
            return "错误码：\(response.statusCode)"
        } else {
            // 这边出现Moya的错误基本上都归于网络问题
            switch _error.errorDescription {
            case "URLSessionTask failed with error: The Internet connection appears to be offline.":
                return "The Internet connection appears to be offline"
            default:
                return "Please check that the network is working"
            }
        }
        
    }
    
    override init() {
        super.init()
        logInfo("\(self)已释放")
    }
    
}
