//
//  SYReadMenu.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

@objc protocol SYReadMenuDelegate:NSObjectProtocol {
    
    /// 菜单将要显示
    @objc optional func readMenuWillDisplay(readMenu: SYReadMenu!)
    
    /// 菜单完成显示
    @objc optional func readMenuDidDisplay(readMenu: SYReadMenu!)
    
    /// 菜单将要隐藏
    @objc optional func readMenuWillEndDisplay(readMenu: SYReadMenu!)
    
    /// 菜单完成隐藏
    @objc optional func readMenuDidEndDisplay(readMenu: SYReadMenu!)
    
    /// 点击返回
    @objc optional func readMenuClickBack(readMenu: SYReadMenu!)
    
    /// 点击书架(将当前书籍加入或移出书架)
    @objc optional func readMenuClickBookcase(readMenu: SYReadMenu!)
    
    /// 点击目录
    @objc optional func readMenuClickCatalogue(readMenu: SYReadMenu!)
    
    /// 点击上一章
    @objc optional func readMenuClickPreviousChapter(readMenu: SYReadMenu!)
    
    /// 点击下一章
    @objc optional func readMenuClickNextChapter(readMenu: SYReadMenu!)
    
    /// 拖拽章节进度(分页进度)
    @objc optional func readMenuDraggingProgress(readMenu: SYReadMenu!, toPage: NSInteger)
    
    /// 拖拽章节进度(总文章进度,网络文章也可以使用)
    @objc optional func readMenuDraggingProgress(readMenu: SYReadMenu!, toChapterID: NSNumber, toPage: NSInteger)
    
    /// 点击亮度调节
    @objc optional func readMenuClickBrightness(readMenu: SYReadMenu!)
    
    /// 隐藏功能面板
    @objc optional func readMenuHiddenFunctionView(readMenu: SYReadMenu!)
    
    /// 点击切换背景颜色
    @objc optional func readMenuClickBGColor(readMenu: SYReadMenu)
    
    /// 点击切换字体
    @objc optional func readMenuClickFont(readMenu: SYReadMenu)
    
    /// 点击切换字体大小
    @objc optional func readMenuClickFontSize(readMenu: SYReadMenu)
    
    /// 切换进度显示(分页 || 总进度)
    @objc optional func readMenuClickDisplayProgress(readMenu:SYReadMenu)
    
    /// 点击切换间距
    @objc optional func readMenuClickSpacing(readMenu:SYReadMenu)
    
    /// 点击切换翻页效果
    @objc optional func readMenuClickEffect(readMenu:SYReadMenu)
}

class SYReadMenu: NSObject,UIGestureRecognizerDelegate {

    /// 控制器
    private(set) weak var vc: SYReadController!
    
    /// 阅读主视图
    private(set) weak var contentView: SYReadContentView!
    
    /// 代理
    private(set) weak var delegate: SYReadMenuDelegate!
    
    /// 菜单显示状态
    private(set) var isMenuShow: Bool = false
    
    /// 单击手势
    private(set) var singleTap: UITapGestureRecognizer!
    
    /// TopView
    private(set) var topView: SYRMTopView!
    
    /// BottomView
    private(set) var bottomView: SYRMBottomView!
    
    /// LightView
    private(set) var lightView: SYRMLightView!
    
    /// SettingView
    private(set) var settingView: SYRMSettingView!
    
    /// ErrorView
    private(set) var errorView: SYRMErrorView!
    
    /// 禁用系统初始化
    private override init() { super.init() }
    
    /// 初始化
    convenience init(vc: SYReadController!, delegate:SYReadMenuDelegate!) {
        
        self.init()
        
        // 记录
        self.vc = vc
        self.contentView = vc.contentView
        self.delegate = delegate
        
        // 隐藏状态栏
        UIApplication.shared.setStatusBarHidden(!isMenuShow, with: .fade)
        
        // 允许获取电量信息
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        // 禁止手势返回
        vc.fd_interactivePopDisabled = true
        
        // 添加单机手势
        initTapGestureRecognizer()
        
        // 初始化TopView
        initTopView()
        
        // 初始化SettingView
        initSettingView()
        
        // 初始化LightView
        initLightView()
        
        // 初始化ErrorView
        initErrorView()
        
        // 初始化BottomView
        initBottomView()
    }
    
    // MARK: -- 添加单机手势
    
    /// 添加单机手势
    private func initTapGestureRecognizer() {
        
        // 单击手势
        singleTap = UITapGestureRecognizer(target: self, action: #selector(touchSingleTap))
        singleTap.numberOfTapsRequired = 1
        singleTap.delegate = self
        vc.contentView.addGestureRecognizer(singleTap)
    }
    
    // 触发单击手势
    @objc private func touchSingleTap() {
        
        showMenu(isShow: !isMenuShow)
    }
    
    // MARK: -- UIGestureRecognizerDelegate
    
    /// 点击这些控件不需要执行手势
    private let ClassStrings:[String] = ["SYRMTopView", "SYRMBottomView", "SYRMSettingView", "SYRMLightView", "SYRMFuncView", "SYRMProgressView", "UIControl", "UISlider", "ASValueTrackingSlider", "SYRMErrorView", "YYTextView", "YYTextContainerView"]
    
    /// 手势拦截
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        let classString = String(describing: type(of: touch.view!))
        
        if ClassStrings.contains(classString) {
            
            return false
        }
        
        return true
    }
    
    // MARK: -- TopView
    
    /// 初始化TopView
    private func initTopView() {
        topView = SYRMTopView(readMenu: self)
        topView.isHidden = !isMenuShow
        contentView.addSubview(topView)
        let y = isMenuShow ? 0 : -SY_READ_MENU_TOP_VIEW_HEIGHT
        topView.frame = CGRect(x: 0, y: y, width: SY_READ_CONTENT_VIEW_WIDTH, height: SY_READ_MENU_TOP_VIEW_HEIGHT)
        topView.titleLabel.text = self.vc.readModel.bookName
    }
    
    // MARK: -- BottomView
    
    /// 初始化BottomView
    private func initBottomView() {
        
        bottomView = SYRMBottomView(readMenu: self)
    
        bottomView.isHidden = !isMenuShow
        
        contentView.addSubview(bottomView)
        
        let y = isMenuShow ? (SY_READ_CONTENT_VIEW_HEIGHT - SY_READ_MENU_BOTTOM_VIEW_HEIGHT) : SY_READ_CONTENT_VIEW_HEIGHT
        
        bottomView.frame = CGRect(x: 0, y: y, width: SY_READ_CONTENT_VIEW_WIDTH, height: SY_READ_MENU_BOTTOM_VIEW_HEIGHT)
    }
    
    // MARK: -- LightView
    private func initLightView() {
        lightView = SYRMLightView(readMenu: self)
        lightView.isHidden = true
        contentView.addSubview(lightView)
        lightView.frame = CGRect(x: 0, y: SY_READ_CONTENT_VIEW_HEIGHT, width: SY_READ_CONTENT_VIEW_WIDTH, height: 52.5 + BottomSafeAreaHeight)
    }
    
    // MARK: -- ErrorView
    private func initErrorView() {
        errorView = SYRMErrorView(readMenu: self)
        errorView.isHidden = true
        contentView.addSubview(errorView)
        errorView.frame = CGRect(x: 0, y: SY_READ_CONTENT_VIEW_HEIGHT, width: SY_READ_CONTENT_VIEW_WIDTH, height: 250 + BottomSafeAreaHeight)
    }
    
    // MARK: -- SettingView
    
    /// 初始化SettingView
    private func initSettingView() {
        
        settingView = SYRMSettingView(readMenu: self)
        
        settingView.isHidden = true
        
        contentView.addSubview(settingView)
        
        settingView.frame = CGRect(x: 0, y: SY_READ_CONTENT_VIEW_HEIGHT, width: SY_READ_CONTENT_VIEW_WIDTH, height: BottomSafeAreaHeight + 166)
    }
    
    // MARK: 菜单展示
    
    /// 动画是否完成
    private var isAnimateComplete:Bool = true
    
    func showMenu(isShow:Bool) {

        if isMenuShow == isShow || !isAnimateComplete {return}
        
        isAnimateComplete = false
        
        if isShow { delegate?.readMenuWillDisplay?(readMenu: self)
            
        }else{ delegate?.readMenuWillEndDisplay?(readMenu: self) }
        
        isMenuShow = isShow
        
        showBottomView(isShow: isShow)
        
        showLightView(isShow: false)
        
        showErrorView(isShow: false)

        showSettingView(isShow: false)
        
        showTopView(isShow: isShow) { [weak self] () in
            
            self?.isAnimateComplete = true
            
            if isShow { self?.delegate?.readMenuDidDisplay?(readMenu: self!)
                
            }else{ self?.delegate?.readMenuDidEndDisplay?(readMenu: self!) }
        }
    }
    
    /// TopView展示
    func showTopView(isShow: Bool, completion: SYAnimationCompletion? = nil) {
        
        UIApplication.shared.setStatusBarHidden(!isShow, with: .slide)
        
        if isShow { topView.isHidden = false }
        
        UIView.animate(withDuration: SY_READ_ANIMATION_TIME, delay: 0, options: .curveEaseOut, animations: { [weak self] () in
            
            let y = isShow ? 0 : -SY_READ_MENU_TOP_VIEW_HEIGHT
            
            self?.topView.frame.origin = CGPoint(x: 0, y: y)
            
        }) { [weak self] (isOK) in
            
            if !isShow { self?.topView.isHidden = true }
            
            completion?()
        }
    }
    
    /// BottomView展示
    func showBottomView(isShow: Bool, completion: SYAnimationCompletion? = nil) {
  
        if isShow { bottomView.isHidden = false }

        UIView.animate(withDuration: SY_READ_ANIMATION_TIME, animations: { [weak self] () in
            
            let y = isShow ? (SY_READ_CONTENT_VIEW_HEIGHT - SY_READ_MENU_BOTTOM_VIEW_HEIGHT) : SY_READ_CONTENT_VIEW_HEIGHT
            
            self?.bottomView.frame.origin = CGPoint(x: 0, y: y)
            
        }) { [weak self] (isOK) in
            
            if !isShow { self?.bottomView.isHidden = true }
            
            completion?()
        }
    }
    
    /// LightView展示
    func showLightView(isShow: Bool, completion: SYAnimationCompletion? = nil) {
        if isShow { lightView.isHidden = false }
        
        UIView.animate(withDuration: SY_READ_ANIMATION_TIME, delay: 0, options: .curveEaseOut, animations: { [weak self] () in

            let y = isShow ? (SY_READ_CONTENT_VIEW_HEIGHT - BottomSafeAreaHeight - 52.5) : SY_READ_CONTENT_VIEW_HEIGHT

            self?.lightView.frame.origin = CGPoint(x: 0, y: y)

        }) { [weak self] (isOK) in

            if !isShow { self?.lightView.isHidden = true }

            completion?()
        }
    }
    
    /// ErrorView展示
    func showErrorView(isShow: Bool, completion: SYAnimationCompletion? = nil) {
        if isShow { errorView.isHidden = false }
        
        UIView.animate(withDuration: SY_READ_ANIMATION_TIME, delay: 0, options: .curveEaseOut, animations: { [weak self] () in

            let y = isShow ? (SY_READ_CONTENT_VIEW_HEIGHT - BottomSafeAreaHeight - 250) : SY_READ_CONTENT_VIEW_HEIGHT

            self?.errorView.frame.origin = CGPoint(x: 0, y: y)

        }) { [weak self] (isOK) in

            if !isShow { self?.errorView.isHidden = true }

            completion?()
        }
    }
    
    /// SettingView展示
    func showSettingView(isShow: Bool, completion: SYAnimationCompletion? = nil) {
      
        if isShow { settingView.isHidden = false }

        UIView.animate(withDuration: SY_READ_ANIMATION_TIME, delay: 0, options: .curveEaseOut, animations: { [weak self] () in

            let y = isShow ? (SY_READ_CONTENT_VIEW_HEIGHT - BottomSafeAreaHeight - 166) : SY_READ_CONTENT_VIEW_HEIGHT

            self?.settingView.frame.origin = CGPoint(x: 0, y: y)

        }) { [weak self] (isOK) in

            if !isShow { self?.settingView.isHidden = true }

            completion?()
        }
    }
    
}
