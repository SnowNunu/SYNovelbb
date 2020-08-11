//
//  SYViewController.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        initialize()
        
        addSubviews()
        
        addComplete()
    }
    
    func initialize() {
        
        view.backgroundColor = UIColor.white
        
        extendedLayoutIncludesOpaqueBars = true
        
        if #available(iOS 11.0, *) { } else {
            
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func addSubviews() { }
    
    func addComplete() { }
}
