//
//  QMBookcaseListVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/10/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxDataSources
import WebKit
import AdSupport

class QMBookcaseListVC: SYBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: QMBookcaseListVM = {
        let vm = QMBookcaseListVM()
        return vm;
    }()
    
    lazy var webView: WKWebView = {
        let configure = WKWebViewConfiguration()
        configure.preferences = WKPreferences()
        configure.preferences.javaScriptEnabled = true
        let view = WKWebView.init(frame: .zero, configuration: configure)
        return view
    }()
    
    override func setupUI() {
        tableView.prepare(viewModel, QMBookcaseListModel.self, true)
        tableView.headerRefreshing()
        
        viewModel.datasource.asDriver()
            .drive(tableView.rx.items(cellIdentifier: "QMBookcaseListCell", cellType: QMBookcaseListCell.self)) { (row, model, cell) in
                cell.model = model
            }
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        webView.evaluateJavaScript("navigator.userAgent") { [unowned self] (result, error) in
            if error == nil {
                var idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                if idfa == "00000000-0000-0000-0000-000000000000" {
                    idfa = String.uuid()
                }
                SYProvider.rx.request(.reportLoginInfo(phoneCode: idfa, userAgent: result as! String))
                    .qm_map(result: QMUserLoginModel.self).subscribe { (response) in
                        if response.data != nil {
                            print("上报成功")
                        }
                    } onError: { (error) in
                        print(error)
                    }
                    .disposed(by: self.disposeBag)

            }
        }
    }
    
    override func rxBind() {
        tableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] (indexPath) in
                let model = self.viewModel.datasource.value[indexPath.row]
                let vc = R.storyboard.bookcase.qmBookContentVC()!;
                vc.title = model.bookName
                vc.bookId = model.bookId
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
        
        /// 监听推送内容
        NotificationCenter.default.rx
            .notification(Notification.Name(rawValue: "enterBookContentView"))
            .subscribe(onNext: { notification in
                let userInfo = notification.userInfo as! [String: AnyObject]
                let bid = userInfo["bid"] as! NSNumber
                let cid = userInfo["cid"] as! NSNumber
                let bookName = userInfo["bookname"] as! String
                let forward = userInfo["forwardToMiniprogram"] as! Bool
                if forward {
                    var idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    if idfa == "00000000-0000-0000-0000-000000000000" {
                        idfa = String.uuid()
                    }
                    let launchMiniProgramReq = WXLaunchMiniProgramReq.object()
                    launchMiniProgramReq.userName = "gh_18147a2253d5"
                    launchMiniProgramReq.path = String.init(format: "pages/adPageContent/adPageContent?book_id=%d&book_page_num=%d&phone_code=%@", arguments: [bid.intValue, cid.intValue, idfa])
                    launchMiniProgramReq.miniProgramType = .preview
                    WXApi.send(launchMiniProgramReq) { (bool) in
                        print(bool)
                    }
                } else {
                    let vc = R.storyboard.bookcase.qmBookContentVC()!;
                    vc.title = bookName
                    vc.bookId = bid.intValue
                    vc.pageNum = cid.intValue
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    /// 进入书籍阅读页面
    func enterBookContentView() {
        let vc = R.storyboard.bookcase.qmBookContentVC()!;
        vc.title = "剑临诸天"
        vc.bookId = 29
        vc.pageNum = 3
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension QMBookcaseListVC: UITableViewDelegate {
    
    // 设置cell行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
