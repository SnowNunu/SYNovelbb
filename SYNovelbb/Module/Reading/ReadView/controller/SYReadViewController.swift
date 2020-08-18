//
//  SYReadViewController.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadViewController: SYViewController {
    
    /// 当前页阅读记录对象
    var recordModel: SYReadRecordModel!

    /// 阅读对象(用于显示书名以及书籍首页显示书籍信息)
    weak var readModel: SYReadModel!
    
    /// 顶部状态栏
    var topView: SYReadViewStatusTopView!
    
    /// 底部状态栏
    var bottomView:SYReadViewStatusBottomView!
    
    /// 阅读视图
    private var readView:SYReadView!
    
    /// 书籍首页视图
    private var subscribeView: SYReadSubscribeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置阅读背景
        view.backgroundColor = SYReadConfigure.shared().bgColor
        // 刷新阅读进度
        reloadProgress()
    }
    
    override func addSubviews() {
        
        super.addSubviews()
        
        // 阅读使用范围
        let readRect = SY_READ_RECT!
        
        // 顶部状态栏
        topView = SYReadViewStatusTopView()
        topView.chapterName.text = recordModel.chapterModel.name
        view.addSubview(topView)
        topView.frame = CGRect(x: readRect.minX, y: readRect.minY, width: readRect.width, height: 30)
        
        // 底部状态栏
        bottomView = SYReadViewStatusBottomView()
        view.addSubview(bottomView)
        bottomView.frame = CGRect(x: readRect.minX, y: readRect.maxY - 30, width: readRect.width, height: 30)
        
        // 阅读视图
        initReadView()
    }
    
    /// 初始化阅读视图
    func initReadView() {
        // 是否为免费章节
        if recordModel.chapterModel.chapterMoney == 0 {
            readView = SYReadView()
            readView.content = recordModel.contentAttributedString
            view.addSubview(readView)
            readView.frame = SY_READ_VIEW_RECT
        } else {
            subscribeView = SYReadSubscribeView()
            subscribeView.readModel = readModel
            view.addSubview(subscribeView)
            subscribeView.frame = self.view.frame
            topView.isHidden = true
            bottomView.isHidden = true
        }
    }
    
    /// 刷新阅读进度显示
    private func reloadProgress() {
        
        if SYReadConfigure.shared().progressType == .total { // 总进度
            
            // 当前阅读进度
            let progress:Float = DZM_READ_TOTAL_PROGRESS(readModel: readModel, recordModel: recordModel)
           
            // 显示进度
            bottomView.progress.text = SY_READ_TOTAL_PROGRESS_STRING(progress: progress)
            
            
        }else{ // 分页进度
            
            // 显示进度
            bottomView.progress.text = "\(recordModel.page.intValue + 1)/\(recordModel.chapterModel!.pageCount.intValue)"
        }
    }
    
    deinit {
        
        bottomView?.removeTimer()
    }
}
