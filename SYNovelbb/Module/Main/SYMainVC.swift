//
//  SYMainVC.swift
//  SYNovelbb
//  过渡用(保证进入主页面时本地已有用户数据)
//  Created by Mandora on 2020/8/5.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RealmSwift

class SYMainVC: SYBaseVC {
    
    lazy var viewModel: SYMainVM = {
        let vm = SYMainVM()
        return vm
    }()
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var tipsView: UIView!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func setupUI() {
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func rxBind() {
        viewModel.userIsOK
            .skip(1)
            .subscribe(onNext: { (isOK) in
                if isOK {
                    DispatchQueue.main.async {
                        userDefault.isBookcase = true
                        if userDefault.isBookcase {
                            UIApplication.shared.keyWindow?.rootViewController = R.storyboard.bookcase().instantiateInitialViewController()
                        } else {
                            UIApplication.shared.keyWindow?.rootViewController = SYTabBarController()
                        }
                    }
                }
            }).disposed(by: disposeBag)
        
        viewModel.requestStatus
            .skip(1)
            .subscribe(onNext: { [unowned self] (result, message) in
                if result {
                    
                } else {
                    if self.activityIndicatorView.isAnimating {
                        self.activityIndicatorView.stopAnimating()
                    }
                    self.bgView.isHidden = true
                    self.tipsView.isHidden = false
                    self.detailLabel.text = message
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.checkLocalUserInfo()
    }

    @IBAction func reloadAction(_ sender: UIButton) {
        self.activityIndicatorView.startAnimating()
        viewModel.reloadSubject.onNext(true)
    }
}
