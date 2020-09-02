//
//  SYAlignFlowLayout.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/8/19.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit

/// 对齐方式
enum AlignType : NSInteger {
    case left = 0
    case center = 1
    case right = 2
}

class SYAlignFlowLayout: UICollectionViewFlowLayout {
    
    /// 两个Cell之间的距离
    var cellDistance: CGFloat {
        didSet {
            self.minimumInteritemSpacing = cellDistance
        }
    }
    
    var direction: UICollectionView.ScrollDirection {
        didSet {
            self.scrollDirection = direction
        }
    }
    
    /// cell对齐方式
    var cellType: AlignType = AlignType.center
    
    //在居中对齐的时候需要知道这行所有cell的宽度总和
    var sumCellWidth : CGFloat = 0.0
    
    override init() {
        cellDistance = 5.0
        direction = .vertical
        super.init()
        scrollDirection = .vertical
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    convenience init(_ cellType:AlignType) {
        self.init()
        self.cellType = cellType
    }
    
    convenience init(_ cellType: AlignType, _ cellDistance: CGFloat){
        self.init()
        self.cellType = cellType
        self.cellDistance = cellDistance
    }
    
    required init?(coder aDecoder: NSCoder) {
        cellDistance = 5.0
        direction = .vertical
        super.init(coder: aDecoder)
        minimumLineSpacing = 5
        sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes_super: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElements(in: rect) ?? [UICollectionViewLayoutAttributes]()
        let layoutAttributes: [UICollectionViewLayoutAttributes] = NSArray(array: layoutAttributes_super, copyItems:true) as! [UICollectionViewLayoutAttributes]
        var layoutAttributes_t: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        
        for index in 0 ..< layoutAttributes.count {
            let currentAttr = layoutAttributes[index]
            let previousAttr = index == 0 ? nil : layoutAttributes[index-1]
            let nextAttr = index + 1 == layoutAttributes.count ?
                nil : layoutAttributes[index+1]
            
            layoutAttributes_t.append(currentAttr)
            sumCellWidth += currentAttr.frame.size.width
            
            let previousY :CGFloat = previousAttr == nil ? 0 : previousAttr!.frame.maxY
            let currentY :CGFloat = currentAttr.frame.maxY
            let nextY:CGFloat = nextAttr == nil ? 0 : nextAttr!.frame.maxY
            
            if currentY != previousY && currentY != nextY{
                if currentAttr.representedElementKind == UICollectionView.elementKindSectionHeader {
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                } else if currentAttr.representedElementKind == UICollectionView.elementKindSectionFooter {
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                } else {
                    self.setCellFrame(with: layoutAttributes_t)
                    layoutAttributes_t.removeAll()
                    sumCellWidth = 0.0
                }
            } else if currentY != nextY {
                self.setCellFrame(with: layoutAttributes_t)
                layoutAttributes_t.removeAll()
                sumCellWidth = 0.0
            }
        }
        return layoutAttributes
    }
    
    /// 调整Cell的Frame
    ///
    /// - Parameter layoutAttributes: layoutAttribute 数组
    func setCellFrame(with layoutAttributes : [UICollectionViewLayoutAttributes]){
        var nowWidth : CGFloat = 0.0
        switch cellType {
        case AlignType.left:
            nowWidth = self.sectionInset.left
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.cellDistance
            }
            break;
        case AlignType.center:
            nowWidth = (self.collectionView!.frame.size.width - sumCellWidth - (CGFloat(layoutAttributes.count - 1) * cellDistance)) / 2
            for attributes in layoutAttributes{
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth
                attributes.frame = nowFrame
                nowWidth += nowFrame.size.width + self.cellDistance
            }
            break;
        case AlignType.right:
            nowWidth = self.collectionView!.frame.size.width - self.sectionInset.right
            for var index in 0 ..< layoutAttributes.count{
                index = layoutAttributes.count - 1 - index
                let attributes = layoutAttributes[index]
                var nowFrame = attributes.frame
                nowFrame.origin.x = nowWidth - nowFrame.size.width
                attributes.frame = nowFrame
                nowWidth = nowWidth - nowFrame.size.width - cellDistance
            }
            break;
        }
    }
}
