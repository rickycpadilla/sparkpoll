//
//  BinaryAnswer.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/18/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import UIKit

class BinaryAnswer: NSObject {
    var option_selected: String
    
    init(option_selected: String) {
        self.option_selected = option_selected
    }
    
    convenience override init() {
        self.init(option_selected:  "")
    }
}
