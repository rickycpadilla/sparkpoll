//
//  Trim.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/18/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation

extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
