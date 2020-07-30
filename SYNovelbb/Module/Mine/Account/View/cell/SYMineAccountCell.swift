//
//  SYMineAccountCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineAccountCell: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var underLine: UIView!
    
    var model: SYMineAccountModel? {
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
            titleLabel.text = model?.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
