//
//  SYGenderSlideHeader.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import JXBanner
import RxSwift

class SYGenderSlideHeader: UICollectionReusableView {
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        disposeBag = DisposeBag()
        addSubview(banner)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayouts() {
        let width = self.frame.size.width - 30
        let bannerHeight = width * (105 / 345)

        banner.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(bannerHeight)
        }
    }
    
    lazy var banner: JXBanner = {
        let banner = JXBanner()
//        banner.placeholderImgView.image = UIImage(named: "tabBar_featured_selected")
        return banner
    }()
    
}
