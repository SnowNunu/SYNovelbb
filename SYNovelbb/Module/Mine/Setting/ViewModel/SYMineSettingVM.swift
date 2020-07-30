//
//  SYMineSettingVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class SYMineSettingVM: RefreshVM<SectionModel<String, SYMineSettingModel>> {
    
    private weak var owner: SYMineSettingVC!
    
    public let enterNextView = PublishSubject<IndexPath>()
    
    init(_ owner: SYMineSettingVC) {
        super.init()
        self.owner = owner
        let models = [
            SectionModel.init(model: "setting", items: [
                SYMineSettingModel.init(title: "About", detail: nil),
                SYMineSettingModel.init(title: "Clean cache", detail: "12.8M")]
            )]
        self.datasource.accept(models)
        
        enterNextView.subscribe(onNext: { [unowned self] (indexPath) in
            if indexPath.row == 0 {
                self.owner.performSegue(withIdentifier: "enterAboutView", sender: self.owner)
            }
            }).disposed(by: disposeBag)
    }

}
