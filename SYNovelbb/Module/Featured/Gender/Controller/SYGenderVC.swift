//
//  SYGenderVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import JXBanner
import JXPageControl
import JXSegmentedView

class SYGenderVC: SYBaseVC {
    
    // 性别(默认为男性)
    var gender: Bool = true
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(SYBookStyle1Cell.self, forCellWithReuseIdentifier: SYBookStyle1Cell.className())
        collectionView.register(SYBookStyle2Cell.self, forCellWithReuseIdentifier: SYBookStyle2Cell.className())
        collectionView.register(SYBookStyle3Cell.self, forCellWithReuseIdentifier: SYBookStyle3Cell.className())
        collectionView.register(SYHomeSlideHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SYHomeSlideHeader.className())
        collectionView.register(SYHomeNormalHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SYHomeNormalHeader.className())
        return collectionView
    }()
    
    lazy var viewModel: SYHomeVM = {
        let viewModel = SYHomeVM()
        return viewModel
    }()
    
    override func setupUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYIndexModel>>.init(configureCell: { (datasource, collectionView, indexPath, element) -> UICollectionViewCell in
            let model = datasource.sectionModels[indexPath.section].items[indexPath.row]
            switch indexPath.section {
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYBookStyle1Cell.className(), for: indexPath) as! SYBookStyle1Cell
                cell.model = model
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYBookStyle2Cell.className(), for: indexPath) as! SYBookStyle2Cell
                cell.model = model
                return cell
            case 3:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYBookStyle3Cell.className(), for: indexPath) as! SYBookStyle3Cell
                cell.model = model
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYBookStyle1Cell.className(), for: indexPath) as! SYBookStyle1Cell
                return cell
            }
        }, configureSupplementaryView: { [unowned self] (datasource, collectionView, title, indexPath) -> UICollectionReusableView in
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SYHomeSlideHeader.className(), for: indexPath) as! SYHomeSlideHeader
                header.banner.delegate = self
                header.banner.dataSource = self
                header.listBtn.rx.tap.bind { [unowned self] in
                    let vc = UIViewController()
                    vc.view.backgroundColor = .red
                    self.navigationController?.pushViewController(vc, animated: true)
                }.disposed(by: header.disposeBag)
                return header
            } else {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SYHomeNormalHeader.className(), for: indexPath) as! SYHomeNormalHeader
                switch indexPath.section {
                case 1:
                    header.titleLabel.text = "High Score"
                case 2:
                    header.titleLabel.text = "Editor's recommendation"
                default:
                    header.titleLabel.text = "Guess you like it"
                }
                return header
            }
        })
        
        viewModel.datasource.asDriver()
            .drive(collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        viewModel.reloadSubject.onNext(true)
    }

}

extension SYGenderVC: UICollectionViewDelegateFlowLayout {
    
    // 设置边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 15, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 3 {
            return 0
        } else {
            return 15
        }
    }
    
    // 设置cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return .init(width: 0, height: 0)
        case 1:
            let width = (ScreenWidth - 64.5) / 4
            let height = width * (155 / 77.5)
            return .init(width: width, height: height)
        case 2:
            return .init(width: ScreenWidth - 30, height: 115)
        default:
            return .init(width: ScreenWidth - 30, height: 64.5)
        }
    }

    // 设置header大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            let width = (ScreenWidth - 30)
            let height = 15 + width * (105 / 345) + width * (130 / 345) * (139 / 130)
            return .init(width: width, height: height)
        } else {
            return .init(width: ScreenWidth - 30, height: 45)
        }
    }
    
}

// MARK: JXSegmentedListContainerViewListDelegate
extension SYGenderVC: JXSegmentedListContainerViewListDelegate {
    
    func listView() -> UIView {
        return view
    }
}

// MARK: JXBannerDelegate, JXBannerDataSource
extension SYGenderVC: JXBannerDelegate, JXBannerDataSource {
    
    // 注册cell重用标识
    func jxBanner(_ banner: JXBannerType) -> (JXBannerCellRegister) {
        return JXBannerCellRegister(type: JXBannerCell.self, reuseIdentifier: JXBannerCell.className())
    }

    // 轮播总数
    func jxBanner(numberOfItems banner: JXBannerType) -> Int {
        return viewModel.datasource.value.first!.items.count
    }
    
    func jxBanner(_ banner: JXBannerType, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell {
        let model = (viewModel.datasource.value.first!.items[index])
        let cell: JXBannerCell = cell as! JXBannerCell
        cell.layer.cornerRadius = 5
        cell.layer.masksToBounds = true
        cell.msgBgView.backgroundColor = .clear
        cell.imageView.kf.setImage(with: URL(string: model.readTxt))
        return cell
    }
    
    func jxBanner(pageControl banner: JXBannerType, numberOfPages: Int, coverView: UIView, builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
        let pageControl = JXPageControlScale()
        pageControl.contentMode = .bottom
        pageControl.activeSize = CGSize(width: 15, height: 5)
        pageControl.inactiveSize = CGSize(width: 5, height: 5)
        pageControl.activeColor = UIColor(244, 202, 28)
        pageControl.inactiveColor = .white
        pageControl.columnSpacing = 0
        pageControl.isAnimation = true
        builder.pageControl = pageControl
        builder.layout = {
            pageControl.snp.makeConstraints { (maker) in
                maker.left.right.equalTo(coverView)
                maker.bottom.equalTo(coverView).offset(-5)
                maker.height.equalTo(20)
            }
        }
        return builder
    }
    
    // banner基本设置（可选）
    func jxBanner(_ banner: JXBannerType, layoutParams: JXBannerLayoutParams) -> JXBannerLayoutParams {
        return layoutParams
            .itemSize(CGSize(width: ScreenWidth - 30, height: (ScreenWidth - 30) * (105 / 345)))
            .itemSpacing(15)
    }
    
    // 点击cell回调
    func jxBanner(_ banner: JXBannerType, didSelectItemAt index: Int) {
        self.navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
}
