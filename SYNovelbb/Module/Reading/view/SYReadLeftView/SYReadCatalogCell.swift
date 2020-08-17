//
//  SYReadCatalogCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadCatalogCell: UITableViewCell {
    
    class func cell(_ tableView:UITableView) -> SYReadCatalogCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SYReadCatalogCell")
        if cell == nil {
            cell = SYReadCatalogCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SYReadCatalogCell")
        }
        return cell as! SYReadCatalogCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        contentView.addSubview(chapterName)
        contentView.addSubview(vipImage)
        contentView.addSubview(lineView)
    }
    
    private func setupConstraints() {
        chapterName.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.5)
            make.right.equalTo(vipImage.snp.left).offset(-5)
        }
        vipImage.snp.makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
        }
        lineView.snp.makeConstraints { (make) in
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
            make.height.equalTo(0.5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var chapterName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(116, 116, 116)
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var vipImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_vip()!
        return imageView
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(224, 224, 224)
        return view
    }()
    
}
