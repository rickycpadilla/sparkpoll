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
    
    @IBOutlet weak var labelLatitude: UILabel!
    @IBOutlet weak var labelLongitude: UILabel!
    
    @IBAction func showUserLocation(_ sender: AnyObject) {
        print(locManager.location)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
        //get user location
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestAlwaysAuthorization()
        locManager.startMonitoringSignificantLocationChanges()
        
        // check if authorization was granted
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways)
        {
            print(locManager.location)
            // let latitude = locManager.location.coordinate.latitude
            // let longitude = locManager.location.coordinate.longitude
            
        } else {
            labelLatitude.text = "Location not authorized"
            labelLongitude.text = "Location not authorized"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

