//
//  SYRMProgressView.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/08/11.
//  Copyright © 2020年 Mandora. All rights reserved.
//

import UIKit

class SYRMProgressView: SYRMBaseView,ASValueTrackingSliderDelegate,ASValueTrackingSliderDataSource {
    
    /// 进度
    private var slider:ASValueTrackingSlider!
    
    override init(frame: CGRect) { super.init(frame: frame) }
    
    override func setupUI() {
        
        super.setupUI()
        
        backgroundColor = UIColor.clear
        
        // 进度条
        slider = ASValueTrackingSlider()
        slider.delegate = self
        slider.dataSource = self
        slider.setThumbImage(R.image.reading_slider_thumb()!.withRenderingMode(.alwaysTemplate), for: .normal)
        // 设置显示进度保留几位小数 (由于重写了 dataSource 则不用不到该属性了)
        // slider.setMaxFractionDigitsDisplayed(0)
        // 设置气泡背景颜色
        slider.popUpViewColor = UIColor(244, 202, 28)
        // 设置气泡字体颜色
        slider.textColor = UIColor(238, 238, 238)
        // 设置气泡字体以及字体大小
        slider.font = UIFont(name: "Futura-CondensedExtraBold", size: 22)
        // 设置气泡箭头高度
        slider.popUpViewArrowLength = 5
        // 设置当前进度颜色
        slider.minimumTrackTintColor = UIColor(244, 202, 28)
        // 设置总进度颜色
        slider.maximumTrackTintColor = UIColor(238, 238, 238)
        // 设置当前拖拽圆圈颜色
        slider.tintColor = UIColor(244, 202, 28)
        addSubview(slider)
        reloadProgress()
    }
    
    /// 刷新阅读进度显示
    func reloadProgress() {
       
        // 有阅读数据
        let readModel = readMenu.vc.readModel
        
        // 有阅读记录以及章节数据
        if readModel != nil && (readModel?.recordModel?.chapterModel != nil) {
            
            if SYReadConfigure.shared().progressType == .total { // 总进度
                
                slider.minimumValue = 0
                slider.maximumValue = 1
                slider.value = DZM_READ_TOTAL_PROGRESS(readModel: readModel, recordModel: readModel?.recordModel)
                
            }else{ // 分页进度
                
                slider.minimumValue = 1
                slider.maximumValue = readModel!.recordModel.chapterModel.pageCount.floatValue
                slider.value = readModel!.recordModel.page.floatValue + 1
            }
            
        }else{ // 没有则清空
            
            slider.minimumValue = 0
            slider.maximumValue = 0
            slider.value = 0
        }
    }
    
    // MARK: ASValueTrackingSliderDataSource
    
    func slider(_ slider: ASValueTrackingSlider!, stringForValue value: Float) -> String! {
        
        if SYReadConfigure.shared().progressType == .total { // 总进度
            
            // 如果有需求可显示章节名
            return SY_READ_TOTAL_PROGRESS_STRING(progress: value)
            
        } else { // 分页进度
            
            return "\(NSInteger(value))"
        }
    }
    
    // MARK: -- ASValueTrackingSliderDelegate
    
    /// 进度显示将要显示
    func sliderWillDisplayPopUpView(_ slider: ASValueTrackingSlider!) { }

    /// 进度显示将要隐藏
    func sliderWillHidePopUpView(_ slider: ASValueTrackingSlider!) {
  
        if SYReadConfigure.shared().progressType == .total { // 总进度
            
            // 有阅读数据
            let readModel = readMenu.vc.readModel
            
            // 有阅读记录以及章节数据
            if readModel != nil && (readModel?.recordModel?.chapterModel != nil) {
                
                // 总章节个数
                let count = (readModel!.chapterListModels.count - 1)
                
                // 获得当前进度的章节索引
                let index = NSInteger(Float(count) * slider.value)
                
                // 获得章节列表模型
                let chapterListModel = readModel!.chapterListModels[index]
                
                // 页码
                let toPage = (index == count) ? DZM_READ_LAST_PAGE : 0
                
                // 传递
                readMenu?.delegate?.readMenuDraggingProgress?(readMenu: readMenu, toChapterID: chapterListModel.id, toPage: toPage)
            }
            
        }else{ // 分页进度
            
            readMenu?.delegate?.readMenuDraggingProgress?(readMenu: readMenu, toPage: NSInteger(slider.value - 1))
        }
    }
    
    override func setupConstraints() {
        slider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
