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

    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    
    @IBAction func onZoomOut(_ sender: Any) {
        //let userLocation = map.userLocation
        //var currentRegion = map.
    
        let latitude = Double((product?.longitude)!)
        let longtitude = Double((product?.latitude)!)
        var centerLocation = CLLocationCoordinate2DMake(latitude!, longtitude!)
        let region = MKCoordinateRegionMakeWithDistance(centerLocation,20000,20000)
    
        self.map.setRegion(region, animated: true)
        
    }
    
    var product : ProductData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.showsUserLocation = true
        
        let latitude = Double((product?.longitude)!)
        let longtitude = Double((product?.latitude)!)
        
        //var centerLocation = CLLocationCoordinate2DMake(latitude: CLLocationDegrees, longtitude : CLLocationDegrees)
        
        var centerLocation = CLLocationCoordinate2DMake(latitude!, longtitude!)
        var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
        
        self.map.setRegion(mapRegion, animated: true)
        
        var pikachuPin = MKPointAnnotation()
        let pikachuCoordinates = CLLocationCoordinate2DMake(latitude!, longtitude!)
        pikachuPin.coordinate = pikachuCoordinates
        pikachuPin.title = "Pikachu"
        
        map.addAnnotation(pikachuPin)
        
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
