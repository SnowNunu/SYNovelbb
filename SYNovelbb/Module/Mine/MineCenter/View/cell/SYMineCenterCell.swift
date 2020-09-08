//
//  SYMineCenterCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineCenterCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.frame = .init(x: 15, y: 0, width: ScreenWidth - 30, height: 50)
        lineView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.width.equalTo(bgView).offset(-50)
            make.bottom.centerX.equalToSuperview()
        }
        iconImage.snp.makeConstraints { (make) in
            make.width.equalTo(15.5)
            make.height.equalTo(16.5)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25.5)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImage.snp.right).offset(19.5)
        }
    }

    var model: SYMineCenterModel? {
        didSet {
            switch model?.type {
            case .all:
                bgView.layer.cornerRadius = 10
                break
            case .top:
                bgView.configRectCorner(corner: [.topLeft, .topRight], radii: .init(width: 10, height: 10))
                break
            case .bottom:
                bgView.configRectCorner(corner: [.bottomLeft, .bottomRight], radii: .init(width: 10, height: 10))
                break
            default:
                break
            }
            lineView.isHidden = !(model?.showLine ?? true)
            iconImage.image = model?.icon
            titleLabel.text = model?.title
        }
    }
    
    
}
