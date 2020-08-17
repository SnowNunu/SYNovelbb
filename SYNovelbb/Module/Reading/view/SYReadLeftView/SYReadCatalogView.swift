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

class SYReadCatalogView: UIView, UITableViewDelegate, UITableViewDataSource {

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
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    /// 滚动到阅读记录
    func scrollRecord() {
        
        if readModel != nil {
            
            tableView.reloadData()
       
            if !readModel.chapterListModels.isEmpty {
                
                let chapterListModel = (readModel.chapterListModels as NSArray).filtered(using: NSPredicate(format: "id == %@", readModel.recordModel.chapterModel.chapterId)).first as? SYReadChapterListModel
                
                if chapterListModel != nil {
                    
                    tableView.scrollToRow(at: IndexPath(row: readModel.chapterListModels.firstIndex(of: chapterListModel!)!, section: 0), at: .middle, animated: false)
                }
            }
        }
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
        let content = chapterListModel.name
        if readModel.recordModel.chapterModel.chapterId == chapterListModel.id {
            let attach = NSTextAttachment()
            attach.image = R.image.reading_current_read()!
            attach.bounds = CGRect.init(x: 0, y: 2, width: 5, height: 5)
            let imageAttr = NSMutableAttributedString.init(attributedString: NSAttributedString.init(attachment: attach))
            
            let textAttr = NSMutableAttributedString.init(string: "  \(content ?? "")")
            textAttr.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(116, 116, 116)], range: NSMakeRange(0, textAttr.length))
            imageAttr.append(textAttr)
            cell.chapterName.attributedText = imageAttr
        } else {
            let attributedText = NSMutableAttributedString.init(string: content ?? "")
            attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(116, 116, 116)], range: NSMakeRange(0, attributedText.length))
            cell.chapterName.attributedText = attributedText
        }
        cell.vipImage.isHidden = chapterListModel.isVip
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.catalogViewClickChapter?(catalogView: self, chapterListModel: readModel.chapterListModels[indexPath.row])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
