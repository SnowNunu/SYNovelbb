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
    
    override init() {
        super.init()
    }
    
}
