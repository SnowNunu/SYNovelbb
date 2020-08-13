//
//  SYLibraryVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/27.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources

class SYLibraryVC: SYBaseVC {
    
    lazy var viewModel: SYLibraryVM = {
        let vm = SYLibraryVM()
        return vm
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func setupUI() {
        self.navigationController?.navigationBar.isHidden = true
        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYBaseBookModel>>.init(configureCell: { (_, collectionView, indexPath, model) -> UICollectionViewCell in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SYLibraryCell", for: indexPath) as! SYLibraryCell
            cell.model = model
            return cell
        }, configureSupplementaryView: { (_, collectionView, kind, indexPath) -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SYLibrayNormalHeader", for: indexPath) as! SYLibrayNormalHeader
            return header
        })
        
        viewModel.datasource.asDriver()
            .drive(collectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)
        
        collectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
//        self.perform(#selector(test), afterDelay: 5)
        collectionView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                let model = self.viewModel.datasource.value[indexPath.section].items[indexPath.row]
                let readModel = SYReadModel.model(bookID: model.bid)
                readModel.bookName = model.readTxt
                let vc  = SYReadController()
                vc.readModel = readModel
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.reloadSubject.onNext(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @objc func test() {
        setTabBarVisible(visible: true ,animated: true)
    }
    
    
    func setTabBarVisible(visible:Bool, animated:Bool) {
        let frame = self.tabBarController?.tabBar.frame
        let offset = UIDevice().isX ? 49 + 34 : 49
        let offsetY = (visible ? CGFloat(offset) : CGFloat(-offset))
        if frame != nil {
            UIView.animate(withDuration: 0.3) {
                self.tabBarController?.tabBar.frame = frame!.offsetBy(dx: 0, dy: offsetY)
                return
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

    // 设置header大小
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: ScreenWidth , height: 101.5)
    }

}
