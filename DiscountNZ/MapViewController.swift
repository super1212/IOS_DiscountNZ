//
//  MapViewController.swift
//  DiscountNZ
//
//  Created by Nancy Zhang on 1/11/17.
//  Copyright © 2017 Youfa. All rights reserved.
//

import UIKit
import MapKit

import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
    }
    @IBOutlet weak var map: MKMapView!
    var scale = 2000

    @IBAction func onClickBack(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func onChangeType(_ sender: Any) {
        /*
        if map.mapType == MKMapType.standard{
            map.mapType = MKMapType.satellite
        }
        else{
            map.mapType = MKMapType.standard
        }
        */
    }
    
    @IBAction func onZoomOut(_ sender: Any) {
        //let userLocation = map.userLocation
        //var currentRegion = map.
        
        /*
        if scale < 20000{
            scale = scale*2
        }
        
        let latitude = Double((product?.longitude)!)
        let longtitude = Double((product?.latitude)!)
        var centerLocation = CLLocationCoordinate2DMake(latitude!, longtitude!)
        let region = MKCoordinateRegionMakeWithDistance(centerLocation,CLLocationDistance(scale),CLLocationDistance(scale))
    
        self.map.setRegion(region, animated: true)
        
        */
        
    }
    
    var product : ProductData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
        
        let latitude = Double((product?.longitude)!)
        let longtitude = Double((product?.latitude)!)
        
        var centerLocation = CLLocationCoordinate2DMake(latitude!, longtitude!)
        var mapSpan = MKCoordinateSpanMake(0.01, 0.01)
        
        var mapRegion = MKCoordinateRegionMake(centerLocation, mapSpan)
        
        self.map.setRegion(mapRegion, animated: true)
        
        var pikachuPin = MKPointAnnotation()
        let pikachuCoordinates = CLLocationCoordinate2DMake(latitude!, longtitude!)
        pikachuPin.coordinate = pikachuCoordinates
        //pikachuPin.title = "Pikachu"
        pikachuPin.title = product?.brand
        
        map.addAnnotation(pikachuPin)
        
        self.map.showsUserLocation = true
        
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
