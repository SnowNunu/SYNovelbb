//
//  SYGenderVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYGenderVM: RefreshVM<SectionModel<String, SYIndexModel>> {
    
    var gender: Bool!
    
    override init() {
        super.init()
        reloadSubject.asObserver()
            .subscribe(onNext: { (bool) in
                self.requestData(bool)
            }).disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(gender ? .malePage : .femalePage)
            .map(result: SYGenderModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let slide = SectionModel.init(model: "slide", items: response.data!.slide)
                        let index1 = SectionModel.init(model: response.data!.index1.title!, items: response.data!.index1.data)
                        let index2 = SectionModel.init(model: response.data!.index2.title!, items: response.data!.index2.data)
                        let index3 = SectionModel.init(model: response.data!.index3.title!, items: response.data!.index3.data)
                        self.updateRefresh(true, [slide, index1, index2, index3], 4)
                        self.requestStatus.accept((true, ""))
                    }
                }
            }) { (error) in
                print(error)
                self.requestStatus.accept((false, self.errorMessage(error)))
            }
            .disposed(by: disposeBag)
    }

}
