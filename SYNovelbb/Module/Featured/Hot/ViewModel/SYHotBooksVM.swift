//
//  SYHotBooksVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYHotBooksVM: RefreshVM<SectionModel<String, SYBaseBookModel>> {
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.hotBooks)
            .map(resultList: SYBaseBookModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        self.updateRefresh(true, [SectionModel.init(model: "Hot Books", items: response.data!)], 20)
                    }
                }
            }) { (error) in
                
            }
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("\(self)已释放")
    }
    
}
