//
//  SYRMLightView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYRMLightView: SYRMBaseView {
    
    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        super.setupUI()
        addSubview(darkImageView)
        addSubview(brightImageView)
        addSubview(slider)
    }
    
    override func setupConstraints() {
        darkImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(20)
            make.centerY.equalTo(slider)
        }
        slider.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview().offset(-BottomSafeAreaHeight)
            make.left.equalTo(darkImageView.snp.right).offset(20)
            make.right.equalTo(brightImageView.snp.left).offset(-20)
        }
        brightImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(darkImageView)
            make.centerY.equalTo(slider)
        }
    }
    
    /// 滑块变化
    @objc private func sliderChanged(_ slider:UISlider) {
        UIScreen.main.brightness = CGFloat(slider.value)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var darkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_light_dark()!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(51, 51, 51)
        return imageView
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.value = Float(UIScreen.main.brightness)
        slider.addTarget(self, action: #selector(sliderChanged(_:)), for: .valueChanged)
        slider.setThumbImage(R.image.reading_slider_thumb()!.withRenderingMode(.alwaysTemplate), for: .normal)
        // 设置当前进度颜色
        slider.minimumTrackTintColor = UIColor(244, 202, 28)
        // 设置总进度颜色
        slider.maximumTrackTintColor = UIColor(238, 238, 238)
        // 设置当前拖拽圆圈颜色
        slider.tintColor = UIColor(244, 202, 28)
        return slider
    }()
    
    lazy var brightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.reading_light_bright()!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor(51, 51, 51)
        return imageView
    }()
    
}
