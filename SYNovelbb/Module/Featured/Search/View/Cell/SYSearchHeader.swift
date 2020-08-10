
//
//  SYSearchHeader.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxSwift


class SYSearchHeader: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var actionBtn: UIButton!
    
    @IBOutlet weak var actionImage: UIImageView!
    
    @IBOutlet weak var actionLabel: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        disposeBag = DisposeBag()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    // 判断显示删除还是换一换
    var isChange: Bool! {
        didSet {
            if isChange {
                actionLabel.text = "change"
                actionImage.image = R.image.home_change()!
                actionImage.snp.makeConstraints { (make) in
                    make.right.bottom.equalTo(actionBtn)
                    make.width.equalTo(13)
                    make.height.equalTo(12)
                }
                actionLabel.snp.makeConstraints { (make) in
                    make.centerY.equalTo(actionImage)
                    make.right.equalTo(actionImage.snp.left).offset(-5)
                }
            } else {
                actionImage.image = R.image.mine_subscription_del()!
                actionImage.snp.makeConstraints { (make) in
                    make.right.bottom.equalTo(actionBtn)
                    make.width.height.equalTo(15)
                }
                actionLabel.text = ""
            }
        }
    }
        
}
