//
//  SYHomeVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYHomeVM: RefreshVM<SectionModel<String,SYIndexModel>> {
    
    override init() {
        super.init()
        reloadSubject.asObserver()
            .subscribe(onNext: { (bool) in
                self.requestData(bool)
            }).disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        SYProvider.rx.request(.homePage)
            .map(result: SYHomeModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let slide = SectionModel.init(model: "slide", items: response.data!.slide)
                        let index1 = SectionModel.init(model: "index1", items: response.data!.index1)
                        let index2 = SectionModel.init(model: "index2", items: response.data!.index2)
                        let index3 = SectionModel.init(model: "index3", items: response.data!.index3)
                        self.datasource.accept([slide, index1, index2, index3])
                    }
                }
            }) { (error) in
            
            }
            .disposed(by: disposeBag)
    }

}
