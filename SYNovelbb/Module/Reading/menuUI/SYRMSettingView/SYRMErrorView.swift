//
//  SYRMErrorView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/12.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import YYText

class SYRMErrorView: SYRMBaseView {

    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        super.setupUI()
        addSubview(titleLabel)
        addSubview(underLine)
        addSubview(contentBtn)
        addSubview(tyopsBtn)
        addSubview(vulgarBtn)
        addSubview(textFieldBg)
        addSubview(textField)
        addSubview(cancelBtn)
        addSubview(submitBtn)
    }
    
    override func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(44)
        }
        underLine.snp.makeConstraints { (make) in
            make.width.centerX.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(titleLabel)
        }
        contentBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(textFieldBg.snp.top).offset(-15)
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(85)
            make.height.equalTo(22.5)
        }
        tyopsBtn.snp.makeConstraints { (make) in
            make.bottom.height.equalTo(contentBtn)
            make.left.equalTo(contentBtn.snp.right).offset(21)
            make.width.equalTo(85)
        }
        vulgarBtn.snp.makeConstraints { (make) in
            make.bottom.height.equalTo(contentBtn)
            make.left.equalTo(tyopsBtn.snp.right).offset(21)
            make.width.equalTo(85)
        }
        textFieldBg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
            make.bottom.equalTo(cancelBtn.snp.top).offset(-15)
            make.height.equalTo(90.5)
        }
        textField.snp.makeConstraints { (make) in
            make.center.equalTo(textFieldBg)
            make.width.equalTo(textFieldBg).offset(-30)
            make.height.equalTo(textFieldBg).offset(-20)
        }
        cancelBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.centerX).offset(-20)
            make.width.equalTo(115)
            make.height.equalTo(32.5)
            make.bottom.equalToSuperview().offset(-15 - BottomSafeAreaHeight)
        }
        submitBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(20)
            make.width.height.bottom.equalTo(cancelBtn)
        }
    }
    
    @objc func clickErrorOptions(sender: UIButton) {
        for tag in [881, 882, 883] {
            let btn = self.viewWithTag(tag) as! UIButton
            btn.isSelected = sender.tag == tag
        }
    }
    
    @objc func clickCancel() {
        readMenu.showMenu(isShow: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Report error"
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var underLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(224, 224, 224)
        return line
    }()
    
    lazy var contentBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(223, 223, 223)
        btn.setTitle("Content error", for: .normal)
        btn.setTitleColor(UIColor(115, 115, 115), for: .normal)
        btn.setBackgroundImage(UIImage(color: UIColor(241, 241, 241)), for: .normal)
        btn.setTitle("Content error", for: .selected)
        btn.setTitleColor(.white, for: .selected)
        btn.setBackgroundImage(UIImage(color: UIColor(197, 189, 171)), for: .selected)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        btn.isSelected = true
        btn.addTarget(self, action: #selector(clickErrorOptions(sender:)), for: .touchUpInside)
        btn.tag = 881
        return btn
    }()
    
    lazy var tyopsBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(223, 223, 223)
        btn.setTitle("Tyops", for: .normal)
        btn.setTitleColor(UIColor(115, 115, 115), for: .normal)
        btn.setBackgroundImage(UIImage(color: UIColor(241, 241, 241)), for: .normal)
        btn.setTitle("Tyops", for: .selected)
        btn.setTitleColor(.white, for: .selected)
        btn.setBackgroundImage(UIImage(color: UIColor(197, 189, 171)), for: .selected)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        btn.addTarget(self, action: #selector(clickErrorOptions(sender:)), for: .touchUpInside)
        btn.tag = 882
        return btn
    }()
    
    lazy var vulgarBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(223, 223, 223)
        btn.setTitle("Vulgar", for: .normal)
        btn.setTitleColor(UIColor(115, 115, 115), for: .normal)
        btn.setBackgroundImage(UIImage(color: UIColor(241, 241, 241)), for: .normal)
        btn.setTitle("Vulgar", for: .selected)
        btn.setTitleColor(.white, for: .selected)
        btn.setBackgroundImage(UIImage(color: UIColor(197, 189, 171)), for: .selected)
        btn.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        btn.addTarget(self, action: #selector(clickErrorOptions(sender:)), for: .touchUpInside)
        btn.tag = 883
        return btn
    }()
    
    lazy var textFieldBg: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor(223, 223, 223).cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    lazy var textField: YYTextView = {
        let textField = YYTextView()
        textField.placeholderText = "Supplementary instruction……"
        textField.placeholderTextColor = UIColor(223, 223, 223)
        textField.placeholderFont = .systemFont(ofSize: 12, weight: .regular)
        textField.font = .systemFont(ofSize: 12, weight: .regular)
        return textField
    }()
    
    lazy var cancelBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor(223, 223, 223)
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(UIColor(51, 51, 51), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        btn.addTarget(self, action: #selector(clickCancel), for: .touchUpInside)
        return btn
    }()
    
    lazy var submitBtn: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        btn.backgroundColor = UIColor(243, 201, 28)
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(UIColor(51, 51, 51), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        return btn
    }()

}
