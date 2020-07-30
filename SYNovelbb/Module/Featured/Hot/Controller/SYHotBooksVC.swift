//
//  SYHotBooksVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYHotBooksVC: SYBaseVC {
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: ScreenWidth - 30, height: 115)
        flowLayout.sectionInset = .init(top: 15, left: 15, bottom: 0, right: 15)
        flowLayout.minimumLineSpacing = 15
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(SYBookStyle2Cell.self, forCellWithReuseIdentifier: SYBookStyle2Cell.className())
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var viewModel: SYHotBooksVM = {
        let vm = SYHotBooksVM()
        return vm
    }()

    override func setupUI() {
        self.title = "Hot book"
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYBaseBookModel>>.init(configureCell: { (_, collectionView, indexPath, model) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYBookStyle2Cell.className(), for: indexPath) as! SYBookStyle2Cell
            cell.bookModel = model
            return cell
        })
        
        viewModel.datasource.asDriver().drive(collectionView.rx.items(dataSource: datasource)).disposed(by: disposeBag)
    }
    
    override func rxBind() {
        collectionView.prepare(viewModel, SectionModel<String, SYBaseBookModel>.self)
        collectionView.headerRefreshing()
    }
}
