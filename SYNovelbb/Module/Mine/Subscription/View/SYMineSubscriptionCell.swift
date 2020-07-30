//
//  SYMineSubscriptionCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Kingfisher

class SYMineSubscriptionCell: UITableViewCell {
    
    @IBOutlet weak var cover: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var delBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var model: SYAutoSubscriptionModel? {
        didSet {
            cover.kf.setImage(with: URL(string: model?.cover ?? ""))
            title.text = model?.booktitle
            author.text = model?.author
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
