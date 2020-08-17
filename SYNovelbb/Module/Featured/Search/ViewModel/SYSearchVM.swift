
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
import RealmSwift

class SYSearchVM: RefreshVM<SYBaseBookModel> {
    
    // 关键字
    public var keyword = BehaviorRelay<String>(value: "")
    
    // 推荐信息数据源
    public var recommendDatasource = BehaviorRelay<[SectionModel<String, SYSearchModel>]>(value: [SectionModel<String, SYSearchModel>]())
    
    override init() {
        super.init()
        
        reloadSubject.subscribe(onNext: { [unowned self] (bool) in
                self.getRecommendData()
            })
            .disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.searchBook(keyword: keyword.value, pageIndex: pageModel.currentPage))
            .map(resultList: SYBaseBookModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let realm = try! Realm()
                        try! realm.write() {
                            realm.add(SYSearchModel(value: ["keyword": self.keyword.value]), update: .modified)
                            self.updateRefresh(refresh, response.data!, response.total)
                            self.requestStatus.accept((true, ""))
                        }
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
        SYProvider.rx.cacheRequest(.hotSearch, cacheType: .base)
            .map(resultList: SYSearchModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        var modelsArray = [SYSearchModel]()
                        let realm = try! Realm()
                        let results = realm.objects(SYSearchModel.self)
                        for model in results {
                            modelsArray.append(model)
                        }
                        let models1 = SectionModel.init(model: "Search history", items: modelsArray)
                        let models2 = SectionModel.init(model: "Hot Search", items: response.data!)
                        self.recommendDatasource.acceptUpdate(byReplace: {_ in
                            [models1, models2]
                        })
                        self.requestStatus.accept((true, ""))
                    }
                }
            }) { [unowned self] (error) in
                print(error)
                self.requestStatus.accept((false, self.errorMessage(error)))
            }
            .disposed(by: disposeBag)
    }

}
