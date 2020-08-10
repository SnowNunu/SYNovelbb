//
//  SYSearchVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/6.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import RxRelay
import MBProgressHUD
import DZNEmptyDataSet
import RealmSwift

class SYSearchVC: SYBaseVC {
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    
    lazy var viewModel: SYSearchVM = {
        let vm = SYSearchVM()
        return vm
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func setupUI() {
        resultCollectionView.prepare(viewModel, SYBaseBookModel.self, true)
        resultCollectionView.emptyDataSetSource = self
        resultCollectionView.emptyDataSetDelegate = self
        recommendCollectionView.register(SYSearchHistoryCell.self, forCellWithReuseIdentifier: SYSearchHistoryCell.className())
        recommendCollectionView.register(SYHotSearchCell.self, forCellWithReuseIdentifier: SYHotSearchCell.className())
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalTo(resultCollectionView)
        }
        
        viewModel.datasource.asDriver()
            .drive(resultCollectionView.rx.items(cellIdentifier: "SYSearchResultCell", cellType: SYSearchResultCell.self)) { [unowned self] (row, model, cell) in
                cell.keywords = self.viewModel.keyword.value
                cell.model = model
            }
            .disposed(by: disposeBag)

        let datasource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, SYSearchModel>>.init(configureCell: { (_, collectionView, indexPath, model) -> UICollectionViewCell in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYSearchHistoryCell.className(), for: indexPath) as! SYSearchHistoryCell
                cell.contentLabel.text = model.keyword
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SYHotSearchCell.className(), for: indexPath) as! SYHotSearchCell
                cell.titleLabel.text = "\(indexPath.row + 1). \(model.booktitle!)"
                return cell
            }
        }, configureSupplementaryView: { (datasource, collectionView, kind, indexPath) -> UICollectionReusableView in
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SYSearchHeader", for: indexPath) as! SYSearchHeader
                header.isChange = indexPath.section == 1
                header.titleLabel.text = datasource.sectionModels[indexPath.section].model
                header.actionBtn.rx.tap
                    .bind { [unowned self] in
                        if indexPath.section == 0 {
                            let realm = try! Realm()
                            try! realm.write {
                                realm.delete(realm.objects(SYSearchModel.self))
                            }
                            self.viewModel.reloadSubject.onNext(true)
                        }
                    }
                    .disposed(by: header.disposeBag)
                return header
            } else {
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SYSearchFooter", for: indexPath) as! SYSearchFooter
                return footer
            }
        })

        viewModel.recommendDatasource
            .asDriver()
            .drive(recommendCollectionView.rx.items(dataSource: datasource))
            .disposed(by: disposeBag)

        recommendCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        backBtn.rx.tap
            .bind { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        searchTextField.rx.text
            .orEmpty
            .asDriver()
            .drive(viewModel.keyword)
            .disposed(by: disposeBag)
        
        searchBtn.rx.tap
            .bind { [unowned self] in
                if self.searchTextField.text?.count == 0 {
                    MBProgressHUD.show(message: "Please enter keyword first!", toView: self.view)
                } else {
                    self.activityIndicatorView.startAnimating()
                    self.viewModel.requestData(true)
                    self.recommendCollectionView.isHidden = true
                    self.resultCollectionView.isHidden = false
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.requestStatus
            .subscribe(onNext: { [unowned self] (_, _) in
                if self.activityIndicatorView.isAnimating {
                    self.activityIndicatorView.stopAnimating()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.reloadSubject.onNext(true)
        activityIndicatorView.startAnimating()
    }

}

// MARK: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate
extension SYSearchVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    // 设置占位图显示图片内容
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return R.image.search_no_books()!
    }

    // 设置占位图图片下文字显示内容
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString.init(string: "There is no content you are searching for")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(51, 51, 51), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString.init(string: "Try choosing other books you like")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(198, 189, 172), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }

}

extension SYSearchVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: ScreenWidth, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .init(width: ScreenWidth, height: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            if (viewModel.recommendDatasource.value.first?.items.count)! > 0 {
                let model = viewModel.recommendDatasource.value.first?.items[indexPath.row]
                let width = (model?.keyword?.getTexWidth(font: .systemFont(ofSize: 12, weight: .regular), height: 12))! + 20
                return .init(width: width, height: 23)
            } else {
                return .init(width: 0.01, height: 0.01)
            }
        default:
            return .init(width: ScreenWidth - 30, height: 30)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return .init(top: 15, left: 15, bottom: 15, right: 15)
        } else {
            return .init(top: 0, left: 15, bottom: 15, right: 15)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
}
