//
//  MapViewController.swift
//  DiscountNZ
//
//  Created by Nancy Zhang on 1/11/17.
//  Copyright © 2017 Youfa. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var map: MKMapView!

    var product : ProductData?

    override func viewDidLoad() {
        super.viewDidLoad()
        let latitude = -27.4
        let longtitude = 153.1
        
        //var centerLocation = CLLocationCoordinate2DMake(latitude: CLLocationDegrees, longtitude : CLLocationDegrees)
        
        var centerLocation = CLLocationCoordinate2DMake(latitude, longtitude)
        var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
        
        self.map.setRegion(mapRegion, animated: true)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
