//
//  SYRankListVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYRankListVM: RefreshVM<SYRankListModel> {
    
    var rankId: Int = 0
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.rankList(rankId: rankId, pageIndex: pageModel.currentPage))
            .map(resultList: SYRankListModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        if self.pageModel.currentPage == 1 {
                            self.updateRefresh(true, response.data!, response.total)
                        } else {
                            self.updateRefresh(false, response.data!, response.total)
                        }
                    }
                }
            }) { (error) in
            
            }
            .disposed(by: disposeBag)
    }

}
