//
//  SYBookStyle3Cell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Kingfisher

class SYBookStyle3Cell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(cover)
        addSubview(title)
        addSubview(content)
        addSubview(readBtn)
        addSubview(lineView)
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
            make.left.centerY.equalToSuperview()
            make.height.equalTo(44.5)
            make.width.equalTo(31.5)
        }
        title.snp.makeConstraints { (make) in
            make.left.equalTo(cover.snp.right).offset(10)
            make.top.equalTo(cover).offset(6)
            make.width.equalTo(width - 136.5)
            make.height.equalTo(13)
        }
        content.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(10)
            make.width.left.equalTo(title)
            make.height.equalTo(11)
        }
        readBtn.snp.makeConstraints { (make) in
            make.centerY.right.equalToSuperview()
            make.width.equalTo(85)
            make.height.equalTo(30)
        }
        lineView.snp.makeConstraints { (make) in
            make.bottom.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(1)
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
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    lazy var content: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(198, 189, 172)
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var readBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(244, 202, 27)
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.setTitle("Read", for: .normal)
        btn.setTitleColor(UIColor(51, 51, 51), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(246, 243, 247)
        return view
    }()
    
}
