// 
//  Color.swift
//  DiscountNZ
//
//  Created by apple on 15/10/17.
//  Copyright © 2017年 Youfa. All rights reserved.
//

import UIKit

extension UIColor
{
    class var transparentGreen : UIColor
    {
        return UIColor(red: 0, green: 255/255, blue: 0, alpha: 0.5)
    }
    
    class var transparentBlue : UIColor
    {
        return UIColor(red: 0, green: 0, blue: 255/255, alpha: 0.5)
    }
    
    class var transparentRed: UIColor
    {
        return UIColor (red: 255/255, green: 0, blue: 0, alpha: 0.5)
    }
    
    class var transparentPurple: UIColor
    {
        return UIColor (red: 255/255, green: 0, blue: 255/255, alpha: 0.5)
    }
    
    class var transparentYellow: UIColor
    {
        return UIColor (red: 255/255, green: 255/255, blue: 0, alpha: 0.5)
    }
    
    class var transparentOrange: UIColor
    {
        return UIColor (red: 255/255, green: 165/255, blue: 0, alpha: 0.5)
    }
    
    class var transparentCyan: UIColor
    {
        return UIColor (red: 0, green: 255/255, blue: 255/255, alpha: 0.5)
    }
    
    class var transparentWhite: UIColor
    {
        return UIColor (red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
    }
    
    class var transparentLightYellow: UIColor
    {
        return UIColor (red: 240/255, green: 230/255, blue: 140/255, alpha: 1)
    }
    
    class var transparentGray: UIColor
    {
        return UIColor (red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    }
    
    class var veryDarkGreen: UIColor
    {
        return UIColor.rgb(fromHex: 0x008110)
    }
    
    class func rgb(fromHex: Int) -> UIColor
    {
        
        let red =   CGFloat((fromHex & 0xFF0000) >> 16) / 0xFF
        let green = CGFloat((fromHex & 0x00FF00) >> 8) / 0xFF
        let blue =  CGFloat(fromHex & 0x0000FF) / 0xFF
        let alpha = CGFloat(1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
