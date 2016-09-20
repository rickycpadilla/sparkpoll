//
//  JoinLightningPollViewController.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/19/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import Foundation

class JoinLightningPollViewController: UIViewController, CLLocationManagerDelegate {
    private let locManager = CLLocationManager()
    private var userLatitude: Float64 = 0
    private var userLongitude: Float64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get user location coordinates
        locManager.delegate = self
        // Getting user permission for location data
        locManager.requestAlwaysAuthorization()
        locManager.requestWhenInUseAuthorization()
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.startMonitoringSignificantLocationChanges()
        
        if locManager.location?.coordinate != nil {
            //show user location
            let userLocation:CLLocationCoordinate2D = locManager.location!.coordinate
            self.userLatitude = Float64(userLocation.latitude)
            self.userLongitude = Float64(userLocation.longitude)
            print(locManager.location)
        }
        //end location
        
        
        //PollWithinRangeHelper.instantiateFirebasePollsObservable()
        var currentPollData: [ String: AnyObject ] = [:]
        var currentPollDataWithDistance: [ String: AnyObject ] = [:]
        
        let ref: FIRDatabaseReference! = FIRDatabase.database().reference()
        ref.child("lightning_polls").observe(FIRDataEventType.value, with: { (snapshot) in
            currentPollData = snapshot.value as! [String : AnyObject]
            
            //loop through polls, lets figure out how far away they are
            for (poll_id, poll) in currentPollData {
                //get long and lat from firebase
                
                if let unwrapped = poll.value(forKey: "origin_lat") {
                    let unwrappedLatStr = String(describing: unwrapped)
                    let pollLatDouble = Double(unwrappedLatStr)
                }
                if let unwrappedLng = poll.value(forKey: "origin_lng") {
                    let unwrappedLngStr = String(describing: unwrappedLng)
                    let pollLngDouble = Double(unwrappedLngStr)
                }
//                print(pollLat, pollLng)
                
                //create location from points in firebase
//                let pollOriginLocation = CLLocation(latitude: poll.value(forKey: "origin_lat"), longitude: poll.value(forKey: "origin_lng"))
                // calculate distance between current location and poll coordinates.
//                DistanceCalculationHelper.calculateDistanceBetweenTwoPoints(point_1: locManager.location, point_2: pollOriginLocation)
                
                poll.setValue("woot", forKey: "test")
//                print("\(poll_id): \(poll.value(forKey: "origin_lat"))")
            }
            
            //            print(currentPollData)
//            print("current coordinates here", self.userLatitude, self.userLongitude )
            print("polls here", currentPollData)
        })
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
