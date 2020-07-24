//
//  SYBookStyle1Cell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/24.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Kingfisher

class SYBookStyle1Cell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cover)
        addSubview(title)
        addSubview(content)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: SYIndexModel? {
        didSet {
            cover.kf.setImage(with: URL(string: model?.cover ?? ""))
            title.text = model?.bookTitle
            content.text = model?.readTxt
        }
    }
    
    func setupLayouts() {
        let width = self.frame.size.width
        cover.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.top.centerX.equalToSuperview()
            make.height.equalTo(width * (110 / 77.5))
        }
        title.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.bottom.equalTo(content.snp.top).offset(-5)
            make.centerX.equalToSuperview()
        }
        content.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.width.equalTo(width)
        }
    }
    
    lazy var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(51, 51, 51)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(119, 119, 119)
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return label
    }()
    
}
