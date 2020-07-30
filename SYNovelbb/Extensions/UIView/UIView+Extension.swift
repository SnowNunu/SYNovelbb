//
//  UIView+Extension.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/29.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

extension UIView {
    
    /// 设置UIView的四角圆角属性
    /// - Parameters:
    ///   - corner: 需要设置的角落
    ///   - radii: 弧度
    public func configRectCorner(corner: UIRectCorner, radii: CGSize) {
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: radii)
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
}
