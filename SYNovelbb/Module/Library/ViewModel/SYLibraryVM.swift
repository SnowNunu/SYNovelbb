//
//  SYLibraryVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYLibraryVM: RefreshVM<SectionModel<String, SYBaseBookModel>> {
    
    override init() {
        super.init()
        reloadSubject.asObserver()
            .subscribe(onNext: { (bool) in
                self.requestData(bool)
            }).disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        SYProvider.rx.request(.recommendBooks)
            .map(resultList: SYBaseBookModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        self.datasource.acceptUpdate(byReplace: {_ in
                            return [SectionModel.init(model: "", items: response.data!)]
                        })
                    }
                }
            }) { (error) in
                
            }
            .disposed(by: disposeBag)
    }

}
