//
//  SYBookFilterOptionsView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay

class SYBookFilterOptionsView: UIView {
    
    var datasource = BehaviorRelay<[SectionModel<String, SYFilterKeyModel>]>(value: [SectionModel<String, SYFilterKeyModel>]())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        rxBind()
    }
    
    private func setupUI() {
        addSubview(collectionView)
        addSubview(underLine)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.centerX.width.top.equalToSuperview()
            make.bottom.equalTo(underLine.snp.top)
        }
        underLine.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.height.equalTo(5)
        }
    }
    
    private func rxBind() {
//        let ds = RxCollectionViewSectionedReloadDataSource<SectionModel<String, sy>>
        let ds = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYFilterKeyModel>>.init(configureCell: { (_, collectionView, indexPath, model) -> UICollectionViewCell in
            
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYEmptyCell.className(), for: indexPath) as! SYEmptyCell
                return cell
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = SYAlignFlowLayout(.left, 25)
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(242, 242, 242)
        return view
    }()
}
