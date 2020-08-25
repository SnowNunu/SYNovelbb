//
//  SYBookChapterListCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/25.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBookChapterListCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(chapterLabel)
        addSubview(vipImage)
        
        chapterLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
        }
        vipImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(15)
        }
    }
    
    var model: SYChapterModel? {
        didSet {
            chapterLabel.text = model?.title
            vipImage.isHidden = !(model?.isVip ?? false)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var chapterLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(115, 115, 115)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var vipImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_vip()
        return imageView
    }()

}
