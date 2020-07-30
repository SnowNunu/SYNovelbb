//
//  SYMineSettingCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineSettingCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    
    var model: SYMineSettingModel? {
        didSet {
            titleLabel.text = model?.title
            detailLabel.text = model?.detail
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
