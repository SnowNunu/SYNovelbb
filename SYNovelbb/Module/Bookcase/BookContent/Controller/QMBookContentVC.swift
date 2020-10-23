//
//  QMBookContentVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import MBProgressHUD
import AdSupport

class QMBookContentVC: SYBaseVC {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lastBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var bookId: NSInteger!
    
    var pageNum: NSInteger!

    lazy var viewModel: QMBookContentVM = {
        let vm = QMBookContentVM()
        return vm
    }()
    
    override func setupUI() {
        let btnWidth = (ScreenWidth - 70) / 2
        view.bringSubviewToFront(lastBtn)
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
                var model: QMBookChapterModel!;
                if pageNum == nil {
                    model  = array.first
                    pageNum = model.bookPageNum
                }
                changePage()
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
                    self.scrollView.scrollToTop()
                }
            })
            .disposed(by: disposeBag)
        
        lastBtn.rx.tap
            .bind { [unowned self] in
                let model = viewModel.datasource.value.filter { (model) -> Bool in
                    model.bookPageNum == self.pageNum
                }.first!
                if model.bookPageNum == self.viewModel.datasource.value.first!.bookPageNum {
                    MBProgressHUD.show(message: "当前已是第一章", toView: nil)
                } else {
                    self.pageNum -= 1
                    self.changePage()
                }
            }
            .disposed(by: disposeBag)
        
        
        
        nextBtn.rx.tap
            .bind { [unowned self] in
                let model = viewModel.datasource.value.filter { (model) -> Bool in
                    model.bookPageNum == self.pageNum
                }.first!
                if model.redirect == nil {
                    self.pageNum += 1
                    self.changePage()
                } else {
                    var idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    if idfa == "00000000-0000-0000-0000-000000000000" {
                        idfa = String.uuid()
                    }
                    let launchMiniProgramReq = WXLaunchMiniProgramReq.object()
                    launchMiniProgramReq.userName = "gh_18147a2253d5"
                    launchMiniProgramReq.path = String.init(format: "pages/adPageContent/adPageContent?book_id=%d&book_page_num=%d&phone_code=%@", arguments: [self.bookId, model.redirect!.bookPageId, idfa])
                    launchMiniProgramReq.miniProgramType = .preview
                    WXApi.send(launchMiniProgramReq) { (bool) in
                        print(bool)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    // 翻页
    func changePage() {
        self.viewModel.getContent(bookId: bookId, bookPageNum: self.pageNum)
    }

}
