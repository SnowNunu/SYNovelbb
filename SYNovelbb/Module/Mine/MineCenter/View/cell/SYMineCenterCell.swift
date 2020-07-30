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
