//
//  SYReadHomeViewCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadHomeViewCell: UITableViewCell {

    /// 书籍首页视图
    private(set) var homeView:SYReadHomeView!
    
    class func cell(_ tableView:UITableView) -> SYReadHomeViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "SYReadHomeViewCell")
        
        if cell == nil {
            
            cell = SYReadHomeViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SYReadHomeViewCell")
        }
        
        return cell as! SYReadHomeViewCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        backgroundColor = UIColor.clear
        
        addSubviews()
    }
    
    private func addSubviews() {
        
        // 书籍首页
        homeView = SYReadHomeView()
        contentView.addSubview(homeView)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        homeView.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
