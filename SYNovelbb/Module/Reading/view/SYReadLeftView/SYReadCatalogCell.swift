//
//  SYReadCatalogCell.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYReadCatalogCell: UITableViewCell {

    private(set) var chapterName:UILabel!
    
    private(set) var spaceLine:UIView!
    
    class func cell(_ tableView:UITableView) -> SYReadCatalogCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "SYReadCatalogCell")
        
        if cell == nil {
            
            cell = SYReadCatalogCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "SYReadCatalogCell")
        }
        
        return cell as! SYReadCatalogCell
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        backgroundColor = UIColor.clear
        
        addSubviews()
    }
    
    private func addSubviews() {
        
        chapterName = UILabel()
        chapterName.font = DZM_FONT_SA_14
        chapterName.textColor = DZM_COLOR_145_145_145
        contentView.addSubview(chapterName)
        
        spaceLine = SpaceLine(contentView, DZM_COLOR_230_230_230)
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        let w = frame.size.width
        let h = frame.size.height
        
        chapterName.frame = CGRect(x: DZM_SPACE_SA_15, y: 0, width: w - DZM_SPACE_SA_30, height: h)
        
        spaceLine.frame = CGRect(x: DZM_SPACE_SA_15, y: h - DZM_SPACE_LINE, width: w - DZM_SPACE_SA_30, height: DZM_SPACE_LINE)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
