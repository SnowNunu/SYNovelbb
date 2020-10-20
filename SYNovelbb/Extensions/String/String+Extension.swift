//
//  String+Extension.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/10.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

extension String {
    
    /// 获取字符串中含有的所有子串的range数组
    /// - Parameter string: 子串
    /// - Returns: range数组
    func ranges(of string: String) -> [Range<String.Index>] {
        var rangeArray = [Range<String.Index>]()
        var searchedRange: Range<String.Index>
        guard let sr = self.range(of: self) else {
            return rangeArray
        }
        searchedRange = sr
        
        var resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        while let range = resultRange {
            rangeArray.append(range)
            searchedRange = Range(uncheckedBounds: (range.upperBound, searchedRange.upperBound))
            resultRange = self.range(of: string, options: .regularExpression, range: searchedRange, locale: nil)
        }
        return rangeArray
    }
    
    /// Range转NSRange
    func nsrange(fromRange range : Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    func nsranges(of string: String) -> [NSRange] {
        return ranges(of: string).map { (range) -> NSRange in
            self.nsrange(fromRange: range)
        }
    }
    
    //MARK: 计算文字宽高
    func getTextHeight(font: UIFont, width: CGFloat) -> CGFloat {
        
        return self.textSize(font: font, width: width, height: CGFloat(MAXFLOAT)).height
    }
    
    func getTexWidth(font: UIFont, height: CGFloat) -> CGFloat {
        
        return self.textSize(font: font, width: CGFloat(MAXFLOAT), height: height).width
    }

    private func textSize(font: UIFont, width: CGFloat, height: CGFloat) -> CGSize {
        let size = CGSize(width: width, height: height)
        let attributes = [NSAttributedString.Key.font: font]
        return self.boundingRect(with: size, options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine, .usesFontLeading], attributes: attributes as [NSAttributedString.Key : Any], context:nil).size
    }
    
    var length:Int { return (self as NSString).length }
    
    var bool:Bool { return (self as NSString).boolValue }
    
    var integer:NSInteger { return (self as NSString).integerValue }
    
    var float:Float { return (self as NSString).floatValue }
    
    var cgFloat:CGFloat { return CGFloat(self.float) }
    
    var double:Double { return (self as NSString).doubleValue }
    
    /// 文件后缀(不带'.')
    var pathExtension:String { return (self as NSString).pathExtension }
    
    /// 文件名(带后缀)
    var lastPathComponent:String { return (self as NSString).lastPathComponent }
    
    /// 文件名(不带后缀)
    var deletingPathExtension:String { return (self as NSString).deletingPathExtension }
    
    /// 去除首尾空格
    var removeSpaceHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾换行
    var removeEnterHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespaces) }
    
    /// 去除首尾空格和换行
    var removeSEHeadAndTail:String { return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) }
    
    /// 去掉所有空格
    var removeSapceAll:String { return replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "　", with: "") }
    
    /// 去除所有换行
    var removeEnterAll:String { return replacingOccurrences(of: "\r", with: "").replacingOccurrences(of: "\n", with: "") }
    
    /// 去除所有空格换行
    var removeSapceEnterAll:String { return removeSapceAll.replacingOccurrences(of: "\n", with: "") }
    
    /// 是否为整数
    var isInt:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
    
    /// 是否为数字或Float
    var isFloat:Bool {
        
        let scan: Scanner = Scanner(string: self)
        
        var val:Float = 0
        
        return scan.scanFloat(&val) && scan.isAtEnd
    }
    
    /// 是否为空格
    var isSpace:Bool {
        
        if (self == " ") || (self == "　") { return true }
        
        return false
    }
    
    /// 是否为空格或者回车
    var isSpaceOrEnter:Bool {
        
        if isSpace || (self == "\n") { return true }
        
        return false
    }
    
    /// 转JSON
    var json:Any? {
        
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        
        return json
    }
    
    /// 是否包含指定字符串
    func range(_ string: String) ->NSRange {
        
        return (self as NSString).range(of: string)
    }
    
    /// 截取字符串
    func substring(_ range:NSRange) ->String {
        
        return (self as NSString).substring(with: range)
    }
    
    /// 处理带中文的字符串
    func addingPercentEncoding(_ characters: CharacterSet = .urlQueryAllowed) ->String {
        
        return (self as NSString).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
    }
    
    /// 正则替换字符
    func replacingCharacters(_ pattern:String, _ template:String) ->String {
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length), withTemplate: template)
            
        } catch {return self}
    }
    
    /// 正则搜索相关字符位置
    func matches(_ pattern:String) ->[NSTextCheckingResult] {
        
        if isEmpty {return []}
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length))
            
        } catch {return []}
    }
    
    /// 计算大小
    func size(_ font:UIFont, _ size:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {
        
        let string:NSString = self as NSString
        
        return string.boundingRect(with: size, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [.font:font], context: nil).size
    }
    
}

extension String {
    var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
}

extension NSAttributedString {
    
    /// 计算size
    func size(_ size:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) ->CGSize{
        
        return self.boundingRect(with: size, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading], context: nil).size
    }
    
    /// 扩展拼接
    func add<T:NSAttributedString>(_ string:T) ->NSAttributedString {
        
        let attributedText = NSMutableAttributedString(attributedString: self)
        
        attributedText.append(string)
        
        return attributedText
    }
}
