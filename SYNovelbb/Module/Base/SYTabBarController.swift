//
//  SYTabBarController.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/22.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import YYCategories

class SYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置文字颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(68, 68, 68)], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(68, 68, 68)], for:.selected)
        // 修改tabBar背景色
        self.tabBar.barTintColor = UIColor(255, 254, 255)
        // 关闭毛玻璃效果
        self.tabBar.isTranslucent = false
        // 修改tabBar顶部线条颜色，缺一不可
        let image = UIImage(color: UIColor(224, 221, 224))!
        self.tabBar.shadowImage = image
        self.tabBar.backgroundImage = UIImage()
        setViewControllers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = UIColor(68, 68, 68)
        }
    }
    
    func setViewControllers() {
        let feature = getViewController(controller: UIViewController(), title: "Featured", image: R.image.tabBar_featured_unselected()!, selectedImage: R.image.tabBar_featured_selected()!)
        let library = getViewController(controller: UIViewController(), title: "Library", image: R.image.tabBar_library_unselected()!, selectedImage: R.image.tabBar_library_selected()!)
        let mine = getViewController(controller: UIViewController(), title: "Mine", image: R.image.tabBar_mine_unselected()!, selectedImage: R.image.tabBar_mine_selected()!)
        viewControllers = [feature, library, mine]
    }
    
    private func getViewController(controller: UIViewController, title: String, image: UIImage, selectedImage: UIImage) -> SYNavigationController {
        controller.navigationItem.title = title
        controller.tabBarItem = UITabBarItem (title:title, image: image.withRenderingMode(.alwaysOriginal),selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
        return SYNavigationController.init(rootViewController: controller)
    }

}
