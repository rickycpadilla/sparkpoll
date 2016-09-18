//
//  BinaryQuestion.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/18/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import UIKit

class BinaryQuestion: NSObject {
    var uid: String
    var question_title: String
    var question_type: String
    var option_1: String
    var option_2: String
    
    init(uid: String, question_title: String, question_type: String, option_1: String, option_2: String){
        self.uid = uid
        self.question_title = question_title
        self.question_type = question_type
        self.option_1 = option_1
        self.option_2 = option_2
    }
    convenience override init() {
        self.init(uid: "", question_title: "", question_type: "", option_1: "", option_2: "")
    }
}
