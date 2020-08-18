//
//  SYReadSubscribeView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadSubscribeView: UIView {
    
    /// 当前阅读模型
    var readModel: SYReadModel! {
        didSet {
            titleLabel.text = readModel.recordModel.chapterModel.name
            contentLabel.text = readModel.recordModel.chapterModel.content
            priceLabel.text = "\(readModel.recordModel.chapterModel.chapterMoney ?? 0) Coins to unlock this chapter"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        addSubview(priceLabel)
        addSubview(rechargeInfoLabel)
        addSubview(balanceLabel)
        addSubview(autoUnlockBtn)
        addSubview(autoUnlockLabel)
        addSubview(rechargeBtn)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.equalToSuperview().offset(37 + StatusBarHeight)
        }
        contentLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-40)
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(rechargeInfoLabel.snp.top).offset(-35)
        }
        rechargeInfoLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(balanceLabel.snp.top).offset(-40)
            make.centerX.equalToSuperview()
        }
        balanceLabel.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.bottom.equalTo(autoUnlockLabel.snp.top).offset(-65)
        }
        autoUnlockBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(15)
            make.right.equalTo(autoUnlockLabel.snp.left).offset(-10)
            make.centerY.equalTo(autoUnlockLabel)
        }
        autoUnlockLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(rechargeBtn.snp.top).offset(-14)
            make.centerX.equalToSuperview().offset(12.5)
        }
        rechargeBtn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-BottomSafeAreaHeight - 65)
            make.height.equalTo(40)
        }
    }
    
    @objc func updateAutoUnlockBtn() {
        autoUnlockBtn.isSelected = !autoUnlockBtn.isSelected
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(115, 115, 115)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var rechargeInfoLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString.init(string: "Need to pay:  $4.99 (Get 350Coins+35Vouchers)")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(51, 51, 51), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(177, 143, 0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)], range: NSMakeRange(14, 5))
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(177, 143, 0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)], range: NSMakeRange(19, attributedString.length - 19))
        label.textAlignment = .center
        label.attributedText = attributedString
        return label
    }()
    
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Balance: 0 Coins + 0 Vouchers"
        label.textColor = UIColor(115, 115, 115)
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11, weight: .regular)
        return label
    }()
    
    lazy var autoUnlockBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.reading_autounlock_unselected()!, for: .normal)
        btn.setImage(R.image.reading_autounlock_selected()!, for: .selected)
        btn.isSelected = true
        btn.addTarget(self, action: #selector(updateAutoUnlockBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var autoUnlockLabel: UILabel = {
        let label = UILabel()
        label.text = "Auto unlock next locked chapter"
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 11, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    lazy var rechargeBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(244, 202, 28)
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.setTitle("To Recharge", for: .normal)
        btn.setTitleColor(UIColor(51, 51, 51), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .regular)
        return btn
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
