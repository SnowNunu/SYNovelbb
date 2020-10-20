//
//  QMBookContentVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxRelay

class QMBookContentVM: SYBaseVM {
    
    var datasource = BehaviorRelay<[QMBookChapterModel]>(value: [QMBookChapterModel]())
    
    var content = BehaviorRelay<QMBookContentModel>(value: QMBookContentModel())
    
    override init() {
        super.init()
    }
    
    func getChapter(bookId: Int, page: Int, limit: Int ) {
        SYProvider.rx.request(.getBookPageList(bookId: bookId, page: page, limit: limit))
            .qm_map(resultList: QMBookChapterModel.self)
            .subscribe { [unowned self] (response) in
                if response.data != nil {
                    self.datasource.acceptUpdate(byReplace: {_ in
                        response.data!
                    })
                }
            } onError: { (error) in
                
            }
            .disposed(by: disposeBag)
    }
    
    func getContent(bookId: Int, bookPageNum: Int) {
        SYProvider.rx.request(.getBookPageContent(bookId: bookId, bookPageNum: bookPageNum))
            .qm_map(result: QMBookContentModel.self).subscribe { (response) in
                if response.data != nil {
                    self.content.acceptUpdate(byReplace: {_ in
                        response.data!
                    })
                }
            } onError: { (error) in
                print(error)
            }
            .disposed(by: disposeBag)

    }
    

}
