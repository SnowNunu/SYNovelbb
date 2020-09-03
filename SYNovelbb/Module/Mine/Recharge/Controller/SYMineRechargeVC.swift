//
//  SYMineRechargeVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class SYMineRechargeVC: SYBaseVC {

    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var viewModel: SYMineRechargeVM = {
        let vm = SYMineRechargeVM()
        return vm
    }()
    
    // 默认选中的商品下标
    var selectedIndex: Int = 0
    
    override func rxBind() {
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYMineRechargeModel>>.init(configureCell: { [unowned self] (_, collectionView, indexPath, model) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SYMineRechargeCell", for: indexPath) as! SYMineRechargeCell
            cell.model = model
            cell.backgroundColor = indexPath.row == self.selectedIndex ? UIColor(255, 220, 44) : .white
            return cell
        }, configureSupplementaryView: { (datasource, collectionView, kind, indexPath) -> UICollectionReusableView in
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SYMineRechargeHeader", for: indexPath)
                return header
            } else {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SYMineRechargeFooter", for: indexPath) as! SYMineRechargeFooter
                footer.rechargeBtn.rx.tap
                    .bind { [unowned self] in
                        if self.viewModel.datasource.value.count > 0 {
                            let model = self.viewModel.datasource.value.first!.items[self.selectedIndex]
                            ApplePayManager.share.checkPay(model)
                        }
                    }
                    .disposed(by: footer.disposeBag)
                return footer
            }
        })
        
        viewModel.datasource
            .asDriver()
            .drive(collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                self.selectedIndex = indexPath.row
                self.collectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        collectionView.prepare(viewModel, SectionModel<String, SYMineRechargeModel>.self)
        collectionView.headerRefreshing()
    }
    
}

extension SYMineRechargeVC: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 15, left: 15, bottom: 25, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: ScreenWidth, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: ScreenWidth, height: 210)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (ScreenWidth - 40) / 2
        let height = width * (60 / 167.5)
        return .init(width: width, height: height)
    }
    
}
