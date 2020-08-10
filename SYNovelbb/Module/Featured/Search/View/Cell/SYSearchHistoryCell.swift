//
//  SYSearchHistoryCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYSearchHistoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(frame.width)
            make.height.equalTo(frame.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(115, 115, 115)
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        label.backgroundColor = UIColor(242, 242, 242)
        return label
    }()
    
}
