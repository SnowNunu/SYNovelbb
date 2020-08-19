//
//  SYBookFilterHeaderView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay
import RxSwift

class SYBookFilterHeaderView: UIView {
    
    var datasource = BehaviorRelay<[String]>(value: [])
    
    var disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        disposeBag = DisposeBag()
        setupUI()
        setupConstraints()
        rxBind()
    }
    
    private func setupUI() {
        addSubview(keywordsCollectionView)
        addSubview(chooseBtn)
    }
    
    private func setupConstraints() {
        keywordsCollectionView.snp.makeConstraints { (make) in
            make.centerY.height.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.equalTo(ScreenWidth - 100)
        }
        chooseBtn.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.width.equalTo(55)
            make.height.equalTo(20)
        }
    }
    
    func rxBind() {
        datasource.asDriver()
            .drive(keywordsCollectionView.rx.items(cellIdentifier: SYBookFilterKeywordsCell.className(), cellType: SYBookFilterKeywordsCell.self)) { [unowned self] (row, model, cell) in
                cell.titleLabel.text = model
                cell.line.isHidden = row == self.datasource.value.count - 1
            }
            .disposed(by: disposeBag)
        
        keywordsCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var keywordsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SYBookFilterKeywordsCell.self, forCellWithReuseIdentifier: SYBookFilterKeywordsCell.className())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var chooseBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Choose ", for: .normal)
        btn.setTitleColor(UIColor(52, 52, 52), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        btn.setImage(R.image.home_choose_down(), for: .normal)
        btn.semanticContentAttribute = .forceRightToLeft
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor(52, 52, 52).cgColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        return btn
    }()
    
}

extension SYBookFilterHeaderView: UICollectionViewDelegateFlowLayout {
    
    /// 返回cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cgsize = datasource.value[indexPath.row].size(.systemFont(ofSize: 11, weight: .regular))
        return .init(width: cgsize.width + 15, height: 50)
    }
    
}


class SYBookFilterKeywordsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(line)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.left.equalToSuperview()
        }
        line.snp.makeConstraints { (make) in
            make.centerY.right.equalToSuperview()
            make.width.equalTo(1)
            make.height.equalTo(8.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(51, 51, 51)
        label.font = .systemFont(ofSize: 11, weight: .regular)
        return label
    }()
    
    lazy var line: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(51, 51, 51)
        return view
    }()
    
}
