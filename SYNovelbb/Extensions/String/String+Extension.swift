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
    func getTextHeigh(font: UIFont, width: CGFloat) -> CGFloat {
        
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
    
}
