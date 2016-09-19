//
//  LightningPollSpeechHelper.swift
//  sparkpoll
//
//  Created by Alexander Murphy on 9/18/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import UIKit

class LightningPollSpeechHelper {
    static func parseUserSpeechToLightningPoll(userSpeech: String) -> [String] {
        
        // keywords to split our binary options on
        let splitKeywords: [String] = ["versus", "verse", "vs", "or"]
        var potentialSplits: [[String]] = []
        
        // loop through splitKeywords and add to potential splits, map to remove whitespace
        for word in splitKeywords {
            let splitArr: [String] = userSpeech.components(separatedBy: word).map { $0.trim() }
            potentialSplits.append(splitArr)
        }
        return potentialSplits.filter({$0.count > 1}).first!
    }
}
