//
//  SYReadController.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit
import RxSwift

class SYReadController: SYViewController, SYReadMenuDelegate, UIPageViewControllerDelegate , UIPageViewControllerDataSource, SYPageViewControllerDelegate, DZMCoverControllerDelegate, SYReadContentViewDelegate, SYReadCatalogViewDelegate {

    // MARK: 数据相关
    
    /// 阅读对象
    var readModel: SYReadModel!
    
    
    // MARK: UI相关
    
    /// 阅读主视图
    var contentView: SYReadContentView!
    
    /// 章节列表
    var leftView: SYReadLeftView!
    
    /// 阅读菜单
    var readMenu: SYReadMenu!
    
    /// 翻页控制器 (仿真)
    var pageViewController: SYPageViewController!
    
    /// 翻页控制器 (滚动)
    var scrollController: SYReadViewScrollController!
    
    /// 翻页控制器 (无效果,覆盖)
    var coverController: DZMCoverController!
    
    /// 非滚动模式时,当前显示 SYReadViewController
    var currentDisplayController: SYReadViewController?
    
    /// 用于区分正反面的值(勿动)
    var tempNumber: NSInteger = 1
    
    lazy var disposeBag: DisposeBag = {
        return DisposeBag()
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // 背景颜色
        view.backgroundColor = SYReadConfigure.shared().bgColor
        
        // 初始化书籍阅读记录
        updateReadRecord(recordModel: readModel.recordModel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }

    override func addSubviews() {
        
        super.addSubviews()
        
        // 目录侧滑栏
        leftView = SYReadLeftView()
        leftView.catalogView.readModel = readModel
        leftView.catalogView.delegate = self

        leftView.isHidden = true
        view.addSubview(leftView)
        leftView.frame = CGRect(x: -SY_READ_LEFT_VIEW_WIDTH, y: 0, width: SY_READ_LEFT_VIEW_WIDTH, height: SY_READ_LEFT_VIEW_HEIGHT)
        
        // 阅读视图
        contentView = SYReadContentView()
        contentView.delegate = self
        view.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: SY_READ_CONTENT_VIEW_WIDTH, height: SY_READ_CONTENT_VIEW_HEIGHT)
    }
    
    
    func showReadingView() {
        // 这里需要避免重复创建，之前没注意到是这里的问题导致内存一直暴增
        if currentDisplayController == nil {
            // 初始化菜单
            readMenu = SYReadMenu(vc: self, delegate: self)
            
            // 初始化控制器
            creatPageController(displayController: GetCurrentReadViewController(isUpdateFont: true))
        }
    }
    
    // MARK: SYReadCatalogViewDelegate
    
    /// 章节目录选中章节
    func catalogViewClickChapter(catalogView: SYReadCatalogView, chapterListModel: SYReadChapterListModel) {
        
        showLeftView(isShow: false)
        
        contentView.showCover(isShow: false)
        
        if readModel.recordModel.chapterModel.chapterId == chapterListModel.id { return }
        
        GoToChapter(chapterID: chapterListModel.id)
    }
    
    // MARK: SYReadContentViewDelegate
    
    /// 点击遮罩
    func contentViewClickCover(contentView: SYReadContentView) {
        
        showLeftView(isShow: false)
    }
    
    
    // MARK: SYReadMenuDelegate
    
    /// 菜单将要显示
    func readMenuWillDisplay(readMenu: SYReadMenu!) {
        
        // 刷新阅读进度
        readMenu.bottomView.progressView.reloadProgress()
    }
    
    /// 点击返回
    func readMenuClickBack(readMenu: SYReadMenu!) {
        
        // 清空所有阅读缓存
        // DZMKeyedArchiver.clear()
        
        // 清空指定书籍缓存
        // DZMKeyedArchiver.remove(folderName: bookID)
        
        // 移除 SYPageViewController，因为这个仿真模式的 UIPageViewController 不手动移除会照成内存泄漏，对象不释放
        // 它需要提前手动移除，要不然会导致释放不了走不了 deinit() 函数
        if (SYReadConfigure.shared().effectType == .simulation) {
            
            clearPageController()
        }
        
        // 清空坐标
        SY_READ_RECORD_CURRENT_CHAPTER_LOCATION = nil
        
        // 返回
        navigationController?.popViewController(animated: true)
    }
    
    /// 点击书架(将当前书籍加入或移出书架)
    func readMenuClickBookcase(readMenu:SYReadMenu!) {
        // TODO: 欠缺移出加入书架逻辑
        print("点击了书架按钮")
    }
    
    /// 点击目录
    func readMenuClickCatalogue(readMenu:SYReadMenu!) {
        
        showLeftView(isShow: true)
        
        contentView.showCover(isShow: true)
        
        readMenu.showMenu(isShow: false)
    }
    
    /// 点击上一章
    func readMenuClickPreviousChapter(readMenu: SYReadMenu!) {
        
        if readModel.recordModel.isFirstChapter {
            
            logDebug("已经是第一章了")
            
        }else{
            
            GoToChapter(chapterID: readModel.recordModel.chapterModel.previousChapterID)
            
            // 刷新阅读进度
            readMenu.bottomView.progressView.reloadProgress()
        }
    }
    
    /// 点击下一章
    func readMenuClickNextChapter(readMenu: SYReadMenu!) {
        
        if readModel.recordModel.isLastChapter {
            
            logDebug("已经是最后一章了")
            
        }else{
            
            GoToChapter(chapterID: readModel.recordModel.chapterModel.nextChapterID)
            
            // 刷新阅读进度
            readMenu.bottomView.progressView.reloadProgress()
        }
    }
    
    /// 拖拽阅读记录
    func readMenuDraggingProgress(readMenu: SYReadMenu!, toPage: NSInteger) {
        
        if readModel.recordModel.page.intValue != toPage{
            
            readModel.recordModel.page = NSNumber(value: toPage)
            
            creatPageController(displayController: GetCurrentReadViewController())
        }
    }
    
    /// 拖拽章节进度(总文章进度,网络文章也可以使用)
    func readMenuDraggingProgress(readMenu: SYReadMenu!, toChapterID: NSNumber, toPage: NSInteger) {
        
        // 不是当前阅读记录章节
        if toChapterID != readModel!.recordModel.chapterModel.chapterId {
            
            GoToChapter(chapterID: toChapterID, toPage: toPage)
        }
    }
    
    /// 切换进度显示(分页 || 总进度)
    func readMenuClickDisplayProgress(readMenu: SYReadMenu) {
        
        creatPageController(displayController: GetCurrentReadViewController())
    }
    
    /// 点击切换背景颜色
    func readMenuClickBGColor(readMenu: SYReadMenu) {
        
        // 切换背景颜色可以根据需求判断修改目录背景颜色,文字颜色等等(目前放在showLeftView方法中,leftView将要出现的时候处理)
        // leftView.updateUI()
        
        view.backgroundColor = SYReadConfigure.shared().bgColor
        
        creatPageController(displayController: GetCurrentReadViewController())
    }
    
    /// 点击切换字体
    func readMenuClickFont(readMenu: SYReadMenu) {
        
        creatPageController(displayController: GetCurrentReadViewController(isUpdateFont: true))
    }
    
    /// 点击切换字体大小
    func readMenuClickFontSize(readMenu: SYReadMenu) {
        
        creatPageController(displayController: GetCurrentReadViewController(isUpdateFont: true))
    }
    
    /// 点击切换间距
    func readMenuClickSpacing(readMenu: SYReadMenu) {
        
        creatPageController(displayController: GetCurrentReadViewController(isUpdateFont: true))
    }
    
    /// 点击切换翻页效果
    func readMenuClickEffect(readMenu: SYReadMenu) {
        
        creatPageController(displayController: GetCurrentReadViewController())
    }
    
    
    // MARK: 展示动画
    
    /// 辅视图展示
    func showLeftView(isShow: Bool, completion: SYAnimationCompletion? = nil) {
     
        if isShow { // leftView 将要显示
            
            // 刷新UI 
            leftView.updateUI()
            
            // 滚动到阅读记录
            leftView.catalogView.scrollRecord()
            
            // 允许显示
            leftView.isHidden = false
        }
        
        UIView.animate(withDuration: SY_READ_ANIMATION_TIME, delay: 0, options: .curveEaseOut, animations: { [weak self] () in
            
            if isShow {

                self?.leftView.frame.origin = CGPoint.zero
                
                self?.contentView.frame.origin = CGPoint(x: SY_READ_LEFT_VIEW_WIDTH, y: 0)
                
            }else{
                
                self?.leftView.frame.origin = CGPoint(x: -SY_READ_LEFT_VIEW_WIDTH, y: 0)
                
                self?.contentView.frame.origin = CGPoint.zero
            }
            
        }) { [weak self] (isOK) in
            
            if !isShow { self?.leftView.isHidden = true }
            
            completion?()
        }
    }
    
    deinit {
        logInfo("\(self)释放了")
        // 清理阅读控制器
        clearPageController()
    }
}
