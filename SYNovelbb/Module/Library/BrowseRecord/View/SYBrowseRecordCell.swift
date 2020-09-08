//
//  SYBrowseRecordCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/9/4.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBrowseRecordCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var readLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var actionBtn: UIButton!
    
    var model: SYBrowseRecordModel? {
        didSet {
            coverImage.kf.setImage(with: URL(string: model?.cover ?? ""))
            titleLabel.text = model?.bookTitle
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
