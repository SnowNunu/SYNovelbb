//
//  SYRankVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/28.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import JXSegmentedView

class SYRankVC: SYBaseVC {
    
    lazy var viewModel: SYRankVM = {
        let vm = SYRankVM()
        return vm
    }()
    
    lazy var segmentedView: JXSegmentedView = {
        let view = JXSegmentedView()
        view.backgroundColor = UIColor(239, 186, 0)
        return view
    }()
    
    lazy var segmentedDataSource: JXSegmentedBaseDataSource = {
        let dataSource = JXSegmentedTitleDataSource()
        dataSource.titleSelectedColor = UIColor(255, 242, 195)    // 设置常规颜色
        dataSource.titleNormalColor = UIColor(51, 51, 51) // 设置选中后的颜色
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        dataSource.isTitleColorGradientEnabled = true   // 颜色渐变
        dataSource.titles = ["Popular", "Recommend", "Fellow", "Cheers"]
        let indicator = JXSegmentedIndicatorTriangleView()
        indicator.indicatorColor = .white
        segmentedView.indicators = [indicator]
        return dataSource
    }()
    
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

    override func setupUI() {
        view.addSubview(topView)
        topView.addSubview(backBtn)
        topView.addSubview(rankTitle)
        topView.addSubview(rankContent)
        topView.addSubview(cupImage)
        view.addSubview(segmentedView)
        segmentedView.listContainer = listContainerView
        segmentedView.dataSource = segmentedDataSource
        view.addSubview(listContainerView)
        
        topView.snp.makeConstraints { (make) in
            make.top.centerX.width.equalToSuperview()
            make.height.equalTo(153.5 + StatusBarHeight)
        }
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(44)
            make.top.equalToSuperview().offset(StatusBarHeight)
        }
        rankTitle.snp.makeConstraints { (make) in
            make.left.equalTo(rankContent)
            make.bottom.equalTo(rankContent.snp.top).offset(-10)
        }
        rankContent.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.bottom.equalTo(cupImage).offset(-26.5)
        }
        cupImage.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(88)
            make.height.equalTo(123.5)
            make.right.equalToSuperview().offset(-48.5)
        }
        segmentedView.snp.makeConstraints { (make) in
            make.centerX.width.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(44)
        }
        listContainerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(segmentedView.snp.bottom)
        }
    }
    
    override func rxBind() {
        backBtn.rx.tap
            .subscribe(onNext: { [unowned self]  in
                self.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(244, 209, 67)
        return view
    }()
    
    lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(R.image.navigation_back(), for: .normal)
        return btn
    }()
    
    lazy var rankTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(51, 51, 51)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "Ranking List"
        return label
    }()
    
    lazy var rankContent: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(177, 143, 0)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Update the latest ranking every day"
        return label
    }()
    
    lazy var cupImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.rank_cup()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

}

extension SYRankVC: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }

    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let vc = SYRankListVC()
        switch index {
        case 0:
            vc.type = .popular
            break
        case 1:
            vc.type = .recommend
            break
        case 2:
            vc.type = .fellow
            break
        default:
            vc.type = .cheers
            break
        }
        return vc
    }
}
