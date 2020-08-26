//
//  SYHomeNormalHeader.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/24.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxSwift

class SYHomeNormalHeader: UICollectionReusableView {
    
    var disposeBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        disposeBag = DisposeBag()
        addSubview(lineView)
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(changeBtn)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayouts() {
        let width = self.frame.size.width
        
        lineView.snp.makeConstraints { (make) in
            make.centerX.top.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(width)
        }
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(lineView.snp.bottom)
            make.width.equalTo(width)
            make.height.equalTo(40)
        }
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(18)
            make.left.equalToSuperview().offset(15)
        }
        changeBtn.snp.makeConstraints { (make) in
            make.width.equalTo(65)
            make.centerY.height.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(244, 241, 242)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(51, 51, 51)
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var changeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change ", for: .normal)
        btn.setTitleColor(UIColor(198, 189, 172), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10.5, weight: .regular)
        btn.setImage(R.image.home_change(), for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        return btn
    }()
        
}
