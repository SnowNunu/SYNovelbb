
//
//  SYBookCommentCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/25.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBookCommentCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(contentLabel)
        bgView.addSubview(aliasLabel)
        bgView.addSubview(amountImage)
        bgView.addSubview(amountLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.width.equalTo(bgView).offset(-30)
            make.left.equalTo(titleLabel)
        }
        aliasLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-17)
            make.left.equalToSuperview().offset(15)
        }
        amountImage.snp.makeConstraints { (make) in
            make.centerY.equalTo(aliasLabel)
            make.right.equalToSuperview().offset(-40)
        }
        amountLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(amountImage)
            make.left.equalTo(amountImage.snp.right).offset(7)
        }
    }
    
    var model: SYCommentModel? {
        didSet {
            titleLabel.text = model?.title
            contentLabel.text = model?.contents.replacingCharacters("    ", "")
            aliasLabel.text = model?.username
            amountLabel.text = "\(model?.replay?.count ?? 0)"
        }
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.frame = .init(x: 15, y: 0, width: ScreenWidth - 30, height: 128)
        view.backgroundColor = .white
        view.layer.cornerRadius = 7
        view.layer.masksToBounds = false
        view.layer.shadowColor =  UIColor(193, 193, 193, 0.75).cgColor
        view.layer.shadowOffset = .init(width: 0, height: 0)
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 7
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(115, 115, 115)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 3
        return label
    }()
    
    lazy var aliasLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(198, 189, 172)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var amountImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.book_detail_comment_amount()!
        return imageView
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(198, 189, 172)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

}
