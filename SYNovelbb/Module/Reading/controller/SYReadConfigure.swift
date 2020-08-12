//
//  SYReadConfigure.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

/// 一切为了好玩 》》》》》
///// 主题颜色
//var DZM_READ_COLOR_MAIN:UIColor { return DZM_COLOR_ARC } // DZM_COLOR_253_85_103
//
///// 菜单默认颜色
//var DZM_READ_COLOR_MENU_COLOR:UIColor { return DZM_COLOR_ARC } // DZM_COLOR_235_235_235
//
///// 菜单背景颜色

/// 主题颜色
var DZM_READ_COLOR_MAIN:UIColor = DZM_COLOR_253_85_103

/// 菜单默认颜色
var DZM_READ_COLOR_MENU_COLOR:UIColor = DZM_COLOR_230_230_230

/// 阅读背景颜色列表
let DZM_READ_BG_COLORS:[UIColor] = [UIColor.white, DZM_COLOR_238_224_202, DZM_COLOR_205_239_205, DZM_COLOR_206_233_241, DZM_COLOR_58_52_54, DZM_COLOR_BG_0]

/// 阅读字体颜色列表
/// let DZM_READ_TEXT_COLORS:[UIColor] = [DZM_COLOR_145_145_145]

/// 阅读状态栏字体颜色列表
/// let DZM_READ_STATUS_TEXT_COLORS:[UIColor] = [DZM_COLOR_145_145_145]

/// 阅读最小阅读字体大小
let DZM_READ_FONT_SIZE_MIN:NSInteger = 12

/// 阅读最大阅读字体大小
let DZM_READ_FONT_SIZE_MAX:NSInteger = 24

/// 阅读默认字体大小
let DZM_READ_FONT_SIZE_DEFAULT:NSInteger = 18

/// 阅读字体大小叠加指数
let DZM_READ_FONT_SIZE_SPACE:NSInteger = 2

/// 章节标题 - 在当前字体大小上叠加指数
let DZM_READ_FONT_SIZE_SPACE_TITLE:NSInteger = 8

/// 单利对象
private var configure: SYReadConfigure?

class SYReadConfigure: NSObject {
    
    // MARK: 阅读内容配置
    
    /// 背景颜色索引
    @objc var bgColorIndex:NSNumber!
    
    /// 字体类型索引
    @objc var fontIndex:NSNumber!
    
    /// 翻页类型索引
    @objc var effectIndex:NSNumber!
    
    /// 间距类型索引
    @objc var spacingIndex:NSNumber!
    
    /// 进度显示索引
    @objc var progressIndex:NSNumber!
    
    /// 字体大小
    @objc var fontSize:NSNumber!
    
    
    // MARK: 快捷获取
    
    /// 使用分页进度 || 总文章进度(网络文章也可以使用)
    /// 总文章进度注意: 总文章进度需要有整本书的章节总数,以及当前章节带有从0开始排序的索引。
    /// 如果还需要在拖拽底部功能条上进度条过程中展示章节名,则需要带上章节列表数据,并去 SYRMProgressView 文件中找到 ASValueTrackingSliderDataSource 修改返回数据源为章节名。
    var progressType:DZMProgressType! { return DZMProgressType(rawValue: progressIndex.intValue) }
    
    /// 翻页类型
    var effectType:SYEffectType! { return SYEffectType(rawValue: effectIndex.intValue) }
    
    /// 字体类型
    var fontType:DZMFontType! { return DZMFontType(rawValue: fontIndex.intValue) }
    
    /// 间距类型
    var spacingType:DZMSpacingType! { return DZMSpacingType(rawValue: spacingIndex.intValue) }
    
    /// 背景颜色
    var bgColor:UIColor! {
        
        if bgColorIndex.intValue == DZM_READ_BG_COLORS.firstIndex(of: DZM_COLOR_BG_0) { // 牛皮黄背景
            
            return UIColor(patternImage: UIImage(named: "read_bg_0")!)
            
        }else{
            
            return DZM_READ_BG_COLORS[bgColorIndex.intValue]
        }
    }
    
    /// 字体颜色
    var textColor:UIColor! {
        
        // 固定颜色
        return DZM_COLOR_145_145_145
    
        // 根据背景颜色选择
//        return DZM_READ_TEXT_COLORS[bgColorIndex.intValue]
        
        // 字体颜色列表选择
//        return DZM_READ_TEXT_COLORS[textColorIndex.intValue]
    }
    
    /// 状态栏字体颜色
    var statusTextColor:UIColor! {
        
        // 固定颜色
        return DZM_COLOR_145_145_145
        
        // 根据背景颜色选择
//        return DZM_READ_STATUS_TEXT_COLORS[bgColorIndex.intValue]
        
        // 字体颜色列表选择
//         return DZM_READ_STATUS_TEXT_COLORS[statusTextColorIndex.intValue]
    }
    
    /// 行间距(请设置整数,因为需要比较是否需要重新分页,小数点没法判断相等)
    var lineSpacing:CGFloat! {
    
        if spacingType == .big { // 大间距
            
            return DZM_SPACE_10
            
        }else if spacingType == .middle { // 中间距
            
            return DZM_SPACE_7
            
        }else{ // 小间距
            
            return DZM_SPACE_5
        }
    }
    
    /// 段间距(请设置整数,因为需要比较是否需要重新分页,小数点没法判断相等)
    var paragraphSpacing:CGFloat {
        
        if spacingType == .big { // 大间距
            
            return DZM_SPACE_20
            
        }else if spacingType == .middle { // 中间距
            
            return DZM_SPACE_15
            
        }else{ // 小间距
            
            return DZM_SPACE_10
        }
    }
    
    /// 阅读字体
    func font(isTitle:Bool = false) ->UIFont {
        
        let size = SA_SIZE(CGFloat(fontSize.intValue + (isTitle ? DZM_READ_FONT_SIZE_SPACE_TITLE : 0)))
        
        let fontType = self.fontType
        
        if fontType == .one { // 黑体
            
            return UIFont(name: "EuphemiaUCAS-Italic", size: size)!
            
        }else if fontType == .two { // 楷体
            
            return UIFont(name: "AmericanTypewriter-Light", size: size)!
            
        }else if fontType == .three { // 宋体
            
            return UIFont(name: "Papyrus", size: size)!
            
        }else{ // 系统
            
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    /// 字体属性
    /// isPaging: 为YES的时候只需要返回跟分页相关的属性即可 (原因:包含UIColor,小数点相关的...不可返回,因为无法进行比较)
    func attributes(isTitle:Bool, isPageing:Bool = false) ->[NSAttributedString.Key:Any] {
        
        // 段落配置
        let paragraphStyle = NSMutableParagraphStyle()
        
        // 当前行间距(lineSpacing)的倍数(可根据字体大小变化修改倍数)
        paragraphStyle.lineHeightMultiple = 1.0
        
        if isTitle {
            
            // 行间距
            paragraphStyle.lineSpacing = 0
            
            // 段间距
            paragraphStyle.paragraphSpacing = 0
            
            // 对其
            paragraphStyle.alignment = .center
            
        }else{
            
            // 行间距
            paragraphStyle.lineSpacing = lineSpacing
            
            // 段间距
            paragraphStyle.paragraphSpacing = paragraphSpacing
            
            // 对其
            paragraphStyle.alignment = .justified
        }
        
        if isPageing {
            
            return [.font: font(isTitle: isTitle), .paragraphStyle: paragraphStyle]
            
        }else{
            
            return [.foregroundColor: textColor, .font: font(isTitle: isTitle), .paragraphStyle: paragraphStyle]
        }
    }
    
    
    // MARK: 辅助
    
    /// 保存(使用 SYUserDefaults 存储是方便配置修改)
    func save() {
        
        let dict = ["bgColorIndex": bgColorIndex,
                    "fontIndex": fontIndex,
                    "effectIndex": effectIndex,
                    "spacingIndex": spacingIndex,
                    "progressIndex": progressIndex,
                    "fontSize": fontSize]
    
        SYUserDefaults.setObject(dict, DZM_READ_KEY_CONFIGURE)
    }
    
    
    // MARK: 构造
    
    /// 获取对象
    class func shared() -> SYReadConfigure {
        
        if configure == nil { configure = SYReadConfigure(SYUserDefaults.object(DZM_READ_KEY_CONFIGURE)) }
        
        return configure!
    }
    
    init(_ dict:Any? = nil) {
        
        super.init()
  
        if dict != nil { setValuesForKeys(dict as! [String : Any]) }
        
        initData()
    }
    
    /// 初始化配置数据,以及处理初始化数据的增删
    private func initData() {
        
        // 背景
        if (bgColorIndex == nil) || (bgColorIndex.intValue >= DZM_READ_BG_COLORS.count) {
            
            bgColorIndex = NSNumber(value: DZM_READ_BG_COLORS.index(of: DZM_COLOR_BG_0) ?? 0)
        }
        
        // 字体类型
        if (fontIndex == nil) || (DZMFontType(rawValue: fontIndex.intValue) == nil) {
            
            fontIndex = NSNumber(value: DZMFontType.two.rawValue)
        }
        
        // 间距类型
        if (spacingIndex == nil) || (DZMSpacingType(rawValue: spacingIndex.intValue) == nil) {
            
            spacingIndex = NSNumber(value: DZMSpacingType.small.rawValue)
        }
        
        // 翻页类型
        if (effectIndex == nil) || (SYEffectType(rawValue: effectIndex.intValue) == nil) {
            
            effectIndex = NSNumber(value: SYEffectType.simulation.rawValue)
        }
        
        // 字体大小
        if (fontSize == nil) || (fontSize.intValue > DZM_READ_FONT_SIZE_MAX || fontSize.intValue < DZM_READ_FONT_SIZE_MIN) {
            
            fontSize = NSNumber(value: DZM_READ_FONT_SIZE_DEFAULT)
        }
        
        // 显示进度类型
        if (progressIndex == nil) || (DZMProgressType(rawValue: progressIndex.intValue) == nil) {
            
            progressIndex = NSNumber(value: DZMProgressType.page.rawValue)
        }
    }
    
    class func model(_ dict:Any?) -> SYReadConfigure  { return SYReadConfigure(dict) }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
}
