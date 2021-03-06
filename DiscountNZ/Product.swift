//
//  Product.swift
//  DiscountNZ
//
//  Created by apple on 14/10/17.
//  Copyright © 2017年 Youfa. All rights reserved.
//

import Foundation
class ProductData: NSObject,NSCoding {

    
    var name:String?
    var price:String?
    var brand:String?
    var category:String?
    var startDate:String?
    var endDate:String?
    var addr:String?
    var longitude:String?
    var latitude:String?
    var imgUrl:String?

    
    init(json: Dictionary<String,Any>){
        if(json != nil){
            self.name = json["name"]! as? String
            self.price = json["price"]! as? String
            self.brand = json["brand"]! as? String
            self.addr = json["addr"]! as? String
            self.longitude = json["longitude"]! as? String
            self.latitude = json["latitude"]! as? String
            self.category = json["category"]! as? String
            self.startDate = json["startDate"]! as? String
            self.endDate = json["endDate"]! as? String
            self.imgUrl = json["imgUrl"]! as? String

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
    }
    func encode(with aCoder: NSCoder) {

    }
}
