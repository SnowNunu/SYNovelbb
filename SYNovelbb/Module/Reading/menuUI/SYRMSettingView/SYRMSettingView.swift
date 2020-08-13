//
//  SYRMSettingView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYRMSettingView: SYRMBaseView {

    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        super.setupUI()
        addSubview(backgroundLabel)
        addSubview(color1Btn)
        addSubview(color2Btn)
        addSubview(color3Btn)
        addSubview(color4Btn)
        addSubview(effectLabel)
        addSubview(sizeLabel)
        addSubview(noEffectBtn)
        addSubview(coverBtn)
        addSubview(simulationBtn)
        addSubview(sizeReduceBtn)
        addSubview(sizeIncreaseBtn)
        let btn = self.viewWithTag(SYReadConfigure.shared().bgColorIndex.intValue + 666) as! UIButton
        changeBgColor(sender: btn)
    }
    
    override func setupConstraints() {
        backgroundLabel.snp.makeConstraints { (make) in
            make.left.equalTo(effectLabel)
            make.bottom.equalTo(effectLabel.snp.top).offset(-36)
            make.width.equalTo(83)
        }
        let margin = (ScreenWidth - 173 - 28 * 4) / 3
        color1Btn.snp.makeConstraints { (make) in
            make.width.height.equalTo(28)
            make.centerY.equalTo(backgroundLabel)
            make.left.equalTo(backgroundLabel.snp.right).offset(30)
        }
        color2Btn.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(color1Btn)
            make.left.equalTo(color1Btn.snp.right).offset(margin)
        }
        color3Btn.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(color1Btn)
            make.left.equalTo(color2Btn.snp.right).offset(margin)
        }
        color4Btn.snp.makeConstraints { (make) in
            make.centerY.width.height.equalTo(color1Btn)
            make.right.equalToSuperview().offset(-30)
        }
        effectLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.centerY.equalToSuperview()
            make.width.equalTo(backgroundLabel)
        }
        let effectBtnWidth = (ScreenWidth - 173) / 3
        noEffectBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(effectLabel)
            make.width.equalTo(effectBtnWidth)
            make.left.equalTo(effectLabel.snp.right).offset(30)
            make.height.equalTo(30)
        }
        coverBtn.snp.makeConstraints { (make) in
            make.width.height.centerY.equalTo(noEffectBtn)
            make.left.equalTo(noEffectBtn.snp.right)
        }
        simulationBtn.snp.makeConstraints { (make) in
            make.width.height.centerY.equalTo(noEffectBtn)
            make.right.equalToSuperview().offset(-30)
        }
        sizeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(effectLabel)
            make.top.equalTo(effectLabel.snp.bottom).offset(38)
            make.width.equalTo(backgroundLabel)
        }
        let sizeBtnWidth = (ScreenWidth - 188) / 2
        sizeReduceBtn.snp.makeConstraints { (make) in
            make.left.equalTo(sizeLabel.snp.right).offset(30)
            make.width.equalTo(sizeBtnWidth)
            make.height.equalTo(28)
            make.centerY.equalTo(sizeLabel)
        }
        sizeIncreaseBtn.snp.makeConstraints { (make) in
            make.width.centerY.height.equalTo(sizeReduceBtn)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    /// 修改阅读背景颜色
    @objc private func changeBgColor(sender: UIButton) {
        for tag in [666, 667, 668, 669] {
            let btn = self.viewWithTag(tag) as! UIButton
            if tag == sender.tag {
                btn.layer.borderColor = UIColor(244, 202, 28).cgColor
            } else {
                btn.layer.borderColor = UIColor(115, 115, 115).cgColor
            }
        }
        SYReadConfigure.shared().bgColorIndex = NSNumber(value: sender.tag - 666)
        SYReadConfigure.shared().save()
        readMenu.delegate.readMenuClickBGColor?(readMenu: readMenu)
    }
    
    /// 更改翻页效果
    @objc private func changeEffect(sender: UIButton) {
        for tag in [810, 811, 814] {
            let btn = self.viewWithTag(tag) as! UIButton
            btn.isSelected = tag == sender.tag
        }
        SYReadConfigure.shared().effectIndex = NSNumber(value: sender.tag - 810)
        SYReadConfigure.shared().save()
        readMenu.delegate.readMenuClickEffect?(readMenu: readMenu)
    }
    
    /// 减小字体大小
    @objc private func reduceFontSize() {
        let size = NSNumber(value: SYReadConfigure.shared().fontSize.intValue - SY_READ_FONT_SIZE_SPACE)
        if !(size.intValue < SY_READ_FONT_SIZE_MIN) {
            SYReadConfigure.shared().fontSize = size
            SYReadConfigure.shared().save()
            readMenu.delegate.readMenuClickFontSize?(readMenu: readMenu)
        }
    }
    
    /// 增大字体大小
    @objc private func increaseFontSize() {
        let size = NSNumber(value: SYReadConfigure.shared().fontSize.intValue + SY_READ_FONT_SIZE_SPACE)
        if !(size.intValue > SY_READ_FONT_SIZE_MAX) {
            SYReadConfigure.shared().fontSize = size
            SYReadConfigure.shared().save()
            readMenu.delegate.readMenuClickFontSize?(readMenu: readMenu)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundLabel: UILabel = {
        let label = UILabel()
        label.text = "Background"
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var color1Btn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 14
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(115, 115, 115).cgColor
        btn.backgroundColor = SY_READ_BG_COLORS[0]
        btn.layer.masksToBounds = true
        btn.tag = 666
        btn.addTarget(self, action: #selector(changeBgColor(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var color2Btn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 14
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(115, 115, 115).cgColor
        btn.backgroundColor = SY_READ_BG_COLORS[1]
        btn.layer.masksToBounds = true
        btn.tag = 667
        btn.addTarget(self, action: #selector(changeBgColor(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var color3Btn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 14
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(115, 115, 115).cgColor
        btn.backgroundColor = SY_READ_BG_COLORS[2]
        btn.layer.masksToBounds = true
        btn.tag = 668
        btn.addTarget(self, action: #selector(changeBgColor(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var color4Btn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 14
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(115, 115, 115).cgColor
        btn.backgroundColor = SY_READ_BG_COLORS[3]
        btn.layer.masksToBounds = true
        btn.tag = 669
        btn.addTarget(self, action: #selector(changeBgColor(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var effectLabel: UILabel = {
        let label = UILabel()
        label.text = "Effect"
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var noEffectBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("No Effect", for: .normal)
        btn.setTitleColor(UIColor(198, 189, 172), for: .normal)
        btn.setTitleColor(UIColor(177, 143, 0), for: .selected)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        btn.tag = 814
        btn.isSelected = SYReadConfigure.shared().effectIndex == NSNumber(value: 4)
        btn.addTarget(self, action: #selector(changeEffect(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var coverBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cover", for: .normal)
        btn.setTitleColor(UIColor(198, 189, 172), for: .normal)
        btn.setTitleColor(UIColor(177, 143, 0), for: .selected)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        btn.tag = 811
        btn.isSelected = SYReadConfigure.shared().effectIndex == NSNumber(value: 1)
        btn.addTarget(self, action: #selector(changeEffect(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var simulationBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Simulation", for: .normal)
        btn.setTitleColor(UIColor(198, 189, 172), for: .normal)
        btn.setTitleColor(UIColor(177, 143, 0), for: .selected)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        btn.tag = 810
        btn.isSelected = SYReadConfigure.shared().effectIndex == NSNumber(value: 0)
        btn.addTarget(self, action: #selector(changeEffect(sender:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Size"
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var sizeReduceBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("A-", for: .normal)
        btn.setTitleColor(UIColor(115, 115, 115), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(147, 147, 147).cgColor
        btn.layer.cornerRadius = 14
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(reduceFontSize), for: .touchUpInside)
        return btn
    }()
    
    lazy var sizeIncreaseBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("A+", for: .normal)
        btn.setTitleColor(UIColor(115, 115, 115), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(147, 147, 147).cgColor
        btn.layer.cornerRadius = 14
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(increaseFontSize), for: .touchUpInside)
        return btn
    }()
    
}
