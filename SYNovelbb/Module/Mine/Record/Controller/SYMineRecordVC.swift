//
//  SYMineRecordVC.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SYMineRecordVC: SYBaseVC {
    
    @IBOutlet weak var tableView: UITableView!

    override func setupUI() {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    override func rxBind() {
        
    }

}

extension SYMineRecordVC: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    // 设置占位图显示图片内容
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return R.image.mine_record_empty()!
    }
    
    // 设置占位图图片下文字显示内容
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let attributedString = NSMutableAttributedString.init(string: "No records!")
        attributedString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor(51, 51, 51), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)], range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
}
