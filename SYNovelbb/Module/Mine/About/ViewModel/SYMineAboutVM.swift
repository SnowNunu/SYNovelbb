//
//  SYMineAboutVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYMineAboutVM: RefreshVM<SectionModel<String, SYMineAboutModel>> {
    
    private weak var owner: SYMineAboutVC!

    init(_ owner: SYMineAboutVC) {
        super.init()
        self.owner = owner
        let models = [
            SectionModel.init(model: "AboutSection1", items: [
                SYMineAboutModel.init(title: "Terms of Service", detail: nil),
                SYMineAboutModel.init(title: "Privacy Policy", detail: nil)
            ]),
            SectionModel.init(model: "AboutSection2", items: [
                SYMineAboutModel.init(title: "Focus on wechat", detail: "Novel app"),
                SYMineAboutModel.init(title: "Focus on wechat", detail: "JJJ666@163.com")
            ])
        ]
        self.datasource.accept(models)
    }

}
