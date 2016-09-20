//
//  DictonaryMapExtension.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/19/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func map(transform: (_ key:KeyType, _ value:ValueType) -> (newValue:ValueType)) {
        for key in self.keys {
            var newValue = transform(key: key, value: self[key]!)
            self.updateValue(newValue, forKey: key)
        }
    }
}
