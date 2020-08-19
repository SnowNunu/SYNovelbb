
//
//  SYBookFilterCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBookFilterCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(coverImage)
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(classifyLabel)
    }
    
    private func setupConstraints() {
        coverImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(15)
            make.bottom.equalToSuperview()
            make.width.equalTo(81)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(coverImage.snp.right).offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(coverImage).offset(5)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.right.equalTo(titleLabel)
        }
        classifyLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalTo(titleLabel)
            make.height.equalTo(18)
            make.width.equalTo(60)
        }
    }
    
    var model: SYBaseBookModel? {
        didSet {
            coverImage.kf.setImage(with: URL(string: model?.cover ?? ""))
            titleLabel.text = model?.bookTitle
            contentLabel.text = model?.intro
            classifyLabel.text = model?.tclass
            let size = model?.tclass?.size(.systemFont(ofSize: 13, weight: .regular))
            classifyLabel.snp.updateConstraints { (make) in
                make.width.equalTo((size?.width ?? 0) + 20)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var coverImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(115, 115, 115)
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var classifyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.backgroundColor = UIColor(198, 189, 172)
        label.layer.cornerRadius = 4.5
        label.layer.masksToBounds = true
        return label
    }()
    
}
