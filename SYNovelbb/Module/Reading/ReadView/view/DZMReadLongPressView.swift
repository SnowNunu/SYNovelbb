//
//  DZMReadLongPressView.swift
//  DZMeBookRead
//
//  Created by dengzemiao on 2019/4/30.
//  Copyright © 2019年 DZM. All rights reserved.
//


/// Pan手势状态
enum DZMPanGesStatus:NSInteger {
    // 开始手势
    case begin
    // 变换中
    case changed
    // 结束手势
    case end
}

import UIKit

class DZMReadLongPressView: DZMReadView {
    
    /// 开启拖拽
    private(set) var isOpenDrag:Bool = false
    
    /// 选中区域
    private var selectRange:NSRange!
    
    /// 选中区域CGRect数组
    private var rects:[CGRect] = []
    
    /// 单击
    private var tapGes:UITapGestureRecognizer?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction(tap:)))
        tapGes!.isEnabled = false
        addGestureRecognizer(tapGes!)
    }
    
    // MARK: 手势事件
    
    /// 单击事件
    @objc private func tapAction(tap:UITapGestureRecognizer) {
        
        // 重置页面数据
        reset()
    }
    
    // MARK: 页面触摸拖拽处理
    
    /// 触摸开始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        drag(touches: touches, status: .begin)
    }
    
    /// 触摸移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        drag(touches: touches, status: .changed)
    }
    
    /// 触摸结束
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        drag(touches: touches, status: .end)
    }
    
    /// 触摸取消
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        drag(touches: touches, status: .end)
    }
    
    /// 解析触摸事件
    private func drag(touches: Set<UITouch>, status: DZMPanGesStatus) {
        
        if isOpenDrag {
            
            let touch:UITouch? = ((touches as NSSet).anyObject() as? UITouch)
            
            let point = touch?.location(in: self)
            
            let windowPoint = touch?.location(in: self.window)
            
            drag(status: status, point: point!, windowPoint: windowPoint!)
        }
    }
    
    /// 拖拽事件解析
    func drag(status:DZMPanGesStatus, point:CGPoint, windowPoint:CGPoint) {
   
        // 检查是否超出范围
        let point = CGPoint(x: min(max(point.x, 0), pageModel.contentSize.width), y: min(max(point.y, 0), pageModel.contentSize.height))

        // 触摸开始
        if status == .begin {
           
            // 隐藏菜单
            showMenu(isShow: false)
            
        } else if status == .changed { // 触摸中
         
            
        }else{ // 触摸结束
   
        }
        
        // 重绘
        setNeedsDisplay()
    }
    
    // MARK: 重置页面
    
    /// 重置页面数据
    private func reset() {

        // 手势状态
        tapGes?.isEnabled = false
        isOpenDrag = false
        
        // 移除菜单
        showMenu(isShow: false)
        
        // 清空选中
        selectRange = nil
        rects.removeAll()
        
        // 重绘
        setNeedsDisplay()
    }
    
    // MARK: 菜单相关
    
    /// 隐藏或显示菜单
    private func showMenu(isShow:Bool) {
        
        if isShow { // 显示
            
            if !rects.isEmpty {
            
                let rect = DZMCoreText.GetMenuRect(rects: rects, viewFrame: bounds)
                
                becomeFirstResponder()
                
                let menuController = UIMenuController.shared
                
                let copy = UIMenuItem(title: "复制", action: #selector(clickCopy))
                
                menuController.menuItems = [copy]
                
                menuController.setTargetRect(rect, in: self)
                
                DelayHandle {
                    
                    menuController.setMenuVisible(true, animated: true)
                }
            }
            
        }else{ // 隐藏
            
            UIMenuController.shared.setMenuVisible(false, animated: true)
        }
    }
    
    /// 允许菜单事件
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(clickCopy) { return true }
        
        return false
    }
    
    /// 允许成为响应者
    override var canBecomeFirstResponder: Bool {
        
        return true
    }
    
    /// 复制事件
    @objc private func clickCopy() {
        
        if selectRange != nil {
            
            let temSelectRange = selectRange!
            
            let tempContent = pageModel.content
            
            DispatchQueue.global().async {
                
                UIPasteboard.general.string = tempContent?.string.substring(temSelectRange)
            }
            
            // 重置页面数据
            reset()
        }
    }
    
    // MARK: 绘制
    
    /// 绘制
    override func draw(_ rect: CGRect) {
        
        if (frameRef == nil) {return}
        
        let ctx = UIGraphicsGetCurrentContext()
        
        ctx?.textMatrix = CGAffineTransform.identity
        
        ctx?.translateBy(x: 0, y: bounds.size.height)
        
        ctx?.scaleBy(x: 1.0, y: -1.0)
        
        if selectRange != nil && !rects.isEmpty {
            
            let path = CGMutablePath()
            
            DZM_READ_COLOR_MAIN.withAlphaComponent(0.5).setFill()
            
            path.addRects(rects)
            
            ctx?.addPath(path)
            
            ctx?.fillPath()
        }
        
        CTFrameDraw(frameRef!, ctx!)
    }
    
    /// 释放
    deinit {
        
        tapGes?.removeTarget(self, action: #selector(tapAction(tap:)))
        tapGes = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
