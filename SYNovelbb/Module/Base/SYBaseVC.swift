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
import DZNEmptyDataSet

class SYBaseVC: UIViewController {
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    lazy var activityIndicatorView: NVActivityIndicatorView = {
        let indicatorView = NVActivityIndicatorView(frame: self.view.frame, type: .ballRotateChase, color: UIColor(83, 83, 83), padding: (ScreenWidth - 80) / 2)
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

extension SYMineRecordVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    // 设置占位图显示图片内容
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        let (result, _) = viewModel.requestStatus.value
        return !result ? R.image.mine_record_empty()! : UIImage()
    }
    
    // 设置占位图图片下文字显示内容
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString.init(string: "Bad network\nPlease check if your phone is connected")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(160, 160, 160), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(200, 200, 200), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], range: NSMakeRange(11, attributedString.length - 11))
//        let attributedString = NSMutableAttributedString.init(string: "No records!")
//        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(51, 51, 51), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString.init(string: "Reload")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(160, 160, 160), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        return R.image.mine_reload()!
    }
}
