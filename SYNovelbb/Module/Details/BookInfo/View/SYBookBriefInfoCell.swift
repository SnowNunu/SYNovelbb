//
//  SYBookBriefInfoCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/24.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYBookBriefInfoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentLabel)
        
        contentLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(frame.size.width)
            make.height.equalTo(frame.size.height)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = UIColor(198, 189, 172)
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
}
