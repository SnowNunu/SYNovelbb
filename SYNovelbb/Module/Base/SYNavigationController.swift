//
//  SYNavigationController.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/23.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import FDFullscreenPopGesture
import CocoaLumberjack

class SYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 开启右滑返回手势
        self.fd_fullscreenPopGestureRecognizer.isEnabled = true
        self.navigationBar.barTintColor = .white
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :UIColor(51, 51, 51)]
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            // 非根控制器
            viewController.hidesBottomBarWhenPushed = true
            
            let backButton : UIButton = UIButton(type : .system)
            backButton.setImage(UIImage(named :"navigation_back")?.withRenderingMode(.alwaysOriginal), for: .normal)
            backButton.addTarget(self, action :#selector(goBack), for: .touchUpInside)
            backButton.sizeToFit()
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView:backButton)
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    //MARK: action
    @objc func goBack() {
        popViewController(animated: true)
    }
    
    deinit {
        DDLogInfo("\(self) 已释放")
    }

}
