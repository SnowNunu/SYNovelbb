//
//  SYBookshelfCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Kingfisher

class SYBookshelfCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(coverImage)
        bgView.addSubview(checkBtn)
        bgView.addSubview(titleLabel)
        bgView.addSubview(detailLabel)
        
        bgView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height)
        }
        coverImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.equalToSuperview().offset(-10)
            make.height.equalTo((frame.width - 10) * (135 / 95.0))
        }
        checkBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(coverImage.snp.right)
            make.centerY.equalTo(coverImage.snp.top)
            make.width.height.equalTo(19)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(coverImage.snp.bottom).offset(10)
            make.height.equalTo(32)
            make.width.equalTo(coverImage)
        }
        detailLabel.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(coverImage)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    lazy var checkBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.library_book_unselected()!, for: .normal)
        btn.setImage(R.image.library_book_selected()!, for: .selected)
        return btn
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = UIColor(52, 52, 52)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(198, 190, 172)
        label.font = .systemFont(ofSize: 11, weight: .regular)
        return label
    }()
    
    var model: SYBaseBookModel? {
        didSet {
            coverImage.kf.setImage(with: URL(string: model?.cover ?? ""))
            if model?.bookcase != nil {
                titleLabel.text = model?.bookTitle
                detailLabel.text = "Read \(model?.bookcase?.title ?? "")"
            } else {
                titleLabel.text = model?.readTxt
                detailLabel.text = ""
            }
        }
    }
    
}
