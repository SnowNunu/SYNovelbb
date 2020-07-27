//
//  SYHomeSlideHeader.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/24.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import JXBanner
import RxSwift

class SYHomeSlideHeader: UICollectionReusableView {
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        disposeBag = DisposeBag()
        addSubview(banner)
        addSubview(listBtn)
        listBtn.addSubview(listTitle)
        listBtn.addSubview(listContent)
        listBtn.addSubview(listImage)
        addSubview(rankBtn)
        rankBtn.addSubview(rankTitle)
        rankBtn.addSubview(rankContent)
        rankBtn.addSubview(rankImage)
        addSubview(hotBtn)
        hotBtn.addSubview(hotTitle)
        hotBtn.addSubview(hotContent)
        hotBtn.addSubview(hotImage)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayouts() {
        let width = self.frame.size.width
        let bannerHeight = width * (105 / 345)
        let listBtnWidth = width * (130 / 345)
        let listBtnHeight = listBtnWidth * (139 / 130)
        let rankBtnHeight = (listBtnHeight - 10) / 2

        banner.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(bannerHeight)
        }
        listBtn.snp.makeConstraints { (make) in
            make.top.equalTo(banner.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.width.equalTo(listBtnWidth)
            make.height.equalTo(listBtnHeight)
        }
        listTitle.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(17)
            make.height.equalTo(13)
        }
        listContent.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(listTitle.snp.bottom).offset(9)
            make.height.equalTo(10)
        }
        listImage.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-32.5)
            make.centerX.equalToSuperview()
        }
        rankBtn.snp.makeConstraints { (make) in
            make.top.equalTo(listBtn)
            make.height.equalTo(rankBtnHeight)
            make.right.equalToSuperview()
            make.left.equalTo(listBtn.snp.right).offset(10)
        }
        rankTitle.snp.makeConstraints { (make) in
            make.left.equalTo(rankImage.snp.right).offset(15)
            make.top.equalToSuperview().offset(17)
            make.height.equalTo(13)
        }
        rankContent.snp.makeConstraints { (make) in
            make.left.equalTo(rankImage.snp.right).offset(15)
            make.top.equalTo(rankTitle.snp.bottom).offset(6.5)
            make.height.equalTo(10)
        }
        rankImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
        hotBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(listBtn)
            make.width.right.height.equalTo(rankBtn)
        }
        hotTitle.snp.makeConstraints { (make) in
            make.left.equalTo(hotImage.snp.right).offset(15)
            make.top.equalToSuperview().offset(17)
            make.height.equalTo(13)
        }
        hotContent.snp.makeConstraints { (make) in
            make.left.equalTo(hotImage.snp.right).offset(15)
            make.top.equalTo(hotTitle.snp.bottom).offset(6.5)
            make.height.equalTo(10)
        }
        hotImage.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
        }
    }
    
    
    
    lazy var banner: JXBanner = {
        let banner = JXBanner()
//        banner.placeholderImgView.image = UIImage(named: "tabBar_featured_selected")
        return banner
    }()
    
    lazy var listBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(R.image.home_list_bg(), for: .normal)
        return btn
    }()
    
    lazy var listTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(51, 51, 51)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "List of books"
        return label
    }()
    
    lazy var listContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(115, 115, 115)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "More and more"
        return label
    }()
    
    lazy var listImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.home_list_icon()
        return imageView
    }()
    
    lazy var rankBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(R.image.home_rank_bg(), for: .normal)
        return btn
    }()
    
    lazy var rankTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(51, 51, 51)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Ranking List"
        return label
    }()
    
    lazy var rankContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(143, 145, 183)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Waste material …"
        return label
    }()
    
    lazy var rankImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.home_rank_icon()
        return imageView
    }()
    
    lazy var hotBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(R.image.home_hot_bg(), for: .normal)
        return btn
    }()
    
    lazy var hotTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(51, 51, 51)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.text = "Hot books"
        return label
    }()
    
    lazy var hotContent: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(144, 146, 184)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "The wonderful novels"
        return label
    }()
    
    lazy var hotImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.home_hot_icon()
        return imageView
    }()
    
}
