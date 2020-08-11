//
//  SYReadCatalogView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

@objc protocol SYReadCatalogViewDelegate: NSObjectProtocol {
    
    /// 点击章节
    @objc optional func catalogViewClickChapter(catalogView:SYReadCatalogView, chapterListModel: SYReadChapterListModel)
}

class SYReadCatalogView: UIView,UITableViewDelegate,UITableViewDataSource {

    /// 代理
    weak var delegate: SYReadCatalogViewDelegate!
    
    /// 数据源
    var readModel: SYReadModel! {
        
        didSet{
            
            tableView.reloadData()
            
            scrollRecord()
        }
    }
    
    private(set) var tableView: SYTableView!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubviews()
    }
    
    private func addSubviews() {
        
        tableView = SYTableView()
        tableView.delegate = self
        tableView.dataSource = self
        addSubview(tableView)
    }
    
    /// 滚动到阅读记录
    func scrollRecord() {
        
        if readModel != nil {
            
            tableView.reloadData()
       
            if !readModel.chapterListModels.isEmpty {
                
                let chapterListModel = (readModel.chapterListModels as NSArray).filtered(using: NSPredicate(format: "id == %@", readModel.recordModel.chapterModel.id)).first as? SYReadChapterListModel
                
                if chapterListModel != nil {
                    
                    tableView.scrollToRow(at: IndexPath(row: readModel.chapterListModels.index(of: chapterListModel!)!, section: 0), at: .middle, animated: false)
                }
            }
        }
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        tableView.frame = bounds
    }
    
    // MARK: UITableViewDelegate,UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if readModel != nil { return readModel.chapterListModels.count }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SYReadCatalogCell.cell(tableView)
        
        // 章节
        let chapterListModel = readModel.chapterListModels[indexPath.row]
        
        // 章节名
        cell.chapterName.text = readModel.chapterListModels[indexPath.row].name
        
        // 阅读记录
        if readModel.recordModel.chapterModel.id == chapterListModel.id {
            
            cell.chapterName.textColor = DZM_READ_COLOR_MAIN
            
        }else{ cell.chapterName.textColor = DZM_COLOR_145_145_145 }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return DZM_SPACE_SA_50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.catalogViewClickChapter?(catalogView: self, chapterListModel: readModel.chapterListModels[indexPath.row])
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
