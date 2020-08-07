
//
//  SYSearchVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/6.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxRelay
import RxDataSources

class SYSearchVM: RefreshVM<SYBaseBookModel> {
    
    // 关键字
    public var keyword = BehaviorRelay<String>(value: "")
    
    // 推荐信息数据源
//    public var recommendDatasource = BehaviorRelay<SectionModel<String>>
    
    override init() {
        super.init()
        
        reloadSubject.subscribe(onNext: { [unowned self] (bool) in
//                self.requestData(bool)
                self.getRecommendData()
            })
            .disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.searchBook(keyword: keyword.value, pageIndex: pageModel.currentPage))
            .map(resultList: SYBaseBookModel.self)
            .subscribe(onSuccess: { (response) in
                if response.success {
                    if response.data != nil {
                        self.updateRefresh(refresh, response.data!, response.total)
                        self.requestStatus.accept((true, ""))
                    }
                }
            }) { [unowned self] (error) in
                self.pageModel.setupCurrentPage()
                self.updateRefresh(refresh, [], 0)
                self.requestStatus.accept((false, self.errorMessage(error)))
                print(error)
            }
            .disposed(by: disposeBag)
    }
    
    // 获取推荐数据
    func getRecommendData() {
        SYProvider.rx.cacheRequest(.hotSearch)
            .map(resultList: SYSearchModel.self)
            .subscribe(onSuccess: { (response) in
                print(response.data)
            }) { (error) in
                print(error)
            }
            .disposed(by: disposeBag)
    }

}
