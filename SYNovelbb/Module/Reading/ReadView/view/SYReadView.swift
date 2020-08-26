//
//  SYReadView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadView: UIView {
    
    /// 当前页模型(使用contentSize绘制)
    var pageModel: SYReadPageModel! {
        
        didSet{
            
            frameRef = SYCoreText.GetFrameRef(attrString: pageModel.showContent, rect: CGRect(origin: CGPoint.zero, size: pageModel.contentSize))
        }
    }
    
    /// 当前页内容(使用固定范围绘制)
    var content: NSAttributedString! {
        
        didSet{
            
            frameRef = SYCoreText.GetFrameRef(attrString: content, rect: CGRect(origin: CGPoint.zero, size: SY_READ_VIEW_RECT.size))
        }
    }
    
    /// CTFrame
    var frameRef: CTFrame? {
        
        didSet{
            
            if frameRef != nil { setNeedsDisplay() }
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        // 正常使用
        backgroundColor = UIColor.clear
        
        // 可以修改为随机颜色便于调试范围
//        backgroundColor = DZM_COLOR_ARC
    }
    
    /// 绘制
    override func draw(_ rect: CGRect) {
        
        if (frameRef == nil) {return}
        
        let ctx = UIGraphicsGetCurrentContext()
        
        ctx?.textMatrix = CGAffineTransform.identity
        
        ctx?.translateBy(x: 0, y: bounds.size.height);
        
        ctx?.scaleBy(x: 1.0, y: -1.0);
        
        CTFrameDraw(frameRef!, ctx!);
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("\(self)已释放")
    }
}
