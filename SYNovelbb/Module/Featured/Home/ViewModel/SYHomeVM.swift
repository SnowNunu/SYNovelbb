//
//  SYHomeVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay

class SYHomeVM: RefreshVM<SectionModel<String,SYIndexModel>> {
    
    lazy var titleArray: [String] = {
        return ["slide", "High Score", "Editor's recommendation", "Guess you like it"]
    }()
    
    private weak var owner: SYHomeVC!
    
    init(_ owner: SYHomeVC) {
        super.init()
        self.owner = owner
        
        reloadSubject.asObserver()
            .subscribe(onNext: { (bool) in
                self.requestData(bool)
            })
            .disposed(by: disposeBag)
    }
    
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.homePage)
            .map(result: SYHomeModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let slide = SectionModel.init(model: self.titleArray[0], items: response.data!.slide)
                        let index1 = SectionModel.init(model: self.titleArray[1], items: response.data!.index1)
                        let index2 = SectionModel.init(model: self.titleArray[2], items: response.data!.index2)
                        let index3 = SectionModel.init(model: self.titleArray[3], items: response.data!.index3)
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
    
    /// 换一换
    func changeHomeData(index: Int) {
        SYProvider.rx.request(.homePageChange(index: index))
            .map(resultList: SYIndexModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    var temp = self.datasource.value
                    let model = SectionModel.init(model: self.titleArray[index], items: response.data!)
                    temp[index] = model
                    self.datasource.accept(temp)
                    let btn = self.owner.view.viewWithTag(880 + index) as! UIButton
                    btn.imageView?.layer.removeAnimation(forKey: "rotationAnimation")
                    btn.isUserInteractionEnabled = true
                }
            }) { (error) in
                print(error)
            }
            .disposed(by: disposeBag)
    }

}
