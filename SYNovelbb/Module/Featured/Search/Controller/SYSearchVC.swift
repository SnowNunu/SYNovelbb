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
        
        activityIndicatorView.snp.makeConstraints { (make) in
            make.edges.equalTo(resultCollectionView)
        }
        
        viewModel.datasource.asDriver()
            .drive(resultCollectionView.rx.items(cellIdentifier: "SYSearchResultCell", cellType: SYSearchResultCell.self)) { (row, model, cell) in
                cell.model = model
            }
            .disposed(by: disposeBag)
    }
    
    override func rxBind() {
        backBtn.rx.tap
            .bind { [unowned self] in
                self.viewModel.reloadSubject.onNext(true)
//                self.navigationController?.popViewController(animated: true)
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
                    self.viewModel.reloadSubject.onNext(true)
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
