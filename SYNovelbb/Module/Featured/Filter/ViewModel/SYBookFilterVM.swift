
//
//  SYBookFilterVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/18.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay

class SYBookFilterVM: RefreshVM<SYBaseBookModel> {
    
    private weak var owner: SYBookFilterVC!
    
    /// 搜素关键字
    var filterParams = BehaviorRelay<[String: String]>(value: [String : String]())
    
    init(_ owner: SYBookFilterVC) {
        super.init()
        self.owner = owner
    }
    
    /// 请求搜素关键字数据
    func requestFilterInfo() {
        SYProvider.rx.request(.bookFilter)
            .map(result: SYFilterModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        self.requestData(true)
                    }
                }
            }) { (error) in
                logError(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.allBook(params: filterParams.value, pageIndex: pageModel.currentPage))
            .map(resultList: SYBaseBookModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        self.updateRefresh(refresh, response.data!, response.total)
                        self.requestStatus.accept((true, ""))
                    }
                }
            }) { (error) in
                logError(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }

}
