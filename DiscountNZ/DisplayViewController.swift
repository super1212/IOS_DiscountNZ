//
//  DisplayViewController.swift
//  DiscountNZ
//
//  Created by Nancy Zhang on 21/10/17.
//  Copyright © 2017 Youfa. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    var product : ProductData?

    @IBOutlet weak var addressContent: UILabel!
    
    @IBOutlet weak var brandContent: UILabel!
    
    @IBOutlet weak var priceContent: UILabel!
    
    
    @IBOutlet weak var discountImg: UIImageView!
    
    //let URL_IMAGE = URL(string: product.imgUrl)
    var URL_IMAGE = URL(string: "http://www.kaleidosblog.com/tutorial/image.jpg")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DisplayItem()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: false)

    }
    
    func DisplayItem() {
        addressContent?.text = product?.addr
        //addressContent?.text = "newlynn"
        brandContent?.text = product?.brand
        //brandContent?.text = "countdown"
        priceContent?.text = product?.price
        //priceContent?.text = "5.5"
        
        let url = product?.imgUrl
        URL_IMAGE = URL(string: url!)
        
        getImageByUrl()
        
    }
    
    /*
    func get_image(_url_str:String, _imageView:UIImageView)
    {
        let url:URL = URL(string:_url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url,completionHandler:{
        (data, response, error) in
            if (data==nil)
            {}
            else
            {
                let image = UIImage(data: data!)
                if(image != nil)
                {
                    DispatchQueue.main.async(execute:{
                        _imageView.image = image
                    })
                    
                }
            }
        })
        task.resume()
    }
 */

    
    func getImageByUrl()
    {
        let session = URLSession(configuration: .default)
    
        
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!){(data, response, error) in
            
            if let e = error{
                print("Some error occurred: \(e)")
            }
            else{
                if(response as? HTTPURLResponse) != nil
                {
                    if let imageData = data{
                    
                        let image = UIImage(data: imageData)
                        
                        self.discountImg.image = image
                    }
                    else{
                        print("no image found")
                    }
                }
                else
                {
                    print("No response from server")
                }
                
                print("222222")
            }
            
            print("33333")
            
       }
        
       getImageFromUrl.resume()
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
