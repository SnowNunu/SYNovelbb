//
//  SYSearchResultFlowLayout.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/6.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

class SYSearchResultFlowLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        scrollDirection = .vertical
        itemSize = .init(width: ScreenWidth - 30, height: 115)
        sectionInset = .init(top: 15, left: 15, bottom: 15, right: 15)
        minimumLineSpacing = 15
    }
    
}
