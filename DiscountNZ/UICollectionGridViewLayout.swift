//
//  UICollectionGridViewLayout.swift
//  DiscountNZ
//
//  Created by apple on 15/10/17.
//  Copyright © 2017年 Youfa. All rights reserved.
//

import Foundation
import UIKit


class UICollectionGridViewLayout: UICollectionViewLayout {
    //save the attributes of every item
    private var itemAttributes: [[UICollectionViewLayoutAttributes]] = []
    private var itemsSize: [NSValue] = []
    private var contentSize: CGSize = CGSize.zero
    //controller of view
    var viewController: UICollectionGridViewController!
    
    //prepare all of layoutAttributes in view
    override func prepare() {
        if collectionView!.numberOfSections == 0 {
            return
        }
        
        var column = 0
        var xOffset: CGFloat = 0
        var yOffset: CGFloat = 0
        var contentWidth: CGFloat = 0
        var contentHeight: CGFloat = 0
        
        if itemAttributes.count > 0 {
            return
        }
        
        itemAttributes = []
        itemsSize = []
        
        if itemsSize.count != viewController.cols.count {
            calculateItemsSize()
        }
        
        for section in 0 ..< (collectionView?.numberOfSections)! {
            var sectionAttributes: [UICollectionViewLayoutAttributes] = []
            for index in 0 ..< viewController.cols.count {
                let itemSize = itemsSize[index].cgSizeValue
                
                let indexPath = IndexPath(item: index, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
                if index == 0{
                    attributes.frame = CGRect(x:xOffset, y:yOffset, width:itemSize.width,
                                              height:itemSize.height).integral
                }else {
                    attributes.frame = CGRect(x:xOffset-1, y:yOffset,
                                              width:itemSize.width+1,
                                              height:itemSize.height).integral
                }
                
                sectionAttributes.append(attributes)
                
                xOffset = xOffset+itemSize.width
                column += 1
                
                if column == viewController.cols.count {
                    if xOffset > contentWidth {
                        contentWidth = xOffset
                    }
                    
                    column = 0
                    xOffset = 0
                    yOffset += itemSize.height
                }
            }
            itemAttributes.append(sectionAttributes)
        }
        
        let attributes = itemAttributes.last!.last! as UICollectionViewLayoutAttributes
        contentHeight = attributes.frame.origin.y + attributes.frame.size.height
        contentSize = CGSize(width:contentWidth, height:contentHeight)
    }
    
    //update layout
    override func invalidateLayout() {
        itemAttributes = []
        itemsSize = []
        contentSize = CGSize.zero
        super.invalidateLayout()
    }
    
    // get content size
    override var collectionViewContentSize: CGSize {
        get {
            return contentSize
        }
    }
    
    // get the cells index information
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return itemAttributes[indexPath.section][indexPath.row]
    }
    
    // get all of cell's attributes
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var attributes: [UICollectionViewLayoutAttributes] = []
            for section in itemAttributes {
                attributes.append(contentsOf: section.filter(
                    {(includeElement: UICollectionViewLayoutAttributes) -> Bool in
                        return rect.intersects(includeElement.frame)
                }))
            }
            return attributes
    }
    
    //reinit when the width change
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        let oldBounds = self.collectionView?.bounds
        if oldBounds!.width != newBounds.width {
            return true
        }else {
            return false
        }
    }
    
    //calculate the size of all cells
    func calculateItemsSize() {
        var remainingWidth = collectionView!.frame.width -
            collectionView!.contentInset.left - collectionView!.contentInset.right
        
        var index = viewController.cols.count-1
        while index >= 0 {
            let newItemSize = sizeForItemWithColumnIndex(columnIndex: index,
                                                         remainingWidth: remainingWidth)
            remainingWidth -= newItemSize.width
            let newItemSizeValue = NSValue(cgSize: newItemSize)
            itemsSize.insert(newItemSizeValue, at: 0)
            index -= 1
        }
    }
    
    //caculate size of a row
    func sizeForItemWithColumnIndex(columnIndex: Int, remainingWidth: CGFloat) -> CGSize {
        let columnString = viewController.cols[columnIndex]
        //get the width of a row from header
        let size = NSString(string: columnString).size(attributes: [
            NSFontAttributeName:UIFont.systemFont(ofSize: 15),
            NSUnderlineStyleAttributeName:NSUnderlineStyle.styleSingle.rawValue
            ])
        
        //give every cell a average width
        let width = max(remainingWidth/CGFloat(columnIndex+1), 80)
        return CGSize(width: ceil(width), height:size.height + 10)
    }
}
