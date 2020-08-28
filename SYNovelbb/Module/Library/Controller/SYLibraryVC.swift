//
//  SYLibraryVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay

class SYLibraryVC: SYBaseVC {
    
    lazy var viewModel: SYLibraryVM = {
        let vm = SYLibraryVM()
        return vm
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var headerBgView: UIView!
    
    @IBOutlet weak var normalHeaderView: SYLibrayNormalHeaderView!
    
    @IBOutlet weak var editHeaderView: SYLibraryEditHeaderView!
    
    lazy var confirmBtn: UIButton = {
        let btn = UIButton()
        btn.frame = .init(x: 0, y: ScreenHeight - 49 - BottomSafeAreaHeight, width: ScreenWidth, height: 49)
        btn.setTitle("Confirm Delete", for: .normal)
        btn.setTitleColor(UIColor(178, 143, 0), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        return btn
    }()
    
    var isEdit = BehaviorRelay<Bool>(value: false)
    
    override func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        collectionView.prepare(viewModel, SYBaseBookModel.self, true)
        
        viewModel.datasource
            .asDriver()
            .drive(collectionView.rx.items(cellIdentifier: "SYLibraryCell", cellType: SYLibraryCell.self)) { (row, model, cell) in
                cell.model = model
            }
            .disposed(by: disposeBag)
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        let gesture = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressed))
        gesture.minimumPressDuration = 0.5
        collectionView.addGestureRecognizer(gesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicatorView.startAnimating()
        viewModel.reloadSubject.onNext(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func rxBind() {
//        self.perform(#selector(test), afterDelay: 5)
        isEdit.skip(1)
            .subscribe(onNext: { [unowned self] (bool) in
                self.headerBgView.snp.updateConstraints { (make) in
                    make.height.equalTo(bool ? 44 : 102)
                }
                self.normalHeaderView.isHidden = bool
                self.editHeaderView.isHidden = !bool
                self.setTabBarVisible(visible: bool, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.requestStatus
            .subscribe(onNext: { [unowned self] (bool, String) in
                if self.activityIndicatorView.isAnimating {
                    self.activityIndicatorView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                let model = self.viewModel.datasource.value[indexPath.row]
                let readModel = SYReadModel.model(bookID: model.bid)
                if model.bookcase != nil {
                    readModel.bookName = model.bookTitle
                } else {
                    readModel.bookName = model.readTxt
                }
                let vc  = SYReadController()
                vc.readModel = readModel
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        editHeaderView.cancelBtn.rx
            .tap
            .bind { [unowned self] in
                self.isEdit.accept(false)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func test() {
        setTabBarVisible(visible: true ,animated: true)
    }
    
    @objc func longPressed() {
        if !self.isEdit.value {
            self.isEdit.accept(true)
        }
    }
    
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        let frame = self.tabBarController?.tabBar.frame
        let offset = UIDevice().isX ? 49 + 34 : 49
        let offsetY = (visible ? CGFloat(offset) : CGFloat(-offset))
        if frame != nil {
            UIView.animate(withDuration: 0.3, animations: {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY)
            }) { (bool) in
                if visible {
                    UIApplication.shared.keyWindow?.addSubview(self.confirmBtn)
                } else {
                    self.confirmBtn.removeFromSuperview()
                }
            }
        }
    }
    
}

extension SYLibraryVC: UICollectionViewDelegateFlowLayout {

    // 设置UICollectionView边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 25, left: 20, bottom: 0, right: 20)
    }
    
    // 行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 22.5
    }
    
    // 列间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }

    // 设置cell大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (ScreenWidth - 90) / 3
        let height = width * (188 / 95)
        return .init(width: width, height: height)
    }

}
