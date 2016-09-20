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
    private var pollLatDouble: Float64 = 0
    private var pollLngDouble: Float64 = 0
    
    @IBOutlet weak var pollCount: UILabel!
    @IBOutlet weak var pollTitle: UILabel!
    @IBOutlet weak var pollDistance: UILabel!
    @IBOutlet weak var pollOption1: UILabel!
    @IBOutlet weak var pollOption2: UILabel!
    
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
        var currentPollDataWithRange: [ String: AnyObject ] = [:]
        
        let ref: FIRDatabaseReference! = FIRDatabase.database().reference()
        ref.child("lightning_polls").observe(FIRDataEventType.value, with: { (snapshot) in
            currentPollData = snapshot.value as! [String : AnyObject]
            //loop through polls, lets figure out how far away they are
            for (poll_id, poll) in currentPollData {
                //get long and lat from firebase
                if let unwrapped = poll.value(forKey: "origin_lat") {
                    let unwrappedLatStr = String(describing: unwrapped)
                    self.pollLatDouble = Double(unwrappedLatStr)!
                }
                if let unwrappedLng = poll.value(forKey: "origin_lng") {
                    let unwrappedLngStr = String(describing: unwrappedLng)
                    self.pollLngDouble = Double(unwrappedLngStr)!
                }
                //create location from points in firebase
                let pollOriginLocation = CLLocation(latitude: self.pollLatDouble, longitude: self.pollLngDouble)
                // calculate distance between current location and poll coordinates.
                let distance = DistanceCalculationHelper.calculateDistanceBetweenTwoPoints(point_1: self.locManager.location!, point_2: pollOriginLocation)
                // range here
                print("distance here", distance)
                if (distance > 100) {
                    currentPollData.removeValue(forKey: poll_id)
                }
                poll.setValue(distance, forKey: "client_distance")
                
//                print("\(poll_id): \(poll.value(forKey: "origin_lat"))")
            }
            
            // attempt to set label text
            self.pollCount.text = String(currentPollData.count)
            
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
