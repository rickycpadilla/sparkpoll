//
//  JoinLightningPollViewController.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/19/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import Firebase

class JoinLightningPollViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //PollWithinRangeHelper.instantiateFirebasePollsObservable()
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
