//
//  QMBookcaseListCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class QMBookcaseListCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    var model: QMBookcaseListModel? {
        didSet {
            coverImage.kf.setImage(with: URL(string: model?.bookImaUrl ?? ""))
            titleLabel.text = model?.bookName
            contentLabel.text = model?.bookDescript
            authorLabel.text = model?.bookAuthor
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
