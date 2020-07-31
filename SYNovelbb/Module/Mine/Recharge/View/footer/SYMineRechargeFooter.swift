
//
//  SYMineRechargeFooter.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/31.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxSwift

class SYMineRechargeFooter: UICollectionReusableView {
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disposeBag = DisposeBag()
    }
        
}
