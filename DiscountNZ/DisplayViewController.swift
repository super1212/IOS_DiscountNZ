//
//  DisplayViewController.swift
//  DiscountNZ
//
//  Created by Nancy Zhang on 21/10/17.
//  Copyright © 2017 Youfa. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet weak var addressContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DisplayItem()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DisplayItem() {
        //addressCotent?.text = product?.addr
        addressContent?.text = "newlynn"
        //brandCotent?.text = product?.brand
        //brandCotent?.text = "countdown"
        //priceContent?.text = product?.price
        //priceContent?.text = "5.5"
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
