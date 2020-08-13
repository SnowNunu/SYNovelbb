//
//  SYFeaturedVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import JXSegmentedView
import SnapKit

class SYFeaturedVC: SYBaseVC {
    
    lazy var segmentedView: JXSegmentedView = {
        let view = JXSegmentedView()
        return view
    }()
    
    lazy var searchBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(240, 240, 240)
        btn.setTitle("  Search anthor or book title", for: .normal)
        btn.setTitleColor(UIColor(140, 140, 140), for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.setImage(R.image.home_search(), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        btn.layer.cornerRadius = 15
        return btn
    }()
    
    lazy var segmentedDataSource: JXSegmentedBaseDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titleNormalColor = UIColor(51, 51, 51)   // 设置常规颜色
        dataSource.titleSelectedColor = UIColor(51, 51, 51) // 设置选中后的颜色
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 16, weight: .regular)
        dataSource.titleSelectedFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        dataSource.isSelectedAnimable = true
        dataSource.titles = ["Home", "Male", "Female"]
        let indicator = JXSegmentedIndicatorLineView()
        indicator.indicatorWidth = JXSegmentedViewAutomaticDimension
        indicator.indicatorColor = UIColor(244, 202, 28)
        indicator.verticalOffset = 8
        segmentedView.indicators = [indicator]
        return dataSource
    }()
    
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func setupUI() {
        segmentedView.dataSource = segmentedDataSource
        view.addSubview(segmentedView)
        view.addSubview(searchBtn)
        segmentedView.listContainer = listContainerView
        view.addSubview(listContainerView)
        
        segmentedView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.top.equalToSuperview().offset(StatusBarHeight)
            make.height.equalTo(46.5)
        }
        searchBtn.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedView.snp_bottom)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
        }
        listContainerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchBtn.snp.bottom).offset(15)
        }
    }
    
    override func rxBind() {
        searchBtn.rx.tap
            .bind { [unowned self] in
                let vc = R.storyboard.featured.searchVC()!
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }

}

extension SYFeaturedVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            return SYHomeVC()
        } else if (index == 1) {
            return SYGenderVC()
        } else {
            let vc = SYGenderVC()
            vc.gender = false
            return vc
        }
    }
}
