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
import RxSwift

class SYBookFilterOptionsView: UIView {
    
    private weak var owner: SYBookFilterVC!
    
    var datasource = BehaviorRelay<[SectionModel<String, SYFilterKeyModel>]>(value: [SectionModel<String, SYFilterKeyModel>]())
    
    var disposeBag = DisposeBag()
    
    /// 搜素关键字
    var params = BehaviorRelay<[String: String]>(value: [String: String]())

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
            make.height.equalTo(0)
        }
        underLine.snp.makeConstraints { (make) in
            make.width.centerX.bottom.equalToSuperview()
            make.height.equalTo(5)
        }
    }
    
    private func rxBind() {
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 25
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = .init(top: 0, left: 15, bottom: 0, right: 15)
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(SYBookFilterOptionsCell.self, forCellWithReuseIdentifier: SYBookFilterOptionsCell.className())
        return collectionView
    }()
    
    lazy var underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(242, 242, 242)
        return view
    }()
    
}

extension SYBookFilterOptionsView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let model = datasource.value[indexPath.section].items[indexPath.row]
            let size = model.title.size(.systemFont(ofSize: 11, weight: .regular))
            return .init(width: ceil(size.width), height: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: ScreenWidth, height: 10)
    }
}
