//
//  String.swift
//  TALATracker
//
//  Created by Frederik Lohner on 25/Nov/15.
//  Copyright © 2015 CSCI3308. All rights reserved.
//

import Foundation
extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}