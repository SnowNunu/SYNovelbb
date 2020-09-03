//
//  MBProgressHUD+Extension.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/7.
//  Copyright © 2020 Mandora. All rights reserved.
//

import Foundation
import MBProgressHUD

extension MBProgressHUD {
    
    /// 显示信息提示框
    class func show(message: String!, toView: UIView?, delay: Double = 1.5) {
        let view = (toView == nil ? UIApplication.shared.windows.first : toView!)!
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.detailsLabel.text = message
        hud.detailsLabel.textColor = .white
        hud.bezelView.style = .solidColor;
        hud.bezelView.color = .black
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay: delay)
    }
    
    /// 显示加载框
    class func showLoading(message: String!, toView: UIView?) {
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf:[MBProgressHUD.self]).color = .white
        let view = (toView == nil ? UIApplication.shared.windows.first : toView!)!
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .indeterminate
        hud.label.text = message
        hud.label.textColor = .white
        hud.label.font = .systemFont(ofSize: 12, weight: .semibold)
        hud.label.numberOfLines = 0
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = .solidColor;
        hud.bezelView.color = .black
    }
    
    class func dismiss() {
        MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
    }
    
}
