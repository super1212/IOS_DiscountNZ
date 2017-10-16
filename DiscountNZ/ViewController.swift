//
//  ViewController.swift
//  DiscountNZ
//
//  Created by apple on 14/10/17.
//  Copyright © 2017年 Youfa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var productList : [ProductData] = []
    var allProductList : [ProductData] = []
    var categoryList : [String] = []
    var brandList : [String] = []
    var dateList = ["Today", "Tomorrow", "This Week", "Next Week"]
    var gridViewController: UICollectionGridViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        gridViewController = UICollectionGridViewController()
        gridViewController.setParentController(parent: self)
        getProductData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewDidLayoutSubviews() {
        gridViewController.view.frame = CGRect(x:0, y:50, width:view.frame.width,
                                               height:view.frame.height-60)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func showGridData(){
        
        gridViewController.setColumns(columns: ["Index", "Name", "Price", "Brand"])
        for i in 0..<self.productList.count{
            let product = productList[i]
            gridViewController.addRow(row: [(i+1), product.name!, product.price!, product.brand!])
        }
        DispatchQueue.main.async {
            self.view.addSubview(self.gridViewController.view)
        }
    }
    //show detail of product
    public func showDetails(indexPath: IndexPath) {
        var index = indexPath.section
        if(index > 0){
            var myProduct = productList[index - 1]
            let viewController  = self.storyboard?.instantiateViewController(withIdentifier: "HH") as! UIViewController
//            viewController.product = myProduct
            present(viewController, animated: true, completion: nil)
        }
    }
    
    
    func getProductData(){
        //product list, save all of the product
//        var productList : [ProductData] = []
        //product data url
        let url: NSURL = NSURL(string: "https://gist.githubusercontent.com/youfa/4829473802dfe85d6b2d230863378afc/raw/20989ed0c0d5559d8e843ac9198bcbcf6f35e34d/DiscountInfo")!
        //creata request object
        let request: NSURLRequest = NSURLRequest(url: url as URL)
        
        //get session
        let session: URLSession = URLSession.shared
        /*
         @param request, my request
         @param my callback function
         data: data from responsed server
         response:
         error: information about error
         */
        var dataTask: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if(error == nil){
                do {
                    //Serialize  data to jsonObject
                    let jsonData:Any = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers)
                    let jsonDic = jsonData as!Dictionary<String,Any>
                    //get data from the key of "data"
                    let datalist = jsonDic["data"] as! NSArray
                    //do loop, get product list
                    for json in datalist {
                        let productJson = json as! Dictionary<String,Any>
                        let product = ProductData(json: productJson)
                        self.allProductList.append(product)
                        self.productList.append(product)
                        
                        if !self.categoryList.contains(productJson["category"]! as! String) {
                            self.categoryList.append(productJson["category"]! as! String)
                        }
                        if !self.brandList.contains(productJson["brand"]! as! String) {
                            self.brandList.append(productJson["brand"]! as! String)
                        }
                    }
                    self.showGridData()

                } catch{
                    print("Error: Check the product data from URL.")
                    
                }
            }
        }
        //run task
        dataTask.resume()
    }
}

