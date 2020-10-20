//
//  QMBookContentVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class QMBookContentVC: SYBaseVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var lastBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var bookId: NSInteger!

    lazy var viewModel: QMBookContentVM = {
        let vm = QMBookContentVM()
        return vm
    }()
    
    override func setupUI() {
        let btnWidth = (ScreenWidth - 70) / 2
        lastBtn.snp.makeConstraints { (make) in
            make.width.equalTo(btnWidth)
        }
        nextBtn.snp.makeConstraints { (make) in
            make.width.equalTo(btnWidth)
        }
    }
    
    override func rxBind() {
        viewModel.getChapter(bookId: bookId, page: 1, limit: 20)
        viewModel.datasource.skip(1)
            .subscribe(onNext: { [unowned self] array in
                let model  = array.first
                self.viewModel.getContent(bookId: bookId, bookPageNum: model?.bookPageNum ?? 0)
            })
            .disposed(by: disposeBag)
        
        viewModel.content.skip(1)
            .subscribe(onNext: { [unowned self] model in
                if model.bookPageContent != nil {
                    var string = model.bookPageContent!
                    string = string.replacingOccurrences(of: "<p>", with: "    ")
                    string = string.replacingOccurrences(of: "</p>", with: "\r\n\r\n")
                    self.titleLabel.text = model.bookPageName
                    self.contentLabel.text = string
                    
                    let titleHeight = model.bookPageName.getTextHeight(font: UIFont.systemFont(ofSize: 18, weight: .bold), width: ScreenWidth - 30);
                    let contentHeight = string.getTextHeight(font: UIFont.systemFont(ofSize: 17, weight: .regular), width: ScreenWidth - 30);
                    self.contentHeight.constant = titleHeight + contentHeight + 25 + 80
                }
            })
            .disposed(by: disposeBag)
    }

}
