//
//  UICollectionGridViewCell.swift
//  DiscountNZ
//
//  Created by apple on 15/10/17.
//  Copyright © 2017年 Youfa. All rights reserved.
//


import UIKit

class UICollectionGridViewCell: UICollectionViewCell {
    
    //内容标签
    var label:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //单元格边框
        self.layer.borderWidth = 0
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        
        //添加内容标签
        self.label = UILabel(frame: .zero)
        self.label.textAlignment = .center
        self.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        
    }
    
    
}
