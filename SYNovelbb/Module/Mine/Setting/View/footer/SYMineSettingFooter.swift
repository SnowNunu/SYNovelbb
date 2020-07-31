//
//  SYMineSettingFooter.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxSwift

class SYMineSettingFooter: UIView {

    var disposeBag = DisposeBag()
    
    @IBOutlet weak var switchBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disposeBag = DisposeBag()
    }

}
