
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
        filterParams.skip(1)
            .subscribe(onNext: { [unowned self] _ in
                self.requestData(true)
            })
            .disposed(by: disposeBag)
    }
    
    /// 请求搜素关键字数据
    func requestFilterInfo() {
        SYProvider.rx.request(.bookFilter)
            .map(result: SYFilterModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let category = response.data!.category.first!
                        let model1 = SYFilterKeyModel()
                        model1.title = category.content + "·"
                        response.data!.category.insert(model1, at: 0)
                        let section1 = SectionModel.init(model: model1.title!, items: response.data!.category)
                        
                        let rank = response.data!.rank.first!
                        let model2 = SYFilterKeyModel()
                        model2.title = rank.content + "·"
                        response.data!.rank.insert(model2, at: 0)
                        let section2 = SectionModel.init(model: model2.title!, items: response.data!.rank)
                        
                        let status = response.data!.status.first!
                        let model3 = SYFilterKeyModel()
                        model3.title = status.content + "·"
                        response.data!.status.insert(model3, at: 0)
                        let section3 = SectionModel.init(model: model3.title!, items: response.data!.status)
                        
                        let other = response.data!.other.first!
                        let model4 = SYFilterKeyModel()
                        model4.title = other.content + "·"
                        response.data!.other.insert(model4, at: 0)
                        let section4 = SectionModel.init(model: model1.title!, items: response.data!.other)
                        
                        self.owner.optionsView.datasource.acceptUpdate(byReplace: {_ in [section1, section2, section3, section4] })
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
                self.revertCurrentPageAndRefreshStatus()
                self.updateRefresh(true, [], 0)
                self.requestStatus.accept((false, self.errorMessage(error)))
            }
            .disposed(by: disposeBag)
    }

}
