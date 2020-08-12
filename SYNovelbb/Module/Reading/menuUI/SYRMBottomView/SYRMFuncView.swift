//
//  SYRMFuncView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYRMFuncView: SYRMBaseView {
    
    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        super.setupUI()
        addSubview(catalogBtn)
        catalogBtn.addSubview(catalogImage)
        catalogBtn.addSubview(catalogLabel)
        addSubview(brightnessBtn)
        brightnessBtn.addSubview(brightnessImage)
        brightnessBtn.addSubview(brightnessLabel)
        addSubview(settingBtn)
        settingBtn.addSubview(settingImage)
        settingBtn.addSubview(settingLabel)
        addSubview(commentsBtn)
        commentsBtn.addSubview(commentsImage)
        commentsBtn.addSubview(commentsLabel)
        addSubview(errorsBtn)
        errorsBtn.addSubview(errorsImage)
        errorsBtn.addSubview(errorsLabel)
    }
    
    override func setupConstraints() {
        catalogBtn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        catalogImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(catalogLabel.snp.top).offset(-9.5)
        }
        catalogLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.5)
        }
        brightnessBtn.snp.makeConstraints { (make) in
            make.width.top.bottom.equalTo(catalogBtn)
            make.left.equalTo(catalogBtn.snp.right)
        }
        brightnessImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(brightnessLabel.snp.top).offset(-9.5)
        }
        brightnessLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.5)
        }
        settingBtn.snp.makeConstraints { (make) in
            make.width.top.bottom.equalTo(brightnessBtn)
            make.left.equalTo(brightnessBtn.snp.right)
        }
        settingImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(settingLabel.snp.top).offset(-9.5)
        }
        settingLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.5)
        }
        commentsBtn.snp.makeConstraints { (make) in
            make.width.top.bottom.equalTo(settingBtn)
            make.left.equalTo(settingBtn.snp.right)
        }
        commentsImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(commentsLabel.snp.top).offset(-9.5)
        }
        commentsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.5)
        }
        errorsBtn.snp.makeConstraints { (make) in
            make.width.top.bottom.equalTo(commentsBtn)
            make.left.equalTo(commentsBtn.snp.right)
        }
        errorsImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(errorsLabel.snp.top).offset(-9.5)
        }
        errorsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.5)
        }
    }
    
    /// 点击目录
    @objc private func clickCatalogue() {
        readMenu.delegate?.readMenuClickCatalogue?(readMenu: readMenu)
    }
    
    /// 点击亮度
    @objc private func clickBrightness() {
        readMenu.showBottomView(isShow: false) { [unowned self] in
            self.readMenu.showLightView(isShow: true)
        }
    }
    
    /// 点击报错
    @objc private func clickErrors() {
        readMenu.showBottomView(isShow: false) { [unowned self] in
            self.readMenu.showErrorView(isShow: true)
        }
    }
    
    /// 点击设置
    @objc private func clickSetting() {
        readMenu.showBottomView(isShow: false) { [unowned self] in
            self.readMenu.showSettingView(isShow: true)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var catalogBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(clickCatalogue), for: .touchUpInside)
        return btn
    }()
    
    lazy var catalogImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_catalog()!
        return imageView
    }()
    
    lazy var catalogLabel: UILabel = {
        let label = UILabel()
        label.text = "Catalog"
        label.textColor = UIColor(68, 68, 68)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var brightnessBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(clickBrightness), for: .touchUpInside)
        return btn
    }()
    
    lazy var brightnessImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_brightness()!
        return imageView
    }()
    
    lazy var brightnessLabel: UILabel = {
        let label = UILabel()
        label.text = "Brightness"
        label.textColor = UIColor(68, 68, 68)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(clickSetting), for: .touchUpInside)
        return btn
    }()
    
    lazy var settingImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_setting()!
        return imageView
    }()
    
    lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.textColor = UIColor(68, 68, 68)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var commentsBtn: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    lazy var commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_comments()!
        return imageView
    }()
    
    lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments"
        label.textColor = UIColor(68, 68, 68)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    lazy var errorsBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(clickErrors), for: .touchUpInside)
        return btn
    }()
    
    lazy var errorsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_errors()!
        return imageView
    }()
    
    lazy var errorsLabel: UILabel = {
        let label = UILabel()
        label.text = "Errors"
        label.textColor = UIColor(68, 68, 68)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
}
