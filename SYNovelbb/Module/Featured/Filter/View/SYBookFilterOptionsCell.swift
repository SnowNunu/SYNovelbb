//
//  SYBookFilterOptionsCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBookFilterOptionsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textColor = UIColor(115, 115, 115)
        return label
    }()
    
}
