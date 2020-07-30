//
//  SYSystemMsgModel.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/30.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import HandyJSON

class SYSystemMsgModel: HandyJSON {
    
    var mid: String!
    var fuid: Int!
    var fusername: String?
    var tuid: Int!
    var tusername: String?
    var title: String?
    var contents: String?
    var sendTime: String!
    var isRead: Bool!
    
    var cellHeight: CGFloat? = nil
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {
        mapper.specify(property: &mid, name: "id")
        mapper.specify(property: &contents, name: "Contents")
    }
    
    lazy var showContent: NSAttributedString = {
        if isRead {
            let attributedText = NSMutableAttributedString.init(string: contents ?? "")
            attributedText.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(51, 51, 51)], range: NSMakeRange(0, attributedText.length))
            return attributedText
        } else {
            let attach = NSTextAttachment()
            attach.image = R.image.mine_read_tips()!
            attach.bounds = CGRect.init(x: 0, y: 2, width: 6, height: 6)
            let imageAttr = NSMutableAttributedString.init(attributedString: NSAttributedString.init(attachment: attach))
            
            let textAttr = NSMutableAttributedString.init(string: "   \(contents ?? "")")
            textAttr.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor(51, 51, 51)], range: NSMakeRange(0, textAttr.length))
            imageAttr.append(textAttr)
            return imageAttr
        }
    }()

}
