//
//  SYHomeSliderHeader.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/24.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYHomeSliderHeader: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchBtn)
        setupLayouts()
    }
    
    func setupLayouts() {
        searchBtn.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.width.equalTo(self.frame.size.width - 30)
            make.height.equalTo(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(240, 240, 240)
        btn.setTitle("  Search anthor or book title", for: .normal)
        btn.setTitleColor(UIColor(140, 140, 140), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setImage(R.image.home_search(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        btn.layer.cornerRadius = 15
        return btn
    }()
        
}
