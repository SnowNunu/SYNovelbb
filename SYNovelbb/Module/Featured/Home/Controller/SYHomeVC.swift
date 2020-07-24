//
//  SYHomeVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import JXSegmentedView

class SYHomeVC: SYBaseVC {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.register(SYBookStyle1Cell.self, forCellWithReuseIdentifier: SYBookStyle1Cell.className())
        collectionView.register(SYHomeSliderHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SYHomeSliderHeader.className())
        return collectionView
    }()
    
    lazy var viewModel: SYHomeVM = {
        let viewModel = SYHomeVM()
        return viewModel
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.reloadSubject.onNext(true)
    }
    
    override func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYIndexModel>>.init(configureCell: { [unowned self] (datasource, collectionView, indexPath, element) -> UICollectionViewCell in
            print(self)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYBookStyle1Cell.className(), for: indexPath)
            return cell
        }, configureSupplementaryView: { (datasource, collectionView, title, indexPath) -> UICollectionReusableView in
            print(datasource)
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SYHomeSliderHeader.className(), for: indexPath)
            return header
        })
        
        viewModel.datasource.asDriver()
            .drive(collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        
    }

}

// MARK: JXSegmentedListContainerViewListDelegate
extension SYHomeVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
}


extension SYHomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: ScreenWidth, height: 500)
    }
    
}
