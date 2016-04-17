//
//  ViewController.swift
//  Project 1 Apple
//
//  Created by Sanzid Ashan on 4/9/16.
//  Copyright © 2016 Sanzid Ashan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController {
    
    @IBOutlet weak var resbtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
      let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn");
        
        if(!isUserLoggedIn)
        {
            self.performSegueWithIdentifier("loginView", sender: self);
        }
        
        
    }
    
    
    @IBAction func logoutButtonTapped(sender: AnyObject) {
        
        NSUserDefaults.standardUserDefaults().setBool(false,forKey:"isUserLoggedIn");
        NSUserDefaults.standardUserDefaults().synchronize();
        
        self.performSegueWithIdentifier("loginView", sender: self);
        
        
    }
    
    @IBAction func maptype(sender: AnyObject) {
        
        
        if mapView.mapType == MKMapType.Standard {
            mapView.mapType = MKMapType.HybridFlyover
        } else {
            mapView.mapType = MKMapType.Standard
        }
    }
    
    func LocationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last
        
        _ = CLLocationManager()
        
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        
        //let region = MKCoordinateRegion(center: center,span:MKCoordinateSpan(latitudeDelta:0.05, longitudeDelta:0.05))
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: center, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Error: " + error.localizedDescription, terminator: "")
    }

    
    
    
    
    
    
}

