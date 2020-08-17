//
//  SYReadController+Operation.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit
import MBProgressHUD

extension SYReadController {
    
    /// 获取指定阅读记录阅读页
    func GetReadViewController(recordModel:SYReadRecordModel!) -> SYReadViewController? {
        
        if recordModel != nil {
            
            let controller = SYReadViewController()
            
            controller.recordModel = recordModel
            
            controller.readModel = readModel
            
            return controller
        }
        
        return nil
    }
    
    /// 获取当前阅读记录阅读页
    func GetCurrentReadViewController(isUpdateFont:Bool = false) -> SYReadViewController? {
        
        if SYReadConfigure.shared().effectType != .scroll { // 滚动模式不需要创建
            
            if isUpdateFont { readModel.recordModel.updateFont() }
            
            return GetReadViewController(recordModel: readModel.recordModel.copyModel())
        }
        
        return nil
    }
    
    /// 获取上一页控制器
    func GetAboveReadViewController() ->UIViewController? {
        
        let recordModel = GetAboveReadRecordModel(recordModel: readModel.recordModel)
        
        if recordModel == nil { return nil }
        
        return GetReadViewController(recordModel: recordModel)
    }
    
    /// 获取仿真模式背面(只用于仿真模式背面显示)
    func GetReadViewBGController(recordModel: SYReadRecordModel!, targetView:UIView? = nil) -> SYReadViewBGController {
        
        let vc = SYReadViewBGController()
        
        vc.recordModel = recordModel
        
        let targetView = targetView ?? GetReadViewController(recordModel: recordModel)?.view
        
        vc.targetView = targetView
        
        return vc
    }
    
    
    /// 获取下一页控制器
    func GetBelowReadViewController() ->UIViewController? {
        
        let recordModel = GetBelowReadRecordModel(recordModel: readModel.recordModel)
        
        if recordModel == nil { return nil }
        
        return GetReadViewController(recordModel: recordModel)
    }
    
    /// 跳转指定章节(指定页面)
    func GoToChapter(chapterID: NSNumber!, toPage: NSInteger = 0) {
        GoToChapter(chapterID: chapterID, number: toPage, isLocation: false)
    }
    
    /// 跳转指定章节(指定坐标)
    func GoToChapter(chapterID: NSNumber!, location: NSInteger) {
        GoToChapter(chapterID: chapterID, number: location, isLocation: true)
    }
    
    /// 跳转指定章节 number:页码或者坐标 isLocation:是页码(false)还是坐标(true)
    private func GoToChapter(chapterID: NSNumber!, number: NSInteger, isLocation: Bool) {
        // 复制阅读记录
        let recordModel = readModel.recordModel.copyModel()
        // 书籍ID
        let bookID = recordModel.bookID
        // 检查是否存在章节内容
        let isExist = SYReadChapterModel.isExist(bookID: bookID, chapterID: chapterID)
        
        // 存在
        if isExist {
            // 获取章节数据
            recordModel.chapterModel = SYReadChapterModel.model(bookID: bookID, chapterID: chapterID)
            if isLocation {
                // 坐标定位
                recordModel.modify(chapterID: chapterID, location: number, isSave: false)
            } else {
                // 分页定位
                recordModel.modify(chapterID: chapterID, toPage: number, isSave: false)
            }
            // 阅读阅读记录
            updateReadRecord(recordModel: recordModel)
            // 展示阅读
            creatPageController(displayController: GetReadViewController(recordModel: recordModel))
        } else {
            // 加载章节数据
            let result = chapterID.compare(recordModel.chapterModel.chapterId)
            _ = self.loadingNewReadRecord(isNext: true, isAbove: result == .orderedAscending, bid: bookID!, cid: chapterID.stringValue, recordModel: recordModel)
            
//            NJHTTPTool.request_novel_read(bookID, chapterID) { [weak self] (type, response, error) in
//
//                MBProgressHUD.hide(self?.view)
//
//                if type == .success {
//
//                    // 获取章节数据
//                    let data = HTTP_RESPONSE_DATA_DICT(response)
//
//                    // 解析章节数据
//                    let chapterModel = SYReadChapterModel(data)
//
//                    // 章节类容需要进行排版一篇
//                    chapterModel.content = SYReadParser.contentTypesetting(content: chapterModel.content)
//
//                    // 保存
//                    chapterModel.save()
//
//                    // 修改阅读记录
//                    recordModel.modify(chapterID: chapterModel.chapterID, toPage: toPage, isSave: false)
//
//                    // 更新阅读记录
//                    self?.updateReadRecord(recordModel: recordModel)
//
//                    // 展示阅读记录
//                    self?.creatPageController(displayController: GetReadViewController(recordModel: recordModel))
//                }
//            }
        }
        
        // ----- 搜索网络小说 -----
        
//        // 预加载下一章(可选)
//        if readModel.bookSourceType == .network { // 网络小说
//
//            if !recordModel.isLastChapter && !SYReadChapterModel.isExist(bookID: bookID, chapterID: chapterID) {
//
//                // 加载章节数据
//                NJHTTPTool.request_novel_read(bookID, chapterID) { [weak self] (type, response, error) in
//
//                    if type == .success {
//
//                        // 获取章节数据
//                        let data = HTTP_RESPONSE_DATA_DICT(response)
//
//                        // 解析章节数据
//                        let chapterModel = SYReadChapterModel(data)
//
//                        // 章节类容需要进行排版一篇
//                        chapterModel.content = SYReadParser.contentTypesetting(content: chapterModel.content)
//
//                        // 保存
//                        chapterModel.save()
//                    }
//                }
//            }
//        }
    }
    
    /// 获取当前记录上一页阅读记录
    func GetAboveReadRecordModel(recordModel: SYReadRecordModel!) -> SYReadRecordModel? {
        // 阅读记录为空
        if recordModel.chapterModel == nil { return nil }
        // 复制
        let recordModel = recordModel.copyModel()
        // 书籍ID
        let bookID = recordModel.bookID
        // 章节ID
        let chapterID = recordModel.chapterModel.previousChapterID
        // 第一章 第一页
        if recordModel.isFirstChapter && recordModel.isFirstPage {
            MBProgressHUD.show(message: "It's already the first chapter!", toView: self.view)
            return nil
        }
        // 第一页
        if recordModel.isFirstPage {
            // 检查是否存在章节内容
            let isExist = SYReadChapterModel.isExist(bookID: bookID, chapterID: chapterID)
            // 存在
            if isExist {
                // 获取章节数据
                recordModel.chapterModel = SYReadChapterModel.model(bookID: bookID, chapterID: chapterID)
                // 修改阅读记录
                recordModel.modify(chapterID: chapterID, toPage: SY_READ_LAST_PAGE, isSave: false)
            } else {
                // 加载网络章节数据
                return self.loadingNewReadRecord(isNext: false, isAbove: true, bid: bookID!, cid: chapterID!.stringValue, recordModel: recordModel)
            }
        } else { recordModel.previousPage() }
        
        // ----- 搜索网络小说 -----
        
        // 预加载上一章(可选)(一般上一章就要他自己拉一下加载吧,看需求而定,上下滚动模式的就会提前加载好上下章节)
        
        return recordModel
    }
    
    /// 获取当前记录下一页阅读记录
    func GetBelowReadRecordModel(recordModel: SYReadRecordModel!) -> SYReadRecordModel?  {
        // 阅读记录为空
        if recordModel.chapterModel == nil { return nil }
        // 复制
        let recordModel = recordModel.copyModel()
        // 书籍ID
        let bookID = recordModel.bookID
        // 章节ID
        let chapterID = recordModel.chapterModel.nextChapterID
        // 最后一章 最后一页
        if recordModel.isLastChapter && recordModel.isLastPage {
            logDebug("已经是最后一页了")
            return nil
        }
        // 最后一页
        if recordModel.isLastPage {
            // 检查是否存在章节内容
            let isExist = SYReadChapterModel.isExist(bookID: bookID, chapterID: chapterID)
            if isExist {
                // 获取章节数据
                recordModel.chapterModel = SYReadChapterModel.model(bookID: bookID, chapterID: chapterID)
                // 修改阅读记录
                recordModel.modify(chapterID: chapterID, toPage: 0, isSave: false)
            } else {
                return self.loadingNewReadRecord(isNext: true, isAbove: false, bid: bookID!, cid: chapterID!.stringValue, recordModel: recordModel)
            }
        } else { recordModel.nextPage() }
        
        // ----- 搜索网络小说 -----
        
//        // 预加载下一章(可选)
//        if readModel.bookSourceType == .network { // 网络小说
//
//            if !recordModel.isLastChapter && !SYReadChapterModel.isExist(bookID: bookID, chapterID: chapterID) {
//
//                // 加载章节数据
//                NJHTTPTool.request_novel_read(bookID, chapterID) { [weak self] (type, response, error) in
//
//                    if type == .success {
//
//                        // 获取章节数据
//                        let data = HTTP_RESPONSE_DATA_DICT(response)
//
//                        // 解析章节数据
//                        let chapterModel = SYReadChapterModel(data)
//
//                        // 章节类容需要进行排版一篇
//                        chapterModel.content = SYReadParser.contentTypesetting(content: chapterModel.content)
//
//                        // 保存
//                        chapterModel.save()
//                    }
//                }
//            }
//        }
        
        return recordModel
    }
    
    /// 加载上一章或下一章的章节内容数据
    /// - Parameters:
    ///   - isNext: true/false  ---> 加载下一章/上一章
    ///   - isAbove: 设置翻页动画效果(向前或向后)
    ///   - bid: 书籍id
    ///   - cid: 章节id
    ///   - recordModel: 阅读记录
    /// - Returns: 阅读记录model
    func loadingNewReadRecord(isNext: Bool!,isAbove: Bool!, bid: String!, cid: String!, recordModel: SYReadRecordModel!) -> SYReadRecordModel? {
        activityIndicatorView.startAnimating()
        // 加载章节数据
        SYProvider.rx.request(.chapterContent(bid: bid, cid: cid, next: 0))
            .map(result: SYChapterContentModel.self).subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let model = response.data!.chapter.first!   // 最终的章节内容
                        let chapterModel = SYReadChapterModel()
                        chapterModel.bookID = self.readModel.bookID
                        chapterModel.chapterId = NSNumber(value: Int(model.cid)!)
                        chapterModel.name = model.title
                        chapterModel.content = model.contents
                        // 获取章节内容的接口中不存在上下章节的章节id，得从目录接口中获取
                        if self.readModel.chapterListModels.count > 0 {
                            // 目录数据已获取到
                            let array = self.readModel.chapterListModels.filter { (model) -> Bool in
                                return model.id.stringValue == cid
                            }
                            if array.count == 1 {
                                let chapter = array.first!
                                chapterModel.previousChapterID = NSNumber(value: Int(chapter.prevID)!)
                                chapterModel.nextChapterID = NSNumber(value: Int(chapter.nextID)!)
                            }
                        }
                        chapterModel.save()
                        
                        // 修改阅读记录
                        if isNext {
                            recordModel.modify(chapterID: chapterModel.chapterId, toPage: 0, isSave: false)
                        } else {
                            recordModel.modify(chapterID: chapterModel.chapterId, toPage: SY_READ_LAST_PAGE, isSave: false)
                        }
                        // 更新阅读记录
                        self.updateReadRecord(recordModel: recordModel)
                        // 展示阅读记录
                        self.setViewController(displayController: self.GetReadViewController(recordModel: recordModel), isAbove: isAbove, animated: true)
                        
                        // 更新UI
                        if self.activityIndicatorView.isAnimating {
                            self.activityIndicatorView.stopAnimating()
                        }
                        self.leftView.updateUI()
                    }
                }
            }) { (error) in
                logError(error.localizedDescription)
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        return nil
    }
    
    /// 更新阅读记录(左右翻页模式)
    func updateReadRecord(controller:SYReadViewController!) {
        
        updateReadRecord(recordModel: controller?.recordModel)
    }
    
    /// 更新阅读记录(左右翻页模式)
    func updateReadRecord(recordModel:SYReadRecordModel!) {
        if recordModel != nil {
            if recordModel.chapterModel == nil {
                activityIndicatorView.startAnimating()
                // 首次阅读
                SYProvider.rx.request(.firstChapter(bid: readModel.bookID))
                    .map(resultList: SYChapterModel.self)
                    .subscribe(onSuccess: { [unowned self] (response) in
                        if response.success {
                            if response.data != nil {
                                let chapter = response.data!.first!
                                // 请求到第一章章节信息时需要接着去请求章节内容
                                SYProvider.rx.request(.chapterContent(bid: self.readModel.bookID, cid: chapter.cid, next: 0))
                                    .map(result: SYChapterContentModel.self).subscribe(onSuccess: { (response) in
                                        if response.success {
                                            if response.data != nil {
                                                let model = response.data!.chapter.first!   // 最终的章节内容
                                                let chapterModel = SYReadChapterModel()
                                                chapterModel.bookID = self.readModel.bookID
                                                chapterModel.chapterId = NSNumber(value: Int(model.cid)!)
                                                chapterModel.name = model.title
                                                chapterModel.content = model.contents
                                                chapterModel.nextChapterID = NSNumber(value: Int(chapter.nextID)!)
                                                chapterModel.previousChapterID = NSNumber(value: Int(chapter.prevID)!)
                                                chapterModel.save()

                                                self.readModel.recordModel.modify(chapterID: chapterModel.chapterId, location: 0)
                                                SY_READ_RECORD_CURRENT_CHAPTER_LOCATION = recordModel.locationFirst
                                                self.showReadingView()
                                                if self.activityIndicatorView.isAnimating {
                                                    self.activityIndicatorView.stopAnimating()
                                                }
                                                self.leftView.updateUI()
                                            }
                                        }
                                    }) { (error) in
                                        logError(error.localizedDescription)
                                    }
                                    .disposed(by: self.disposeBag)
                            }
                        }
                    }) { [unowned self] (error) in
                        logError(error.localizedDescription)
                        self.navigationController?.popViewController(animated: true)
                    }
                    .disposed(by: disposeBag)
            } else {
                readModel.recordModel = recordModel
                readModel.recordModel.save()
                SY_READ_RECORD_CURRENT_CHAPTER_LOCATION = recordModel.locationFirst
                self.showReadingView()
                self.leftView.updateUI()
            }
        }
    }
    
    // 加载目录数据
    func loadingCatalogData() {
        SYProvider.rx.cacheRequest(.chapters(bid: readModel.bookID), cacheType: .default)
            .map(resultList: SYCatalogModel.self)
            .subscribe(onSuccess: { [unowned self] (response) in
                if response.success {
                    if response.data != nil {
                        let catalog = response.data!.first!
                        var catalogArray = [SYReadChapterListModel]()
                        for chapter in catalog.chapters {
                            let model = SYReadChapterListModel()
                            model.bookID = self.readModel.bookID
                            model.id = NSNumber(value: Int(chapter.cid)!)
                            model.name = chapter.title
                            model.isVip = chapter.isVip
                            model.chapterMoney = chapter.chapterMoney
                            model.nextID = chapter.nextID
                            model.prevID = chapter.prevID
                            catalogArray.append(model)
                        }
                        self.readModel.chapterListModels = catalogArray
                        self.leftView.volumeTitle.text = catalog.volumeTitle
                    }
                }
            }) { (error) in
                print(error)
            }
            .disposed(by: self.disposeBag)
    }
    
}
