
//
//  SYBookInfoVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBookInfoVM: SYBaseVM {
    
    private weak var owner: SYBookInfoVC!
    
    init(_ owner: SYBookInfoVC) {
        super.init()
        self.owner = owner
        reloadSubject.subscribe(onNext: { [unowned self] (bool) in
                self.requestData()
            })
            .disposed(by: disposeBag)
    }
    
    func requestData() {
        SYProvider.rx.request(.bookInfo(bid: self.owner.bookId))
            .map(result: SYBookInfoModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let model = response.data!.book
                        self.owner.headerView.bookTitle.text = model?.bookTitle
                        self.owner.headerView.bookClass.text = model?.tclass
                        self.owner.headerView.coverImage.kf.setImage(with: URL(string: model?.cover ?? ""))
                        var array = model?.Labels?.components(separatedBy: ",") ?? []
                        array.removeAll { (title) -> Bool in
                            title == ""
                        }
                        self.owner.headerView.datasource.acceptUpdate(byReplace: {_ in array})
                        
                        let size = model?.info?.introduction.size(.systemFont(ofSize: 12, weight: .regular), CGSize(width: ScreenWidth - 30, height: CGFloat.greatestFiniteMagnitude))
                        self.owner.headerView.introduceLabel.snp.updateConstraints { (make) in
                            make.height.equalTo(ceil(size!.height))
                        }
                        self.owner.headerView.introduceLabel.text = model?.info?.introduction
                        self.requestStatus.accept((true, ""))
                    }
                }
            }) { (error) in
                print(error.localizedDescription)
        }
        .disposed(by: disposeBag)
    }

}
