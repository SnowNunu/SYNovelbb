//
//  SYHotSearchCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/10.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYHotSearchCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(198, 189, 172)
        return label
    }()
    
}
