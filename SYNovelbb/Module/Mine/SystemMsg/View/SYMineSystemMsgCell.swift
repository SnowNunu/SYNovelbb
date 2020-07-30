//
//  SYMineSystemMsgCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineSystemMsgCell: UITableViewCell {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var msgKindLabel: UILabel!
    
    @IBOutlet weak var sendTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var model: SYSystemMsgModel? {
        didSet {
            contentLabel.attributedText = model?.showContent
            msgKindLabel.text = model?.fusername
            sendTimeLabel.text = model?.sendTime
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
