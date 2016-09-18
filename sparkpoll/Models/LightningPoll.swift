//
//  LightningPoll.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/18/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import UIKit

class LightningPoll: NSObject {
    var uid: String
    var title: String
    var poll_description: String
    var origin_lat: Int
    var origin_lng: Int
    
    init(uid: String, title: String, description: String, origin_lat: Int, origin_lng: Int) {
        self.uid = uid
        self.title = title
        self.poll_description = description
        self.origin_lat = origin_lat
        self.origin_lng = origin_lng
    }
    convenience override init() {
        self.init(uid: "", title: "", description: "", origin_lat: 0, origin_lng: 0)
    }
}