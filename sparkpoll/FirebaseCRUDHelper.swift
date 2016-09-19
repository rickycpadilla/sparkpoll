//
//  FirebaseCRUDHelper.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/19/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCRUDHelper {
    let firebaseRootRef = FIRDatabase.database().reference()

    static func writeNewLightningPoll(userID: String, title: String, poll_description: String, origin_lat: Float64, origin_lng: Float64, is_open: Bool, option_1: String, option_2: String) {
        let firebaseRootRef = FIRDatabase.database().reference()
        // attempting to create a new lightning poll on firebase
        let key = firebaseRootRef.child("lightning_polls").childByAutoId().key
        let lightning_poll = [
            "uid": userID,
            "title": title,
            "poll_description": poll_description,
            "origin_lat": origin_lat,
            "origin_lng": origin_lng,
            "is_open": is_open,
            "option_1": option_1,
            "option_2": option_2
            ] as [String : Any]
        let childUpdates = ["/lightning_polls/\(key)": lightning_poll]
        firebaseRootRef.updateChildValues(childUpdates)
        print("key here", key)
    }
    func writeNewLightningPollBinaryAnswer(){
    
    }
    
//    static func writeNewLightningPollBinaryQuestion(lightning_poll_id: String, title: String, option_1: String, option_2: String){
//        let firebaseRootRef = FIRDatabase.database().reference()
//        // attempting to create a reference back to lightning poll
//        var lightningPollKey = ""
//        var ref: FIRDatabaseReference = FIRDatabase.database().reference()
//        var lightningPollRef = ref.child("lightning_polls").child(lightning_poll_id)
//        
//        
//        
//        // attempting to create a new lightning poll answer on firebase
//        let key = firebaseRootRef.child("lightning_poll_questions").childByAutoId().key
//        let lightning_poll_question = [
//            "lightning_poll_id": lightning_poll_id,
//            "title": title,
//            "option_1": option_1,
//            "option_2": option_2
//            ] as [String : Any]
//        let childUpdates = ["/lightning_poll_questions/\(key)": lightning_poll_question]
//        firebaseRootRef.updateChildValues(childUpdates)
//    }
}
