//
//  SYLibraryVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay

class SYLibraryVM: RefreshVM<SYBaseBookModel> {
    
    var recommendArray: [SYBaseBookModel]!
    
    var shelfArray: [SYBaseBookModel]!
    
    var checkArray = BehaviorRelay<[SYBaseBookModel]>(value: [SYBaseBookModel]())
    
    override init() {
        super.init()
        reloadSubject.asObserver()
            .subscribe(onNext: { [unowned self] (bool) in
                self.requestRecommendInfo()
            }).disposed(by: disposeBag)
    }
    
    /// 请求书架推荐数据
    private func requestRecommendInfo() {
        SYProvider.rx.cacheRequest(.recommendBooks, cacheType: .default)
            .map(resultList: SYBaseBookModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    self.recommendArray = response.data!
                    self.requestData(true)
                }
            }) { [unowned self] (error) in
                logError(self.errorMessage(error))
            }
            .disposed(by: disposeBag)
    }
    
    /// 请求用户书架数据
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.myBookshelf(pageIndex: pageModel.currentPage))
            .map(resultList: SYBaseBookModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        if self.pageModel.currentPage == 1 {
                            self.shelfArray = response.data!
                            if response.data!.count > 3 {
                                self.updateRefresh(refresh, response.data!, response.total)
                            } else {
                                var temp = [SYBaseBookModel]()
                                for recommendModel in self.recommendArray {
                                    if !response.data!.contains(where: { (model) -> Bool in
                                        return model.bid == recommendModel.bid
                                    }) {
                                        temp.append(recommendModel)
                                    }
                                }
                                self.updateRefresh(refresh, response.data! + temp, response.total)
                            }
                        } else {
                            self.shelfArray += response.data!
                            self.updateRefresh(refresh, response.data!, response.total)
                        }
                        self.requestStatus.accept((true, ""))
                    }
                }
            }) { [unowned self] (error) in
                logError(self.errorMessage(error))
                if self.errorMessage(error) == "no find data" {
                    self.updateRefresh(true, self.recommendArray, 6)
                    self.requestStatus.accept((true, ""))
                }
            }
            .disposed(by: disposeBag)
    }
    
    /// 移出书架
    func deleteFromBookcase(group: DispatchGroup, bid: String) {
        group.enter()
        SYProvider.rx.request(.removeBookshelf(bid: bid))
            .map(result: SYEmptyModel.self)
            .subscribe(onSuccess: { (response) in
                if response.success {
                    group.leave()
                }
            }) { (error) in
                logError(self.errorMessage(error))
                group.leave()
            }
            .disposed(by: disposeBag)
    }

}
