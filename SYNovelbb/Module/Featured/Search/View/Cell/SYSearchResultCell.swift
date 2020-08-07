//
//  SYSearchResultCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/6.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYSearchResultCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.snp.updateConstraints { (make) in
            make.width.equalTo(ScreenWidth - 30 - 96)
        }
        contentLabel.snp.updateConstraints { (make) in
            make.width.equalTo(titleLabel)
        }
        timeLabel.snp.updateConstraints { (make) in
            make.width.equalTo(contentLabel)
        }
    }
    
    var model: SYBaseBookModel? {
        didSet {
            coverImage.kf.setImage(with: URL(string: model?.cover ?? ""))
            titleLabel.text = model?.bookTitle
            contentLabel.text = model?.intro
            timeLabel.text = model?.lastUpdate
        }
    }
    
    
}
