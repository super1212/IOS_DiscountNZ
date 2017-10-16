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

        }
    }
    
    required init?(coder aDecoder: NSCoder) {
//        self.name = aDecoder.decodeObject(forKey: "name") as! NSString as String
//        self.price = aDecoder.decodeObject(forKey: "price") as! NSString as String

    }
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(self.price, forKey: "price")

    }
    
//    var headImgUrlStr:String?
//    var email:String?
//    var address:String?
}
