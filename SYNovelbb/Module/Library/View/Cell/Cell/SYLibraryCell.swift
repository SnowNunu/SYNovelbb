//
//  SYLibraryCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import Kingfisher

class SYLibraryCell: UICollectionViewCell {
    
    @IBOutlet weak var cover: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var detail: UILabel!
    
    var model: SYBaseBookModel? {
        didSet {
            cover.kf.setImage(with: URL(string: model?.cover ?? ""))
            title.text = model?.readTxt
        }
    }
}
