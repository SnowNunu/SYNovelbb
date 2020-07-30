//
//  SYMineAccountHeader.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineAccountHeader: UIView {
    
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet weak var rechargeBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        let width = (ScreenWidth - 52) / 3
        centerView.snp.updateConstraints { (make) in
            make.width.equalTo(width)
        }
    }

}
