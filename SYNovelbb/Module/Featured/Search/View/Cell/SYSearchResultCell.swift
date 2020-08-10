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
    
    var keywords: String!
    
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
            let title = NSMutableAttributedString(string: model?.bookTitle ?? "")
            let titleRanges = model?.bookTitle.lowercased().nsranges(of: keywords)
            for range in  titleRanges! {
                title.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(244, 202, 28)], range: range)
            }
            titleLabel.attributedText = title
            
            let content = NSMutableAttributedString(string: model?.intro ?? "")
            let contentRanges = model?.intro!.lowercased().nsranges(of: keywords)
            for range in  contentRanges! {
                content.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(244, 202, 28)], range: range)
            }
            contentLabel.attributedText = content
            
            timeLabel.text = model?.lastUpdate
        }
    }
    
    
}
