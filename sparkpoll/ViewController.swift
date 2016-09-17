//
//  ViewController.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/16/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    // let firebaseRoot = FIRDatabase.database().reference()
    let locManager = CLLocationManager()
    var lat = ""
    var long = ""
    
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    @IBAction func showUserLocation(_ sender: AnyObject) {
        let location:CLLocationCoordinate2D = locManager.location!.coordinate
        lat = String(location.latitude)
        long = String(location.longitude)
        
        labelLatitude.text = lat
        labelLongitude.text = long
        
        print("latHere", lat)
        print(locManager.location)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        //get user location
        func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            switch status {
            case .notDetermined:
                // If status has not yet been determied, ask for authorization
                manager.requestWhenInUseAuthorization()
                break
            case .authorizedWhenInUse:
                // If authorized when in use
                manager.startUpdatingLocation()
                break
            case .authorizedAlways:
                // If always authorized
                manager.startUpdatingLocation()
                break
            case .restricted:
                // If restricted by e.g. parental controls. User can't enable Location Services
                break
            case .denied:
                // If user denied your app access to Location Services, but can grant access from Settings.app
                break
            }
        }
        
        locManager.delegate = self
        // Getting user permission for location data
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startMonitoringSignificantLocationChanges()
        
        //show user location
        let location:CLLocationCoordinate2D = locManager.location!.coordinate
        lat = String(location.latitude)
        long = String(location.longitude)
        
        labelLatitude.text = lat
        labelLongitude.text = long
        
        print("latHere", lat)
        print(locManager.location)


    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

