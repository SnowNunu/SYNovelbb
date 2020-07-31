//
//  SYMineRechargeCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/31.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYMineRechargeCell: UICollectionViewCell {
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var productLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(244, 202, 28).cgColor
    }
    
    var model: SYMineRechargeModel? {
        didSet {
            priceLabel.text = model?.price
            productLabel.text = model?.content
        }
    }
    
    
}
