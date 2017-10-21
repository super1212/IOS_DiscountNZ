//
//  ViewController.swift
//  DiscountNZ
//
//  Created by apple on 14/10/17.
//  Copyright © 2017年 Youfa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    var productList : [ProductData] = []
    var allProductList : [ProductData] = []
    var categoryList : [String] = ["All Category"]
    var brandList : [String] = ["All Brand"]
    var dateList = ["All Date", "Today", "Tomorrow", "This Week", "Next Week"]
    var gridViewController: UICollectionGridViewController!

    var currentList = Array<String>();
    var pickerView:UIPickerView!
    var currentTextField : UITextField?

    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var brandTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        gridViewController = UICollectionGridViewController()
        gridViewController.setParentController(parent: self)
        getProductData()
        resetTextField()

//        self.systemLayoutFittingSizeDidChange(forChildContentContainer: <#T##UIContentContainer#>)
//        UIDeviceOrientationIsLandscape(<#T##orientation: UIDeviceOrientation##UIDeviceOrientation#>)
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewDidLayoutSubviews() {
        gridViewController.view.frame = CGRect(x:0, y:50, width:view.frame.width,
                                               height:view.frame.height-60)
    }
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        resetTextField()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetTextField(){
        let textFwidth = Double(self.view.frame.width/3)
        let textFheight = 20.00
        let boderWidth = 0.5
        self.categoryTextField.frame = CGRect(x:0.00, y:textFheight, width:textFwidth, height:30).integral
        self.brandTextField.frame = CGRect(x:textFwidth, y: textFheight, width:textFwidth, height:30).integral
        self.dateTextField.frame = CGRect(x:textFwidth*2, y: textFheight, width:textFwidth, height:30).integral
        
        let bgColor = UIColor.darkGray;
        self.categoryTextField.layer.borderColor = bgColor.cgColor
        self.brandTextField.layer.borderColor = bgColor.cgColor
        self.dateTextField.layer.borderColor = bgColor.cgColor
        self.categoryTextField.layer.borderWidth = CGFloat(boderWidth)
        self.brandTextField.layer.borderWidth = CGFloat(boderWidth)
        self.dateTextField.layer.borderWidth = CGFloat(boderWidth)

    }

    func showGridData(){
        gridViewController = UICollectionGridViewController()
        gridViewController.setParentController(parent: self)
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
        let index = indexPath.section
        if(index > 0){
            let myProduct = productList[index - 1]
            let viewController  = self.storyboard?.instantiateViewController(withIdentifier: "HH") as! UIViewController
            //viewController.product = myProduct
            present(viewController, animated: true, completion: nil)
        }
    }
    
    
    func getProductData(){
        //product list, save all of the product
//        var productList : [ProductData] = []
        //product data url
        let url: NSURL = NSURL(string: "https://gist.githubusercontent.com/super1212/d0a3131282534ebe60b581b8a7f7be1f/raw/products.json")!
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
        let dataTask: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
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
    
    func filterData(){
        let categoryStr = self.categoryTextField.text
        let brandStr = self.brandTextField.text
        let dateStr = self.dateTextField.text
        self.productList = []
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYY-MM-dd"

        for item in allProductList{
            if(!(categoryStr?.isEmpty)! && categoryStr != item.category){
                continue
            }
            if(!(brandStr?.isEmpty)! && brandStr != item.brand){
                continue
            }
            if(!(dateStr?.isEmpty)!){
                
                let startDate = dateformatter.date(from: item.startDate!)
                let endDate = dateformatter.date(from: item.endDate!)
                if(dateStr == "Today"){
                    let today = Date()
                    if(today.compare(startDate!) == .orderedAscending || endDate?.compare(today) == .orderedAscending){
                        continue
                    }
                }
                
                if(dateStr == "Tomorrow"){
                    var today = Date()
                    today = Calendar.current.date(byAdding: .day, value: 1, to: today)!
                    if(today.compare(startDate!) == .orderedAscending || endDate?.compare(today) == .orderedAscending){
                        continue
                    }
                }
                if(dateStr == "This Week"){
                    let today = Date()
                    let lastday = Calendar.current.date(byAdding: .day, value: 7, to: today)!
                    if(endDate?.compare(today) == .orderedAscending || lastday.compare(startDate!) == .orderedAscending){
                        continue
                    }
                }
                
                if(dateStr == "Next Week"){
                    let today = Date()
                    let fromday = Calendar.current.date(byAdding: .day, value: 7, to: today)!
                    let lastday = Calendar.current.date(byAdding: .day, value: 14, to: today)!
                    if(endDate?.compare(fromday) == .orderedAscending || lastday.compare(startDate!) == .orderedAscending){
                        continue
                    }
                }
            }
            productList.append(item)
        }
    }
    
    /*
     *From the type of selected textfield, show pickerview in alertController
     */
    @IBAction func SelectInfoPick(_ sender: UITextField) {
        var myTitle : String = "";
        //check type of the textfield
        if(sender.restorationIdentifier == "category"){
            currentList = categoryList;
            myTitle = "Select Category"
        }else if(sender.restorationIdentifier == "brand"){
            currentList = brandList;
            myTitle = "Select Brand";
        }else if(sender.restorationIdentifier == "date"){
            currentList = dateList;
            myTitle = "Select Date";
        }
        //let the textfield get the focus, and then lose focus, this is because this event is base on "touch down", then  when after choosing option, the focus will still on the last one
        sender.becomeFirstResponder()
        sender.resignFirstResponder()
        
        //defalut UIPickerView
        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(0,inComponent:0,animated:true)
        //create a alertController
        let alertController:UIAlertController=UIAlertController(title: myTitle + "\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        //add an action  of OK to alertcontroller, then click it save the value of current
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default){
            (alertAction)->Void in
            sender.text = self.currentList[self.pickerView.selectedRow(inComponent: 0)]
            if(sender.text == "All Category" || sender.text == "All Brand" || sender.text == "All Date"){
                sender.text = ""
            }
            self.filterData()
            self.showGridData()
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel,handler:nil))
        //set the width, height of pickerView
        pickerView.frame = CGRect(x: 10, y: 0, width: 250, height: 200)
        //add pickerView to alertController
        alertController.view.addSubview(pickerView)
        //show
        self.present(alertController, animated: true, completion: nil)
    }
    //set the column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //set the number of result, it comes from the currentList
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return currentList.count
    }
    //set current items
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return currentList[row]
    }

}

