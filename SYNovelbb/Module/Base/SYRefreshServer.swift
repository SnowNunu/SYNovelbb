//
//  SYRefreshServer.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Foundation
import MJRefresh
import RxRelay
import RxSwift

extension UIScrollView {

    final func prepare<T>(_ ower: RefreshVM<T>, _ type: T.Type, _ showFooter: Bool = false) {
        addFreshView(ower, showFooter)
        bind(ower, type, showFooter)
    }
    
    final func headerRefreshing() {
        if mj_footer != nil {
            mj_footer?.isHidden = true
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) { [weak self] in
            self?.mj_header?.beginRefreshing()
        }
    }
}

extension UIScrollView {

    fileprivate func addFreshView<T>(_ ower: RefreshVM<T>, _ showFooter: Bool) {
        mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            ower.requestData(true)
        })
        
        if showFooter == true {
            mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: {
                ower.requestData(false)
            })
            mj_footer?.isHidden = true
        }
    }
    
    fileprivate func bind<T>(_ ower: RefreshVM<T>, _ type: T.Type, _ hasFooter: Bool = true) {
        
        _ = ower.refreshStatus
            .asObservable()
            .bind(onNext: { [weak self] status in
                
                switch status {
                    case .DropDownSuccess:
                        self?.mj_header?.endRefreshing()
                        if hasFooter == true {
                            self?.mj_footer?.isHidden = false
                        }
                        break
                    case .DropDownSuccessAndNoMoreData:
                        self?.mj_header?.endRefreshing()
                        if hasFooter == true {
                            self?.mj_footer?.isHidden = true
                        }
                        break
                    case .PullSuccessHasMoreData:
                        if hasFooter == true { self?.mj_footer?.endRefreshing() }
                        break
                    case .PullSuccessNoMoreData:
                        if hasFooter == true {
                            self?.mj_footer?.isHidden = true
                        }
                        break
                    case .InvalidData:
                        self?.mj_header?.endRefreshing()
                        if hasFooter == true { self?.mj_footer?.endRefreshing() }
                        break
                    }
            })
        
    }

}

enum RefreshStatus: Int {
   
    case DropDownSuccess              // 下拉成功，有更多的数据
    case DropDownSuccessAndNoMoreData // 下拉成功，并且没有更多数据了
    case PullSuccessHasMoreData       // 上拉，还有更多数据
    case PullSuccessNoMoreData        // 上拉，没有更多数据
    case InvalidData                  // 无效的数据
}

class RefreshVM<T>: SYBaseVM {
    
    // 数据源
    public var datasource    = BehaviorRelay<[T]>(value: [T]())
    
    // 分页模型
    public var pageModel     = SYPageModel()
    
    // 刷新状态
    public var refreshStatus = BehaviorRelay<RefreshStatus>(value: RefreshStatus.InvalidData)
 
    public let itemSelected = PublishSubject<IndexPath>()
    
    public let modelSelected = PublishSubject<T>()

    /**
     子类重写，必须调用super
     */
    func requestData(_ refresh: Bool) {
        setupPage(refresh: refresh)
    }

}

extension RefreshVM {

    /**
     刷新方法，发射刷新信号
     */
    public final func updateRefresh(_ refresh: Bool, _ models: [T]?, _ total: Int?, pageSize psize: Int? = 10, _ addData: Bool = true) {
        pageModel.pageSize = psize!
        pageModel.total = total ?? 0
        if refresh {
            // 下拉刷新处理
            refreshStatus.acceptUpdate(byReplace: {_ in
                pageModel.hasNext == true ? .DropDownSuccess : .DropDownSuccessAndNoMoreData
            })
            if addData == true {
                datasource.acceptUpdate(byReplace: {_ in
                    models ?? [T]()
                })
            }
        } else {
            // 上拉刷新处理
            refreshStatus.acceptUpdate(byReplace: {_ in
                pageModel.hasNext == true ? .PullSuccessHasMoreData : .PullSuccessNoMoreData
            })
            if addData == true {
                datasource.acceptUpdate(byMutating: { $0.append(contentsOf: models ?? [T]())})
            }
        }
    }
    
    /**
     网络请求失败和出错都会统一调用这个方法
     */
    public final func revertCurrentPageAndRefreshStatus() {
        // 修改刷新view的状态
        refreshStatus.acceptUpdate(byReplace: {_ in .InvalidData})
        // 还原请求页
        pageModel.currentPage = pageModel.currentPage > 1 ? pageModel.currentPage - 1 : 1
    }
    
    fileprivate func setupPage(refresh: Bool) {
        pageModel.setupCurrentPage(refresh: refresh)
    }

}
