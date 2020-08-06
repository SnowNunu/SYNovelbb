//
//  SYBaseVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NVActivityIndicatorView

class SYBaseVC: UIViewController {
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    lazy var activityIndicatorView: NVActivityIndicatorView = {
        let indicatorView = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: UIColor(83, 83, 83), padding: (ScreenWidth - 80) / 2)
        indicatorView.backgroundColor = .white
        return indicatorView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(activityIndicatorView)
        setupUI()
        rxBind()
        view.bringSubviewToFront(activityIndicatorView)
    }
    
    func setupUI() {}
    
    func rxBind() {}

    deinit {
        logInfo("\(self)已释放")
    }

}
