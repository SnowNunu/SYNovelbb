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
                        let model = [SectionModel.init(model: "slide", items: response.data!.slide)]
                        self.datasource.accept(model)
                    }
                }
            }) { (error) in
            
            }
            .disposed(by: disposeBag)
    }

}
