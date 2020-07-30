//
//  SYMineAboutCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineAboutCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var rightArrow: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var model: SYMineAboutModel? {
        didSet {
            titleLabel.text = model?.title
            if model?.detail == nil {
                detailLabel.isHidden = true
                rightArrow.isHidden = false
            } else {
                rightArrow.isHidden = true
                detailLabel.isHidden = false
                detailLabel.text = model?.detail
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
