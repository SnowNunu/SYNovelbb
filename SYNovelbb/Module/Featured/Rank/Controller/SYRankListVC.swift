//
//  SYRankListVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import JXSegmentedView
import RxDataSources

enum SYRankType {
    case popular
    case recommend
    case fellow
    case cheers
}

class SYRankListVC: SYBaseVC {
    
    var type: SYRankType? = .popular
    
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
    
    lazy var viewModel: SYRankListVM = {
        let vm = SYRankListVM()
        switch self.type {
        case .popular:
            vm.rankId = 0
            break
        case .recommend:
            vm.rankId = 1
            break
        case .fellow:
            vm.rankId = 2
            break
        default:
            vm.rankId = 3
            break
        }
        return vm
    }()
    
    override func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        viewModel.datasource.asDriver()
            .drive(collectionView.rx.items(cellIdentifier: SYBookStyle2Cell.className(), cellType: SYBookStyle2Cell.self)) { [unowned self] (row, model, cell) in
                model.type = self.type
                cell.rankModel = model
            }
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        collectionView.prepare(viewModel, SYRankListModel.self, true)
        collectionView.headerRefreshing()
        collectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                let model = self.viewModel.datasource.value[indexPath.row]
                let vc = SYBookInfoVC()
                vc.bookId = model.bid
                vc.bookName = model.bookTitle
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }

}

extension SYRankListVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
    
}
