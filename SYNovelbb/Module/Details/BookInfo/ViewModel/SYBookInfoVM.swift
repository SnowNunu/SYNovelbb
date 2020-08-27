
//
//  SYBookInfoVM.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/20.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxRelay
import HandyJSON
import MBProgressHUD
import RealmSwift

class SYBookInfoVM: RefreshVM<SYCommentModel> {
    
    private weak var owner: SYBookInfoVC!
    
    /// 是否在书架中
    var isOnShelf = BehaviorRelay<Bool>(value: false)
    
    init(_ owner: SYBookInfoVC) {
        super.init()
        self.owner = owner
        reloadSubject.subscribe(onNext: { [unowned self] (bool) in
                self.requestBookInfo()
            })
            .disposed(by: disposeBag)
    }
    
    /// 请求书籍评论数据
    override func requestData(_ refresh: Bool) {
        super.requestData(refresh)
        SYProvider.rx.request(.bookComments(bid: self.owner.bookId, pageIndex: pageModel.currentPage))
            .map(resultList: SYCommentModel.self)
            .subscribe(onSuccess: { (response) in
                if response.success {
                    if response.data != nil {
                        self.updateRefresh(refresh, response.data!, response.total)
                        self.requestStatus.accept((true, ""))
                    }
                }
            }) { (error) in
                if self.errorMessage(error) == "no find data" {
                    // 这里只是后台没有评论数据
                    self.updateRefresh(refresh, [], 0)
                    self.requestStatus.accept((true, ""))
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    func requestBookInfo() {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "com.novelbb.requestBookInfo", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
        
        // 请求书籍信息
        group.enter()
        queue.async(group: group, qos: .default, flags: []) { [unowned self] in
            SYProvider.rx.request(.bookInfo(bid: self.owner.bookId))
                .map(result: SYBookInfoModel.self)
                .subscribe(onSuccess: { [unowned self] (response) in
                    if response.success {
                        if response.data != nil {
                            let model = response.data!.book
                            self.recordBrowse(model!)
                            self.isOnShelf.accept(response.data!.isMark)
                            self.owner.bookName = model?.bookTitle
                            self.owner.headerView.bookTitle.text = model?.bookTitle
                            self.owner.headerView.bookClass.text = model?.tclass
                            self.owner.headerView.coverImage.kf.setImage(with: URL(string: model?.cover ?? ""))
                            var array = model?.Labels?.components(separatedBy: ",") ?? []
                            array.removeAll { (title) -> Bool in
                                title == ""
                            }
                            self.owner.headerView.datasource.acceptUpdate(byReplace: {_ in array})
                            
                            let size = model?.info?.introduction.size(.systemFont(ofSize: 12, weight: .regular), CGSize(width: ScreenWidth - 30, height: CGFloat.greatestFiniteMagnitude))
                            self.owner.tableView.tableHeaderView?.height = 635 + StatusBarHeight + ceil(size!.height)
                            self.owner.headerView.introduceLabel.snp.updateConstraints { (make) in
                                make.height.equalTo(ceil(size!.height))
                            }
                            self.owner.headerView.introduceLabel.text = model?.info?.introduction
                            group.leave()
                        }
                    }
                }) { (error) in
                    print(error.localizedDescription)
            }
            .disposed(by: self.disposeBag)
        }
        
        // 请求所有章节信息
        group.enter()
        queue.async(group: group, qos: .default, flags: []) { [unowned self] in
            SYProvider.rx.cacheRequest(.chapters(bid: self.owner.bookId), cacheType: .default)
                .map(resultList: SYCatalogModel.self)
                .subscribe(onSuccess: { [unowned self] (response) in
                    if response.success {
                        if response.data != nil {
                            let catalog = response.data!.first!
                            var catalogArray = [String]()
                            self.owner.chapterView.datasources.accept(catalog.chapters)
                            for chapter in catalog.chapters.prefix(4) {
                                catalogArray.append(chapter.title)
                            }
                            self.owner.headerView.chapters = catalogArray
                            group.leave()
                    }
                }
            }) { (error) in
                print(error)
            }
            .disposed(by: self.disposeBag)
        }
        
        group.notify(queue: queue) { [unowned self] in
            self.requestData(true)
        }
    }
    
    /// 加入书架
    func putOnShelf(bid: String) {
        SYProvider.rx.request(.addBookshelf(bid: bid, cid: ""))
            .map(result: SYEmptyModel.self)
            .subscribe(onSuccess: { (response) in
                if response.success {
                    self.isOnShelf.accept(true)
                    MBProgressHUD.show(message: "Has been added to the bookshelf", toView: nil)
                }
            }) { (error) in
                logError(self.errorMessage(error))
                MBProgressHUD.show(message: self.errorMessage(error), toView: nil)
            }
            .disposed(by: disposeBag)
    }

    /// 移出书架
    func removeFromeShelf(bid: String) {
        SYProvider.rx.request(.removeBookshelf(bid: bid))
            .map(result: SYEmptyModel.self)
            .subscribe(onSuccess: { (response) in
                if response.success {
                    self.isOnShelf.accept(false)
                    MBProgressHUD.show(message: "Has been removed from the bookshelf", toView: nil)
                }
            }) { (error) in
                logError(self.errorMessage(error))
            }
            .disposed(by: disposeBag)
    }
    
    /// 写入浏览记录数据
    func recordBrowse(_ model: SYBaseBookModel)  {
        let realm = try! Realm()
        try! realm.write() {
            let record = SYBrowseRecordModel()
            record.bookId = model.bid
            record.tClass = model.tclass
            record.bookTitle = model.bookTitle
            record.author = model.author
            record.bookLength = model.bookLength
            record.state = model.state ?? 0
            record.cover = model.cover
            record.isVip = model.isVip
            record.lastBrowse = NSDate()
            record.labels = model.Labels
            let user = realm.objects(SYUserModel.self).first!
            record.uid = user.uid
            realm.add(record, update: .modified)
        }
    }
    
}

class SYEmptyModel: HandyJSON {
    
    required init() {}
    
}

