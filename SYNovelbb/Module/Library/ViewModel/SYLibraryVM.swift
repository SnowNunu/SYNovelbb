//
//  SYLibraryVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYLibraryVM: RefreshVM<SYBaseBookModel> {
    
    var recommendArray: [SYBaseBookModel]!
    
    var shelfArray: [SYBaseBookModel]!
    
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
                                self.updateRefresh(refresh, response.data! + self.recommendArray, response.total)
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

}
