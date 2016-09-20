//
//  PollsWithinRangeHelper.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/19/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


class PollWithinRangeHelper {
    static func instantiateFirebasePollsObservable() {
        var currentPollData: [ String: AnyObject ] = [:]
        var currentPollDataWithDistance: [ String: AnyObject ] = [:]
        
        let ref: FIRDatabaseReference! = FIRDatabase.database().reference()
        ref.child("lightning_polls").observe(FIRDataEventType.value, with: { (snapshot) in
            currentPollData = snapshot.value as! [String : AnyObject]
            for (poll_id, poll) in currentPollData {
                
                // calculate distance between current location and poll coordinates.
                
                poll.setValue("woot", forKey: "test")
//                print("\(poll_id): \(poll.value(forKey: "origin_lat"))")
            }
            
//            print(currentPollData)
            
            print("polls here", currentPollData)
        })
    }
//    private func _distanceFromPoll(poll: AnyObject) -> AnyObject {
//        
//    }
}
