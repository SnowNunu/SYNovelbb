//
//  SYReadViewCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadViewCell: UITableViewCell {

    /// 阅读视图
    private var readView:SYReadView!
    
    var pageModel: SYReadPageModel! {
        
        didSet{
            
            readView.pageModel = pageModel
            
            setNeedsLayout()
        }
    }
    
    class func cell(_ tableView:UITableView) -> SYReadViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "SYReadViewCell")
        
        if cell == nil {
            
            cell = SYReadViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SYReadViewCell")
        }
        
        return cell as! SYReadViewCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        backgroundColor = UIColor.clear
        
        addSubviews()
    }
    
    private func addSubviews() {
        
        // 阅读视图
        readView = SYReadView()
        contentView.addSubview(readView)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
      
        // 分页顶部高度
        let y = pageModel?.headTypeHeight ?? DZM_SPACE_MIN_HEIGHT
        
        // 内容高度
        let h = pageModel?.contentSize.height ?? DZM_SPACE_MIN_HEIGHT

        readView.frame = CGRect(x: 0, y: y, width: DZM_READ_VIEW_RECT.width, height: h)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
