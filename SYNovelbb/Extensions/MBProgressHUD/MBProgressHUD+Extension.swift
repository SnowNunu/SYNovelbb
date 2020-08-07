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
    
    class func show(message: String!, toView: UIView?, delay: Double = 1.5) {
        let view = (toView == nil ? UIApplication.shared.windows.first : toView!)!
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.detailsLabel.text = message
        hud.detailsLabel.textColor = .white
        hud.bezelView.style = .solidColor;
        hud.bezelView.color = .black
        hud.hide(animated: true, afterDelay: delay)
    }
    
}
