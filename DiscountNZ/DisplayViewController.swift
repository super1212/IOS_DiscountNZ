//
//  DisplayViewController.swift
//  DiscountNZ
//
//  Created by Nancy Zhang on 21/10/17.
//  Copyright © 2017 Youfa. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var product : ProductData?

    @IBOutlet weak var nameContent: UILabel!
    
    @IBOutlet weak var addressContent: UILabel!
    
    @IBOutlet weak var brandContent: UILabel!
    
    @IBOutlet weak var priceContent: UILabel!
    
    
    @IBOutlet weak var discountImg: UIImageView!
    
    //initialize URL_IMAGE
    var URL_IMAGE = URL(string: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DisplayItem()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: false)

    }
    
    //show detail of product
    func DisplayItem() {
        nameContent?.text = product?.name
        
        addressContent?.text = product?.addr
        brandContent?.text = product?.brand
        priceContent?.text = product?.price
        
        let url = product?.imgUrl
        URL_IMAGE = URL(string: url!)
        getImageByUrl()
        
    }
    
    @IBAction func onMapClilcked(_ sender: Any) {
        showMap()
    }
    
    //pass product location to map view
    public func showMap() {
            let myProduct = product
            let viewController  = self.storyboard?.instantiateViewController(withIdentifier: "MAP") as! MapViewController
            viewController.product = myProduct
            present(viewController, animated: true, completion: nil)
        
    }

    
    
    func getImageByUrl()
    {
        activityIndicator.center = self.discountImg.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        self.discountImg.addSubview(activityIndicator)
        
        self.activityIndicator.startAnimating()
        
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
                        DispatchQueue.main.async(execute: {
                            self.activityIndicator.stopAnimating()

                            self.discountImg.image = image
                        })

                    }
                    else{
                        print("no image found")
                    }
                }
                else
                {
                    print("No response from server")
                }
                
            }
            
            
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
