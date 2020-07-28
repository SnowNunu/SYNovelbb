//
//  SYBookStyle2Cell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/24.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Kingfisher

class SYBookStyle2Cell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cover)
        addSubview(title)
        addSubview(content)
        addSubview(author)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model: SYIndexModel? {
        didSet {
            cover.kf.setImage(with: URL(string: model?.cover ?? ""))
            title.text = model?.bookTitle
            content.text = model?.intro
            author.text = model?.author
        }
    }
    
    func setupLayouts() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        cover.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalTo(81)
            make.height.equalTo(height)
        }
        title.snp.makeConstraints { (make) in
            make.width.equalTo(width - 94.5)
            make.top.equalToSuperview().offset(5)
            make.left.equalTo(cover.snp.right).offset(13.5)
        }
        content.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(17.5)
            make.left.width.equalTo(title)
        }
        author.snp.makeConstraints { (make) in
            make.left.width.equalTo(title)
            make.bottom.equalTo(cover.snp.bottom).offset(-4.5)
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
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(115, 115, 115)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var author: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(198, 189, 172)
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
}
