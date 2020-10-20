//
//  QMBookcaseListVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class QMBookcaseListVM: RefreshVM<QMBookcaseListModel> {
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.getBookList(page: pageModel.currentPage, limit: pageModel.pageSize))
            .qm_map(resultList: QMBookcaseListModel.self)
            .subscribe { (response) in
                if response.data != nil {
                    self.updateRefresh(refresh, response.data!, response.count)
                }
            } onError: { (error) in
                print(error)
            }
            .disposed(by: disposeBag)
    }

}
